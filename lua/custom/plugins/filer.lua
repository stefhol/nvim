-- filer: bundle source symbols (plus their imports/calls) for pasting into a chat.
-- Local plugin, source lives in the `mine` worktree of the bare repo:
-- ~/Work/filer-bare/branches/mine. The binary is the local build:
-- `cargo install --path ~/Work/filer-bare/branches/mine --force` (0.2.0, with .fe support).
return {
  {
    "stefhol/filer",
    name = "filer",
    cmd = { "FilerSearch", "FilerHere", "FilerBundle", "FilerDepth", "FilerSession" },
    keys = {
      { "<leader>fd", "<cmd>FilerDepth<cr>",                                                                   desc = "filer: show depth" },
      { "<leader>fc", function() require("filer").search() end,                                                desc = "filer: bundle for chat" },
      { "<leader>fs", "<cmd>FilerSession<cr>",                                                                 desc = "filer: switch session" },
      { "<leader>fh", function() require("filer").here() end,                                                  desc = "filer: bundle current file" },
      { "<leader>fC", function() require("filer").bundle({ vim.api.nvim_buf_get_name(0) }, { depth = 0 }) end, desc = "filer: bundle current file only" },
    },
    opts = {
      bin = nil,            -- $PATH (the release installer); set a path if not installed
      root = nil,           -- detect via .git / pom.xml / build.gradle(.kts) / build.sbt / ...
      depth = 2,            -- import hops to follow; change live with :FilerDepth
      same_package = false, -- also pull in sibling files of the same package
      with_config = false,  -- also add pom.xml / gradle / build.sbt / tsconfig / csproj
      split = "vsplit",     -- or "split", "tabnew"
      copy = false,         -- true = also copy the bundle to the system clipboard
      state = true,         -- remember the bundle and mark it in the picker
      state_file = nil,     -- nil = <root>/.filer/bundle.toml; opts out of sessions
    },
  }
}
