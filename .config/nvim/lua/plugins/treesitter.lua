return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    hightlight = { enable = true },
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "lua",
      "python",
      "vim",
      "vimdoc",
      "yaml",
    },

  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
