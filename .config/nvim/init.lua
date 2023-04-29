vim.cmd([[
call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'

Plug 'RRethy/nvim-base16'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/cmp-vsnip'

Plug 'folke/trouble.nvim'
call plug#end()

set termguicolors
colorscheme base16-default-dark

set number
set ruler
set colorcolumn=80
set laststatus=2
set showcmd
set cursorline
set lazyredraw
set backspace=2
set scrolloff=10
set listchars=space:·,trail:·,tab:▸\ ,nbsp:_,precedes:«,extends:»,eol:↲
set noswapfile
set splitright
set splitbelow

" Autocomplete filenames
set wildmenu
set wildignore=*.o,*.hi,*.pyc,*.pdf

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set iskeyword+=-

" Tabs and indents
set tabstop=4
set softtabstop=4 " Make spaces feel like real tabs
set expandtab " When pressing tab, insert [tabstop] spaces
set shiftwidth=4 " When indenting use x spaces
set autoindent " Keep indentation from previous line

" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=10

let NERDTreeIgnore = ['\.pyc$']

command! Format execute 'lua vim.lsp.buf.format({ async = false })'
autocmd! BufEnter,BufWritePost * silent Format

" Highlight whitespace errors
autocmd BufWinEnter * if &l:buftype == '' | match Error /\s\+$\|\t \| \t/
autocmd InsertLeave * match Error /\s\+$\|\t \| \t/

set omnifunc=v:lua.vim.lsp.omnifunc

augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END

autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
]])



vim.o.completeopt = "menu,menuone,noselect"

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  ignore_install = { "phpdoc" },
  indent = {
    enable = true
  }
}

local lspconfig = require'lspconfig'
lspconfig.gopls.setup{}
lspconfig.pyright.setup{}
lspconfig.dockerls.setup{}
lspconfig.cssls.setup{}
--lspconfig.html.setup{}
lspconfig.tsserver.setup{
    init_options = {documentFormatting = false},
    settings = {documentFormatting = false},
    indent = {
        enable = false
    },
    on_attach = function (client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
}

local black = require "efm/black"
local prettier = require "efm/prettier"
local shellcheck = require "efm/shellcheck"
local shfmt = require "efm/shfmt"

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = { "python", "sh", "markdown", "html", "typescript"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = { black },
            html = { prettier },
            typescript = { prettier },
            markdown = { prettier },
            sh = { shellcheck, shfmt },
        }
    }
}



local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!.git/'
    },
  }
}

require("trouble").setup {
}

require('lualine').setup {
  options = {
    theme  = 'auto',
    section_separators = '',
    component_separators = '',
  },
}

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require("neo-tree").setup {
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
}


vim.g.mapleader = ' '
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('', '<leader>l', ':set list! list?<cr>')
vim.keymap.set('', '<leader>w', ':set wrap! wrap?<cr>')
vim.keymap.set('', '<leader><space>', 'za')
vim.keymap.set('n', '<leader>h', ':noh<cr>')

vim.keymap.set('', '<leader>n', ':NERDTreeFind<cr>')
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<cr>')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>g', function() telescope_builtin.grep_string() end)
vim.keymap.set('n', '<C-p>', function() telescope_builtin.git_files() end)
vim.keymap.set('n', '<C-g>', function() telescope_builtin.live_grep() end)

-- The default comment hl is really really bad
vim.api.nvim_set_hl(0, "@comment", { link = "Special" })
