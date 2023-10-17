return {
  "nvimtools/none-ls.nvim",
  event = "LazyFile",
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local function async_formatting(bufnr)
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
          if
            not vim.api.nvim_buf_is_loaded(bufnr)
            or vim.api.nvim_buf_get_option(bufnr, "modified")
          then
            return
          end

          if res then
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            vim.lsp.util.apply_text_edits(
              res,
              bufnr,
              client and client.offset_encoding or "utf-16"
            )
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd("silent noautocmd update")
            end)
          end
        end
      )
    end

    local function on_attach(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePost", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            async_formatting(bufnr)
          end,
        })
      end
    end

    return {
      root_dir = require("null-ls.utils").root_pattern(
        ".null-ls-root",
        ".neoconf.json",
        "Makefile",
        ".git"
      ),
      on_attach = on_attach,
      sources = {
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettier.with({
          filetypes = { "html", "json", "yaml", "markdown", "xml" },
        }),
        nls.builtins.formatting.xmlformat,
        nls.builtins.formatting.tidy,
        nls.builtins.formatting.black,

        nls.builtins.diagnostics.flake8,
      },
    }
  end,
}
