return {
  {
    "folke/tokyonight.nvim",
    lazy = false,  -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "folke/which-key.nvim",           cmd = "WhichKey" },
  { "folke/neoconf.nvim",             cmd = "Neoconf" },
  { "RRethy/vim-illuminate",          lazy = true },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    opts = {
      user_default_options = {
        css = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        names = false,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
    opts = {
      options = {
        always_show_bufferline = true,
        -- separator_style = "slant",
      },
      highlights = {
        fill = {
          bg = {
            attribute = "bg",
            highlight = "bg_dark",
          },
        },
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = "tokyonight",
        disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree_1" } },
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    },
  },
  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", config = true, event = { "BufReadPost", "BufNewFile" } },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
}
