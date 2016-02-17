" extra-whitespace.vim - Highlight trailing and otherwise invalid whitespace in Vim.
" Maintainer:  Zachary Murray (dremelofdeath@gmail.com)
" Version:     1.0

if exists('g:loaded_zcm_extra_whitespace') || &cp
  finish
endif

let g:loaded_zcm_extra_whitespace = 1

if !exists('g:ExtraWhitespace_HighlightColor')
  let g:ExtraWhitespace_HighlightColor = 'red'
endif

let s:c = g:ExtraWhitespace_HighlightColor

if !exists('g:ExtraWhitespace_HighlightAllTabs')
  let g:ExtraWhitespace_HighlightAllTabs = 0
endif

" There are performance problems in versions <7.2 because successive calls to
" :match result in a memory leak. This is fixed in newer versions with a call to
" clearmatches() (which is unavailable in <7.2).
if version >= 702 && has('autocmd')
  exe 'hi ExtraWhitespace ctermbg=' . s:c . ' guibg=' . s:c

  aug ExtraWhitespacePlugin
    exe 'au ColorScheme * hi ExtraWhitespace ctermbg=' . s:c . ' guibg=' . s:c

    if g:ExtraWhitespace_HighlightAllTabs
      match ExtraWhitespace /\(\s\+$\|\t\+\)/
      au InsertEnter * match ExtraWhitespace /\(\s\+\%#\@<!$\|\t\+\)/
      au InsertLeave * match ExtraWhitespace /\(\s\+$\|\t\+\)/
    else
      match ExtraWhitespace /\s\+$/
      au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
      au InsertLeave * match ExtraWhitespace /\s\+$/
    endif

    au BufWinLeave * call clearmatches()
  aug END
endif
