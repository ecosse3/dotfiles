" Created by Lukasz Kurpiewski (luk.kurpiewski@gmail.com)
" Webpage: https://github.com/ecosse3

scriptencoding utf-8

function! airline#extensions#tabline#formatters#react#format(bufnr, buffers)
  let buf = bufname(a:bufnr)
  let filename = fnamemodify(buf, ':t')

  if filename == 'index.js' || filename == 'index.jsx' || filename == 'index.ts' || filename == 'index.tsx'
    return fnamemodify(buf, ':p:h:t') . '/i'
  elseif filename == 'styles.js' || filename == 'styles.ts' || filename == 'styles.jsx' || filename == 'styles.tsx' || filename == 'index.styles.js' || filename == 'index.styles.ts'
    return fnamemodify(buf, ':p:h:t') . '/s'
  else
    return airline#extensions#tabline#formatters#unique_tail_improved#format(a:bufnr, a:buffers)
  endif
endfunction
