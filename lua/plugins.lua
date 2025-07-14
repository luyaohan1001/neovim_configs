--[[
  This file is picked up by init.lua to configure plugins.
  After edit, do :source or :so to latch the changes.
]]

-- Load the package manager: packer.nvim through Vimscript API from Lua.
vim.cmd "packadd packer.nvim"


-- Init function for Packer, each use {} defines a table (key-value pair) configuration.
local function setup_plugins(use)

  -- plugin: packer, the package manager.
  use "wbthomason/packer.nvim"

  -- plugin: nvim-tree, visual studio code style file explorer.
  use { -- lua table
    "nvim-tree/nvim-tree.lua",
    requires = "nvim-tree/nvim-web-devicons",

    -- define config from anonymous function
    config = function()
      require("nvim-tree").setup()
      local api = require("nvim-tree.api")

      -- keybinding: open tree view
      vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

      -- keybinding: go up one directory level (change root to parent)
      vim.keymap.set("n", "<leader>[", function()
        api.tree.change_root_to_parent()
      end)

      -- keybinding: set current node as root
      vim.keymap.set("n", "<leader>r", function()
        api.tree.change_root_to_node()
      end)

      -- keybinding: find current file in tree
      vim.keymap.set("n", "<leader>f", ":NvimTreeFindFile<CR>")
    end

  }

  -- Plugin: VSCode-style Buffer Tabs
  use {
    "akinsho/bufferline.nvim",

    -- plugin that maps filetypes to icon glyphs (Unicode codepoints)
    -- in order for iterm2 to show correctly, download nerd font from https://www.nerdfonts.com/font-downloads
    requires = "nvim-tree/nvim-web-devicons",


    config = function()
      require("bufferline").setup()
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
      vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
    end

  }

  -- Plugin: diffview, similar to Git Lens in VSCode.
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("diffview").setup()
    end
  }

  -- Install markdown-preview.nvim
  use {
    'ellisonleao/glow.nvim',
    config = function()
      require('glow').setup()  -- This is required to initialize the plugin
      -- Optional: Keymapping to easily trigger the preview
      vim.api.nvim_set_keymap('n', '<Leader>mp', ':Glow<CR>', { noremap = true, silent = true })
    end
  }


  --[[ PlantUML preview
  use {
    "weirongxu/plantuml-previewer.vim",

    run = "brew install graphiz && brew install plantuml",

    requires = { 'vim-denops/denops.vim', 'tyru/open-browser.vim' },

    config = function()
      -- Set path to PlantUML jar file, find out by `brew list plantuml`:
      vim.g.plantuml_previewer_jar_path = "/opt/homebrew/Cellar/plantuml/1.2025.4/libexec/plantuml.jar"

      -- Choose preview method: 'browser', 'sakura', 'okular', etc.
      vim.g.plantuml_previewer_viewer = "browser"

      -- Optional: set PlantUML server URL for online rendering
      vim.g.plantuml_previewer_server = "http://www.plantuml.com/plantuml"

      vim.api.nvim_set_keymap("n", "<leader>pu", ":PlantumlPreview<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ps", ":PlantumlStopPreview<CR>", { noremap = true, silent = true })
    end
  }
  ]]


  -- Plugin: telescope with arg picker, such as searching speific file .
  use {
    "nvim-telescope/telescope-live-grep-args.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
  }

  -- Plugin: telescope, fuzzy finder and search tool.
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5', -- stable version
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
  
      telescope.setup {
        defaults = {
            layout_strategy = "vertical",
            layout_config = {
              vertical = {
                width = 0.9,
                height = 0.9,
                preview_height = 0.5,
              },
            },
            sorting_strategy = "ascending",
            prompt_prefix = "🔍 ",
            selection_caret = "➤ ",
            winblend = 0,
          }
      }

      telescope.load_extension("live_grep_args")
  
      -- Keymaps for Telescope pickers
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fc', builtin.live_grep,  { desc = "Live Grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = "Find Buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = "Find Help" })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git Commits" })
      vim.keymap.set('n', '<leader>gs', builtin.git_status,  { desc = "Git Status" })
      vim.keymap.set('n', '<leader>gl', builtin.git_bcommits, { desc = "Git Log (Buffer)" })

      -- 🔍 live_grep_args picker
      local lga = require("telescope").extensions.live_grep_args
      vim.keymap.set('n', '<leader>fa', lga.live_grep_args, { desc = "Live Grep (Args)" })
    end
  }


  -- Plugin: Terminal
  use {
    "akinsho/toggleterm.nvim", 

    tag = '*', 

    config = function()
      require("toggleterm").setup()
    end

  }


  -- Plugin: resolving git conflict
  use {
    'akinsho/git-conflict.nvim', 
    tag = "*", 
    config = function()
    require('git-conflict').setup()
  end}

  use "folke/tokyonight.nvim"
  require("tokyonight").setup({
    style = "storm",  -- 可选：storm / night / moon / day
    transparent = true,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      sidebars = "transparent",
      floats = "transparent",
    },
  })
  vim.cmd.colorscheme "tokyonight"

  
  -- Plugin: Language Server Protocol (LSP) for code intelligence
  use {
    'neovim/nvim-lspconfig',
  
    requires = {
      'williamboman/nvim-lsp-installer',
      'hrsh7th/nvim-cmp',               -- For autocompletion with LSP
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',               -- For snippets with LSP
      'saadparwaiz1/cmp_luasnip'
    },
  
    config = function()
      local lspconfig = require('lspconfig')
  
      lspconfig.clangd.setup {
        on_attach = function(client, bufnr)
          local opts = { noremap=true, silent=true, buffer=bufnr }
  
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gr", function()
            require('telescope.builtin').lsp_references()
          end)
  
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
        end
      }
    end
  }

-- end: setup_plugins
end

-- passing setup_plugins as init function to packer.
require("packer").startup(setup_plugins)



-- Used to escape from terminal opened in vim split, map <Esc> to <C-\><C-n>.
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- keymaps for plugins
vim.api.nvim_set_keymap('n', '<leader>s', ':PackerSync<CR>', { noremap = true, silent = true })
