" Created by Lukasz Kurpiewski (luk.kurpiewski@gmail.com)
" Webpage: https://github.com/ecosse3

function! airline#extensions#tabline#formatters#dir_filename_devicons#format(bufnr, buffers) abort
  return fnamemodify(bufname(a:bufnr), ':p:h:t') . '/' . fnamemodify(bufname(a:bufnr), ':t')
endfunction
