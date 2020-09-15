#!/usr/bin/env vim


vnoremap <S-K> :call Nudge_Selection__Laterally(-1, 'reformat')<CR>
vnoremap <C-K> :call Nudge_Selection__Laterally(-1)<CR>

vnoremap <S-J> :call Nudge_Selection__Laterally(1, 'reformat')<CR>
vnoremap <C-J> :call Nudge_Selection__Laterally(1)<CR>


""
" Nudges visually selected lines up or down
" @param {number} a:amount - Signed integer of lines to nudge selection by
" @param {string[]} a:0 - Optionally "reformat" tabs
" @example
"   :'<,'> call Nudge_Selection__Laterally(-1, 'reformat')
" @author S0AndS0
" @license AGPL-3.0
function! Nudge_Selection__Laterally(amount, ...) abort range
  let l:not_visual_mode = visualmode() != 'V'
  let l:at_limits__lower = a:lastline == line('$')
  let l:at_limits__upper = a:firstline == 1
  if l:not_visual_mode
  \ || (a:amount > 0 && l:at_limits__lower)
  \ || (a:amount < 0 && l:at_limits__upper)
    normal! gv
    return
  endif

  if a:amount > 0
    let l:move_command = "'>+" . a:amount
  elseif a:amount < 0
    let l:move_command = "'<-" . (1 - a:amount)
  else
    throw 'amount must be greater or less than 0'
  endif

  execute "'<,'>move " . l:move_command

  if a:0 == 0
    normal! gv
  else
    normal! gv=gv
  endif

  silent! foldopen!
endfunction

