if has("nvim")
    tnoremap <Esc> <C-\><C-n>

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

local lspconfig = require'lspconfig'
lspconfig.gopls.setup{
  root_dir = lspconfig.util.root_pattern('.git');
}

vim.o.completeopt = "menuone,noselect"
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    nvim_lsp = true;
    nvim_lua = true;
  };
}

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

let g:neomake_verbose = 0
autocmd! BufEnter,BufWritePost * Neomake

let g:python_highlight_all = 1

let g:terraform_fmt_on_save=1

let g:shfmt_fmt_on_save = 1
let g:shfmt_extra_args = '-i 4'

let NERDTreeIgnore = ['\.pyc$']
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

let g:grepper = { 'tools': ['git', 'ag', 'grep'] }

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
  set t_Co=256
  colorscheme desert256
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

set listchars=space:·,trail:·,tab:▸\ ,nbsp:_,precedes:«,extends:»,eol:↲

filetype indent on
filetype plugin on

let python_highlight_all=1

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
