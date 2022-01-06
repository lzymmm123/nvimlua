require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  --highlight = {
    --enable = False,
    --use_languagetree = true,
  --},
  indent = { enable = false, },
  incremental_selection = { enable = true },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
  },
}
