if has("nvim")
    tnoremap <Esc> <C-\><C-n>

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'editorconfig/editorconfig-vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'petertriho/cmp-git'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/cmp-vsnip'

call plug#end()

lua <<EOF
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
lspconfig.html.setup{}
lspconfig.tsserver.setup{}

local black = require "efm/black"
local prettier = require "efm/prettier"
local shellcheck = require "efm/shellcheck"
local shfmt = require "efm/shfmt"

lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = { "python", "sh", "markdown" },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = { black },
            html = { prettier },
            markdown = { prettier },
            sh = { shellcheck, shfmt },
        }
    }
}

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

vim.o.completeopt = "menu,menuone,noselect"

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

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
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
EOF
endif

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

"autocmd! BufEnter,BufWritePost * Format

let g:terraform_fmt_on_save=1

let NERDTreeIgnore = ['\.pyc$']
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>

"let g:grepper = { 'tools': ['git', 'ag', 'grep'] }

nnoremap <leader>g <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <C-g> <cmd>lua require('telescope.builtin').live_grep()<cr>

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ }

syntax on
set background=dark

if v:version >= 800 || has("nvim") && match($TERM, "screen") == -1
  set termguicolors
  colorscheme base16-default-dark
  " The default comment hl is really really bad
  highlight! link Comment Special
else
  colorscheme default
endif

set number
set ruler
set laststatus=2
set showcmd
set cursorline
set lazyredraw
set backspace=2
set scrolloff=10

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

" Highlight whitespace errors and line length
autocmd BufWinEnter * if &l:buftype != 'help' | match Error /\s\+$\|\t \| \t/
autocmd InsertLeave * match Error /\s\+$\|\t \| \t/
set colorcolumn=80

augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END

set listchars=space:·,trail:·,tab:▸\ ,nbsp:_,precedes:«,extends:»,eol:↲

filetype indent on
filetype plugin on

let mapleader = "\<Space>"
map <leader>w :set wrap! wrap?<cr>
map <leader>p :set paste!<cr>
map <silent> <leader>n :set number!<cr>
map <leader>l :set list! list?<cr>
map <leader>x :set cursorline!<cr>
map <leader>s :setlocal spell! spelllang=en_us<cr>
map <leader><space> za
nmap <silent> <leader>h :noh<cr>

autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
