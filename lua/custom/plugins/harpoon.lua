return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()

    vim.keymap.set("n", "<leader>m", function()
      require("harpoon.mark").add_file()
    end)
    vim.keymap.set("n", "<leader>h", function()
      require("harpoon.ui").toggle_quick_menu()
    end)

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set("n", string.format("<space>%d", idx), function()
        require("harpoon.ui").nav_file(3)
      end)
    end
  end,
}
