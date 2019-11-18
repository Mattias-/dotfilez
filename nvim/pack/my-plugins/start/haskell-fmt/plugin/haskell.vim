function! haskell#fmt()
    let l:cursor_position = getcurpos()

    silent execute '%!hindent'
	if v:shell_error
		execute 'echom "hindent returned an error, undoing changes. Often a syntax error, so check that."'
		undo
	endif
    silent execute '%!stylish-haskell'
	if v:shell_error
		execute 'echom "stylish-haskell returned an error, undoing changes. Often a syntax error, so check that."'
		undo
	endif

    if l:cursor_position != getcurpos()
        call setpos('.', l:cursor_position)
    endif
endfunction

augroup haskell.fmt
    autocmd!
    autocmd BufWritePre *.hs call haskell#fmt()
augroup END
