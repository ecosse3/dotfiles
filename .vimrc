" -------------------- General Settings ---------------------

syntax on                       " Enables syntax highlighting
filetype plugin indent on       " Enables plugin & indent

set hidden                      " Required to keep multiple buffers open multiple buffers
set encoding=utf-8              " The encoding displayed
set fileencoding=utf-8          " The encoding written to file
set cmdheight=2                 " Give more space for displaying messages
set splitright                  " Vertical splits will automatically be to the right
set updatetime=300              " Faster completion
set timeoutlen=500              " Faster completion
set clipboard=unnamedplus       " Copy-paste between vim and everything else
set mouse=a                     " Enable mouse
set tabstop=2 softtabstop=2     " Insert 2 spaces for a tab
" set shiftwidth=2                " Change a number of space characeters inseted for indentation
" set expandtab                   " Converts tab to spaces
set smartindent                 " Makes indenting smart
set smartcase                   " Uses case in search
set smarttab                    " Makes tabbing smarter will realize you have 2 vs 4
set showtabline=2               " Always show tabs
set noshowmode                  " Don't show things like -- INSERT -- anymore
set autoindent                  " Good auto indent
set nu                          " Shows current line number
set relativenumber              " Enables relative number
set noerrorbells                " Disables sound effect for errors
set nowrap                      " Display long lines as just one line
set nobackup                    " Recommended by coc
set noswapfile                  " Recommended by coc
set undodir=~/.vim/undodir      " Dir for undos
set undofile                    " Sets undo to file
set incsearch                   " Start searching before pressing enter
set cursorline                  " Highlight of current line
set formatoptions-=cro          " Stop newline continuation of comments
set t_Co=256                    " Support 256 colors
set backspace=indent,eol,start  " Making sure backspace works
"set autowriteall               " Auto-saves buffers

" Check if terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE ctermfg=15 ctermbg=7 guibg=NONE guifg=NONE gui=NONE
endif

" ---------------------- Plugins (VimPlug) ----------------------
call plug#begin('~/.vim/plugged')

" General
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'luochen1990/rainbow'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'ThePrimeagen/vim-be-good'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-startify'
Plug 'dhruvasagar/vim-table-mode'

" Snippets & Language
Plug 'honza/vim-snippets'
Plug 'ianks/vim-tsx'
Plug 'yuezk/vim-js'
Plug 'mxw/vim-jsx'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'mlaursen/vim-react-snippets'
Plug 'potatoesmaster/i3-vim-syntax'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'sbdchd/neoformat'
Plug 'jiangmiao/auto-pairs'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sheerun/vim-polyglot'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rhysd/git-messenger.vim'

" Tags
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'

" Themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'mhartington/oceanic-next'
Plug 'skbolton/embark'

" Colorscheme
Plug 'powerline/powerline'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'airblade/vim-rooter'
"{{{
    let $FZF_DEFAULT_COMMAND="fd --hidden --type f --exclude .git"
    let $FZF_DEFAULT_OPTS="--reverse || --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null'"
    let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
    let g:fzf_nvim_statusline = 0
    let g:fzf_checkout_track_key = 'ctrl-t'
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


" --------------------- Colorscheme & Airline ---------------------
colorscheme onedark

hi Comment cterm=italic

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" --------------------- Config ---------------------
let mapleader = "\<Space>"

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_fastbrowse = 0
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:rainbow_active = 1

let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-tsserver', 'coc-tslint-plugin', 'coc-eslint', 'coc-emmet', 'coc-prettier', 'coc-angular', 'coc-snippets', 'coc-css', 'coc-html']
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:closetag_filenames = '*.html,*.xhtml,*.js,*.jsx,*.tsx,*.xml'

let g:signify_sign_delete = '-'

lua require'colorizer'.setup()

" --------------------- Neoformat ------------------
autocmd FileType javascript setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es6
autocmd FileType javascriptreact setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es6
autocmd FileType javascript.jsx setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es6

autocmd FileType typescript setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es6
autocmd FileType typescriptreact setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es6
autocmd FileType typescript.tsx setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ es6

let g:neoformat_enabled_javascript = ['prettier-eslint', 'prettier']
let g:neoformat_enabled_typescript = ['prettier', 'tslint']
let g:neoformat_enabled_css = ['prettier-eslint', 'prettier']
let g:neoformat_enabled_json = ['prettier-eslint', 'prettier']
" Use formatprg when available
let g:neoformat_try_formatprg = 1

" --------------------- Remaps ---------------------
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Save by CTRL-S
nnoremap <silent> <c-s> :w<CR>
inoremap <silent> <c-s> <ESC> :w<CR>

" Undotree
nnoremap <leader>u :UndotreeShow<CR>

" Make word uppercase
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<ESC>

nnoremap <silent> <Leader>+ :vertical resize +2<CR>
nnoremap <silent> <Leader>- :vertical resize -2<CR>

"Move selected lines up-down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Keep visual mode indenting
vnoremap < <gv
vnoremap > >gv

"Easymotion
map <silent> <Leader>e <Plug>(easymotion-bd-w)
map f <Plug>(easymotion-bd-f)
map F <Plug>(easymotion-linebackward)

"Neoformat
nnoremap <Leader>gp :Neoformat<CR>

"Fzf
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <s-p> :Rg<CR>

"Git
nnoremap <Leader>cc :Gcommit -m "
nnoremap <Leader>gc :GCheckout<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gj :diffget //3<CR>
nnoremap <Leader>gf :diffget //2<CR>

"Tabs
nnoremap H gT
nnoremap L gt

"Buffers
nnoremap <silent> <c-b> :Buffers<CR>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> gn :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> gp :bp<CR>
nnoremap <silent> <s-q> :bd<CR>

"Remove highlights
nnoremap <silent> <CR> :noh<CR><CR>

"CoC
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <buffer> <silent><expr> <C-space> coc#refresh()
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

map <silent> <Leader>ce :CocCommand explorer<CR>
map <silent> <c-e> :CocCommand explorer --position floating<CR>
nnoremap <buffer> <Leader>cr :CocRestart

vmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)

nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>rf <Plug>(coc-refactor)
nmap <Leader>qf <Plug>(coc-fix-current)
nmap <Leader>do <Plug>(coc-codeaction)
nmap <C-Space> <Plug>(coc-codeaction)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent>K :call <SID>show_documentation()<CR>

" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" GoTo code navigation.
nmap <buffer> <Leader>gd <Plug>(coc-definition)
nmap <buffer> <Leader>gy <Plug>(coc-type-definition)
nmap <buffer> <Leader>gi <Plug>(coc-implementation)
nmap <buffer> <Leader>gr <Plug>(coc-references)

" Don't yank on delete char
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

" --------------------- Functions & Settings ---------------------

"map :q to buffer delete
cnoreabbrev <expr> q getcmdtype() == ":" && (getcmdline() == 'q' && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1) ? 'bd' : 'q'

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

" advanced ripgrep integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Show documentation in preview window
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight on yank
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" --------------------- Startify ---------------------

let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory: '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]

let g:startify_session_autoload = 0
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
