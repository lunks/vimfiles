return {
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    opts = {
      transparent = true, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    }
  },
  { "folke/tokyonight.nvim",  enabled = false },
  { 'lifepillar/vim-gruvbox8' },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require 'gruvbox'.setup {
        contrast = 'hard',
        dim_inactive = true,
        transparent_mode = true,
      }
      vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = 'virtual',
      virtual_symbol = '◉',
      virtual_symbol_suffix = '',
      virtual_symbol_position = 'eol',
      enable_tailwind = true
    }
  },
  {
    'RRethy/base16-nvim'
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    enabled = false,
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    }
  }

}
