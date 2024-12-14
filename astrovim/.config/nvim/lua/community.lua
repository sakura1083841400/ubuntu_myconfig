-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- plugins

  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  -- { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.cpp" },
  -- { import = "astrocommunity.pack.php" },
  -- { import = "astrocommunity.pack.html-css" },
  -- { import = "astrocommunity.pack.json" },
  -- { import = "astrocommunity.pack.vue" },
  -- { import = "astrocommunity.pack.cmake" },
  -- { import = "astrocommunity.pack.bash" },
  -- { import = "astrocommunity.pack.kotlin" },
  -- { import = "astrocommunity.pack.docker" },
  -- { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.pack.sql" },
  -- { import = "astrocommunity.pack.scala" },
  -- { import = "astrocommunity.pack.python-ruff" },
  -- { import = "astrocommunity.pack.xml" },
  -- { import = "astrocommunity.pack.verilog" },
  -- { import = "astrocommunity.pack.yaml" },
}
