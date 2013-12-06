syntax on
set t_Co=256
colorscheme desert256
set number
set ruler
set laststatus=2
set hlsearch

set expandtab "When pressing tab, insert [tabstop] spaces

set tabstop=4
set shiftwidth=4 "When indenting use x spaces
set softtabstop=4   " makes the spaces feel like real tabs

"autocmd FileType html,javascript set tabstop=2|set shiftwidth=2
"autocmd FileType python set tabstop=4|set shiftwidth=4

" Set folding
set foldmethod=indent
set foldlevel=20

"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

let python_highlight_all=1    
set colorcolumn=81

filetype indent on
filetype plugin on
set autoindent
