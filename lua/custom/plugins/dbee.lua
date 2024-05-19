-- For now, I'm going to stick with dadbod,
-- but if the completion continues to improve I will probably switch
return {
  {
    "kndndrj/nvim-dbee",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      require("dbee").install()
    end,
    config = function()
      local source = require "dbee.sources"
      require("dbee").setup {
        sources = {
          source.MemorySource:new(),
        },
      }
      require "custom.dbee"
    end,
  },
}
