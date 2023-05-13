require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "vim", "python", "go", "bash", "dockerfile", "hcl", "json", "markdown", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
    -- enable indentation
  indent = { enable = true },
}
