local lspconfig = require "lspconfig"
local mason_registry = require "mason-registry"
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"

lspconfig.ts_ls.setup {
  -- Initial options for the TypeScript language server
  init_options = {
    plugins = {
      {
        -- Name of the TypeScript plugin for Vue
        name = "@vue/typescript-plugin",

        -- Location of the Vue language server module (path defined in step 1)
        location = vue_language_server_path,

        -- Specify the languages the plugin applies to (in this case, Vue files)
        languages = { "vue" },
      },
    },
  },

  -- Specify the file types that will trigger the TypeScript language server
  filetypes = {
    "typescript", -- TypeScript files (.ts)
    "javascript", -- JavaScript files (.js)
    "javascriptreact", -- React files with JavaScript (.jsx)
    "typescriptreact", -- React files with TypeScript (.tsx)
    "vue", -- Vue.js single-file components (.vue)
  },
}
