local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("luavim.lsp.lsp_installer")
require("luavim.lsp.handlers").setup()
require("luavim.lsp.null-ls")
