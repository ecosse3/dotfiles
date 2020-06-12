" -------------------- General Settings ---------------------

syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set cursorline
set termguicolors

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
Plug 'scrooloose/nerdTree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

" Snippets & Language
Plug 'honza/vim-snippets'
Plug 'yuezk/vim-js'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
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
"set background=dark
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" --------------------- Config ---------------------
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:rainbow_active = 1

let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-emmet', 'coc-tslint', 'coc-prettier', 'coc-angular', 'coc-snippets']
"command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:closetag_filetypes = 'html,xhtml,js,jsx,tsx,xml'

" --------------------- Remaps ---------------------
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>ps :Rg<SPACE>

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<ESC>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

map <C-e> :NERDTreeFind<CR>
map <leader> <Plug>(easymotion-prefix)

nnoremap <silent> <c-p> :Files<CR>

"Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>ga :Git add %:p<CR><CR>

"Tabs
nnoremap H gT
nnoremap L gt

"Buffers
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> gn :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> gp :bp<CR>

"CoC
inoremap <buffer> <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <buffer> <silent><expr> <C-space> coc#refresh()

inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" GoTo code navigation.
nmap <buffer> <leader>gd <Plug>(coc-definition)
nmap <buffer> <leader>gy <Plug>(coc-type-definition)
nmap <buffer> <leader>gi <Plug>(coc-implementation)
nmap <buffer> <leader>gr <Plug>(coc-references)
nnoremap <buffer> <leader>cr :CocRestart

" --------------------- Functions ---------------------

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
"autocmd FileType typescript :call GoYCM()
"autocmd FileType cpp,cxx,h,hpp,c :call GoCoc()

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

augroup nerdtreeconcealbrackets
      autocmd!
      autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
      autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
      autocmd FileType nerdtree setlocal conceallevel=2
      autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END
