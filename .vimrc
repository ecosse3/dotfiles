" -------------------- General Settings ---------------------

syntax on                       " Enables syntax highlighting

set encoding=utf-8              " The encoding displayed
set fileencoding=utf-8          " The encoding written to file
set hidden                      " Required to keep multiple buffers open multiple buffers
set splitright                  " Vertical splits will automatically be to the right
set updatetime=300              " Faster completion
set timeoutlen=500              " Faster completion
set clipboard=unnamedplus       " Copy-paste between vim and everything else
set mouse=a                     " Enables mouse
set tabstop=4 softtabstop=4     " Inset 4 spaces for a tab
set shiftwidth=4                " Change a number of space characeters inseted for indentation
set expandtab                   " Converts tab to spaces
set smartindent                 " Makes indenting smart
set smartcase                   " Uses case in search
set nu                          " Shows current line number
set relativenumber              " Enables relative number
set noerrorbells                " Disables sound effect for errors
set nowrap                      " Display long lines as just one line
set nobackup                    " Recommended by coc
set noswapfile                  " Recommended by coc
set undodir=~/.vim/undodir      " Dir for undos
set undofile                    " Sets undo to file
set incsearch                   " Search is incremental
set cursorline                  " Highlight of current line
set termguicolors               " Takes colors from terminal
set autowriteall                " Auto-saves buffers
set formatoptions-=cro          " Stop newline continuation of comments

highlight ColorColumn ctermbg=0

" ---------------------- Plugins (VimPlug) ----------------------
call plug#begin('~/.vim/plugged')

" General
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'luochen1990/rainbow'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'ThePrimeagen/vim-be-good'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'

" Snippets & Language
Plug 'honza/vim-snippets'
Plug 'yuezk/vim-js'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mattn/emmet-vim'
Plug 'mlaursen/vim-react-snippets'
Plug 'potatoesmaster/i3-vim-syntax'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'

" Tags
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'

" Themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'mhartington/oceanic-next'

" Colorscheme
Plug 'powerline/powerline'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'

" Fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
"{{{
    let $FZF_DEFAULT_COMMAND="fd --type f --exclude .git"
    let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"
    let g:fzf_layout = { 'down': '30%' }
    let g:fzf_nvim_statusline = 0
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'Conditional', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'Conditional', 'Conditional'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
"}}}

call plug#end()


" --------------------- Colorscheme ---------------------
colorscheme onedark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" --------------------- Config ---------------------
let mapleader = "\<Space>"

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:rainbow_active = 1

let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-tsserver', 'coc-emmet', 'coc-tslint', 'coc-prettier', 'coc-angular', 'coc-snippets', 'coc-css', 'coc-html']
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.tsx,*.xml'

let g:prettier#config#single_quote = 'true'

" --------------------- Remaps ---------------------
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" Make word uppercase
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<ESC>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

"Move selected lines up-down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Easymotion
map <silent> <Leader>e <Plug>(easymotion-bd-w)

"Prettier
nnoremap <Leader>p :Prettier --single-quote<CR>

"Fzf
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <Leader>rg :Rg<CR>

"Git
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gl :Glog<CR>

"Tabs
nnoremap H gT
nnoremap L gt

"Buffers
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> gn :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> gp :bp<CR>
nnoremap <silent> <s-q> :bd<CR>

"CoC
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <buffer> <silent><expr> <C-space> coc#refresh()
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

map <silent> <c-e> :CocCommand explorer<CR>
nnoremap <buffer> <Leader>cr :CocRestart

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" GoTo code navigation.
nmap <buffer> <leader>gd <Plug>(coc-definition)
nmap <buffer> <Leader>gy <Plug>(coc-type-definition)
nmap <buffer> <Leader>gi <Plug>(coc-implementation)
nmap <buffer> <Leader>gr <Plug>(coc-references)

" --------------------- Functions & Settings ---------------------

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace() " trim white-spaces on entry
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif " close coc-explorer if it's last active window

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" rg with fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" --------------------- Startify ---------------------

let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory: '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]

let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

let g:webdevicons_enable_startify = 1

function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    endfunction

let g:startify_bookmarks = [
            \ { 'c': '~/.config/i3/config' },
            \ { 'v': '~/.vimrc' },
            \ { 'z': '~/.zshrc' },
            \ ]

let g:startify_enable_special = 0
