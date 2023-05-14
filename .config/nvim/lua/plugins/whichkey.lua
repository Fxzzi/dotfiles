return {
  {
    "folke/which-key.nvim",
    -- event = "VeryLazy",
    keys = { "<leader>", '"', "'", "`", "c", "v" },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        key_labels = {
          ["<leader>"] = "SPACE",
          ["<space>"] = "SPACE"
        }
      })
    end,
  },
}
