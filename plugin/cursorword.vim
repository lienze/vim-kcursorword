" =============================================================================
" Filename: plugin/cursorword.vim
" Author: itchyny
" License: MIT License
" Last Change: 2020/05/01 19:05:29.
" =============================================================================

if exists('g:loaded_cursorword') || v:version < 703
  finish
endif
let g:loaded_cursorword = 1

let s:save_cpo = &cpo
set cpo&vim

augroup cursorword
  autocmd!
  if has('vim_starting')
    "echo 'vim_starting'
    if exists('g:kcursorword_kernelsource') && g:kcursorword_kernelsource == 1
      autocmd cursorword WinEnter,BufEnter * call data#init()
    endif
    autocmd VimEnter * call cursorword#highlight() |
          \ autocmd cursorword WinEnter,BufEnter * call cursorword#matchadd()
  else
    call cursorword#highlight()
    autocmd WinEnter,BufEnter * call cursorword#matchadd()
  endif
  autocmd ColorScheme * call cursorword#highlight()
  autocmd CursorMoved,CursorMovedI * call cursorword#cursormoved()
  autocmd InsertEnter * call cursorword#matchadd(1)
  autocmd InsertLeave * call cursorword#matchadd(0)
augroup END

command! -nargs=? -complete=buffer -bang ToggleKCursorword
    \ call ToggleKCursorword()

function ToggleKCursorword()
  "echo 'ToggleKCursorword'
  if exists('g:kcursorword_kernelsource') && g:kcursorword_kernelsource == 1
     let g:kcursorword_kernelsource = 0
     call data#release()
  else
     let g:kcursorword_kernelsource = 1
     call data#init()
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
