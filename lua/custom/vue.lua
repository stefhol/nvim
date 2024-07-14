local mason_packages = vim.fn.stdpath "data" .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"
local lspconfig = require "lspconfig"
lspconfig.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volar_path,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },

  lspconfig.volar.setup {
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  },
}
lspconfig.eslint.setup {
  on_attach = function(_client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
