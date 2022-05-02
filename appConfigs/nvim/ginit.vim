" Nvim-qt settings "


" Font:

    let start_font_size = 13
    let s:fontsize = start_font_size
    :execute "GuiFont! DejaVu Sans Mono:h" . s:fontsize


" Functions:

    " https://stackoverflow.com/questions/35285300/how-to-change-neovim-font "
    function! AdjustFontSize(amount)
        let s:fontsize = s:fontsize+a:amount
        :execute "GuiFont! DejaVu Sans Mono:h" . s:fontsize
    endfunction


" Keybindings:

    noremap  <C-ScrollWheelUp>      :call AdjustFontSize(1)<CR>
    noremap  <C-ScrollWheelDown>    :call AdjustFontSize(-1)<CR>
    inoremap <C-ScrollWheelUp>      <Esc>:call AdjustFontSize(1)<CR>a
    inoremap <C-ScrollWheelDown>    <Esc>:call AdjustFontSize(-1)<CR>a

    " ctrl + numpad+/-: Increase the font
    noremap  <C-kPlus>  :call AdjustFontSize(1)<CR>
    noremap  <C-kMinus> :call AdjustFontSize(-1)<CR>
    inoremap <C-kPlus>  <Esc>:call AdjustFontSize(1)<CR>a
    inoremap <C-kMinus> <Esc>:call AdjustFontSize(-1)<CR>a
