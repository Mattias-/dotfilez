" Vim syntax file
" " Language: bnfc

if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "bnfc"

" Keywords
syn keyword keywords terminator separator rules nonempty token
syn keyword keywords comment coercions entrypoints

" Types
syn keyword types Integer Double String Ident

" Operators
syn match operators '::='

" Labels
syn match labels '^[a-zA-Z0-9]*\.'

" String
syn region string start='"' end='"'

" Comments
syn keyword todo contained TODO FIXME XXX NOTE
syn match comments "--.*$" contains=celTodo

hi def link keywords   Keyword
hi def link operators  Operator
hi def link labels     Identifier
hi def link string     Constant
hi def link types      Type
hi def link todo       Todo
hi def link comments   Comment
