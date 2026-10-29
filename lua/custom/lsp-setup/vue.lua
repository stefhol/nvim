local vue_language_server_path = vim.fn.expand "$MASON/packages"
  .. "/vue-language-server"
  .. "/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
-- vtsls only handles Vue SFC; it is the TypeScript backend for vue_ls.
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { "vue" },
}

-- ts_ls handles React/TypeScript/JavaScript via its lspconfig defaults
-- (filetypes: typescript, javascript, javascriptreact, typescriptreact).
local vue_ls_config = {}

vim.lsp.config("vtsls", vtsls_config)
-- `ts_ls` uses lspconfig defaults; an explicit config call registers it.
vim.lsp.config("ts_ls", {})
vim.lsp.config("vue_ls", vue_ls_config)

vim.lsp.enable { "vtsls", "vue_ls", "ts_ls" }
