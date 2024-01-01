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
Plug 'jose-elias-alvarez/null-ls.nvim'

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

command! Format execute 'call Format()'
autocmd! BufEnter,BufWritePost * silent call Format()

function! Format()
  if &readonly != 1
    lua vim.lsp.buf.format({ async = false })
  endif
endfunction

" Highlight whitespace errors
autocmd BufWinEnter * if &l:buftype == '' | match Error /\s\+$\|\t \| \t/
autocmd InsertLeave * if &l:buftype == '' | match Error /\s\+$\|\t \| \t/

set omnifunc=v:lua.vim.lsp.omnifunc

augroup templates
  au!
  autocmd BufNewFile *.* silent! execute '0r ~/.config/nvim/templates/skeleton.'.expand("<afile>:e")
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
lspconfig.gopls.setup{
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      codelenses = {
        tidy = false,
      },
    }
  }
}
lspconfig.pyright.setup{}
lspconfig.dockerls.setup{}
lspconfig.bashls.setup{}
lspconfig.cssls.setup{}
lspconfig.biome.setup{
    cmd = {"./node_modules/@biomejs/biome/bin/biome", "lsp-proxy"},
    root_dir = lspconfig.util.root_pattern('biome.json'),
    single_file_support = false,
}
--lspconfig.html.setup{}
lspconfig.tsserver.setup{
    init_options = {documentFormatting = false},
    settings = {documentFormatting = false},
    indent = {
        enable = true
    },
    on_attach = function (client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
}

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt.with({
            filetypes = {"sh", "zsh"},
            extra_args = { "-i=4" },
        }),
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.black,
        --null_ls.builtins.code_actions.eslint,
        --null_ls.builtins.diagnostics.eslint,

    },
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


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
        filesystem = {
        group_empty_dirs = true,
        filtered_items = {
            --visible = true,
            hide_dotfiles = false,
        },
        },
}


vim.g.mapleader = ' '
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('', '<leader>l', ':set list! list?<cr>')
vim.keymap.set('', '<leader>w', ':set wrap! wrap?<cr>')
vim.keymap.set('', '<leader><space>', 'za')
vim.keymap.set('n', '<leader>h', ':noh<cr>')

vim.keymap.set('', '<leader>n', ':Neotree reveal<cr>')
vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>g', function() telescope_builtin.grep_string() end)
vim.keymap.set('n', '<C-p>', function() telescope_builtin.git_files() end)
vim.keymap.set('n', '<C-g>', function() telescope_builtin.live_grep() end)

-- The default comment hl is really really bad
vim.api.nvim_set_hl(0, "@comment", { link = "Special" })
vim.api.nvim_set_hl(0, "Comment", { link = "Special" })
