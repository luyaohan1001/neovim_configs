-- ========================
-- BASIC NEOVIM SETTINGS
-- ========================

-- Enable line numbers
vim.opt.number = true            -- Show absolute line number
vim.opt.relativenumber = false    -- Show relative line numbers

-- Tabs & Indentation
vim.opt.tabstop = 4              -- Number of spaces per tab
vim.opt.shiftwidth = 4           -- Number of spaces to use for autoindent
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.smartindent = true       -- Smart auto-indenting on new lines

-- UI settings
vim.opt.cursorline = true        -- Highlight the current line
vim.opt.wrap = false             -- Don't wrap long lines
vim.opt.scrolloff = 8            -- Keep 8 lines above/below cursor
vim.opt.signcolumn = "yes"       -- Always show the sign column

-- Search
vim.opt.ignorecase = true        -- Ignore case in search
vim.opt.smartcase = true         -- Override ignorecase if uppercase letters are used
vim.opt.incsearch = true         -- Show search matches while typing
vim.opt.hlsearch = true          -- Highlight search matches

-- Clipboard (use system clipboard)
vim.opt.clipboard = "unnamedplus"

-- Mouse support
vim.opt.mouse = "a"

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true          -- Enable persistent undo

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Appearance
vim.opt.termguicolors = true     -- Enable true color support
vim.opt.background = "dark"      -- Set background for theme
vim.cmd("syntax on") -- Classic vim command in Lua
-- Use a default one (like 'desert', 'elflord', 'evening', 'morning', etc.)
vim.cmd("colorscheme elflord")

-- Split windows
vim.opt.splitbelow = true        -- New horizontal split below
vim.opt.splitright = true        -- New vertical split right

-- Timeouts
vim.opt.timeoutlen = 300         -- Time to wait for a mapped sequence (ms)

-- Show matching brackets
vim.opt.showmatch = true
