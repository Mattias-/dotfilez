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


"Over 80
autocmd FileType python,javascript highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
autocmd FileType python,javascript  match OverLength /\%81v.*/

let python_highlight_all=1

filetype indent on
filetype plugin on
set autoindent
