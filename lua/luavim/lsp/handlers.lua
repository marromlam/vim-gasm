local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  core.noremap({ "n" }, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
  core.noremap({ "n" }, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
  core.noremap({ "n" }, "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show information")
  core.noremap({ "n" }, "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
  core.noremap({ "n" }, "g?", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature")
  core.noremap({ "n" }, "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Show references")
  core.noremap({ "n" }, "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
  core.noremap({ "n" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action")
  -- core.noremap({ "n" }, "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostic float")
  core.noremap(
    { "n" },
    "<leader>ll",
    '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
    "Show line diagnostics"
  )
  core.noremap(
    { "n" },
    "[d",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    "Go to previous diagnostic"
  )
  core.noremap({ "n" }, "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', "Go to next diagnostic")
  core.noremap({ "n" }, "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Diagss")
  core.noremap({ "n" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", "Diagss")
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "textDocument/formatting",
    { textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd "silent noautocmd update"
        end)
      end
    end
  )
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
  -- if client.name == "tsserver" then
  -- 	client.server_capabilities.document_formatting = false
  -- end
  --  if client.server_capabilities.document_formatting then
  --      vim.cmd([[
  --      augroup LspFormatting
  --          autocmd! * <buffer>
  --          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
  --      augroup END
  --      ]])
  --  end
  -- --------------------------------------------------------
  -- --------------------------------------------------------
  -- --------------------------------------------------------
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        async_formatting(bufnr)
      end,
    })
  end
  -- --------------------------------------------------------
  -- --------------------------------------------------------
  -- --------------------------------------------------------
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
else
  return
end

return M
