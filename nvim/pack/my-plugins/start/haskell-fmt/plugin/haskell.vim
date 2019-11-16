function! haskell#fmt()
    let l:cursor_position = getcurpos()

    silent execute '%!hindent'
    silent execute '%!stylish-haskell'

    if l:cursor_position != getcurpos()
        call setpos('.', l:cursor_position)
    endif
endfunction

augroup haskell.fmt
    autocmd!
    autocmd BufWritePre *.hs call haskell#fmt()
augroup END
