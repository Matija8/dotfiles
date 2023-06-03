" Settings:

    " Ui "
    syntax on                           " Syntax highlighting.
    set number                          " Show line numbers.
    " set rnu                           " Relative line numbers.
    set nornu                           " Normal line numbers.
    set ruler                           " Always shows location in file (line #).
    set showcmd                         " Show commands. Useful for leader timeout.
    set showmatch                       " Shows matching brackets.
    set nohlsearch                      " Don't highlight search (/?) items.
    set cursorline                      " Highlight current line.
    set showtabline=2                   " Always show open tabs!
    set lazyredraw                      " Buffer redraws. Fixes insert mode flicker.

    " Indenting "
    set expandtab                       " Expand TABs to spaces (tab=4spaces).
    set tabstop=4                       " The width of a TAB is set to 4.
    set softtabstop=4                   " Sets the number of columns for a TAB.
    set shiftwidth=4                    " Indents (>>) will have a width of 4.
    set smarttab                        " Autotabs for certain code.

    " Search "
    set ignorecase                      " Search case-insensitive.
    set nosmartcase                     " Don't search case-sensitive when a Capital letter is used.
    set nomagic                         " Don't use regex in search.

    " Other "
    set whichwrap+=<,>,h,l,[,]          " Go around line starts/ends.
    set mouse=a                         " Scroll and select via mouse!



" Color scheme:

    colorscheme dracula
    " colorscheme atom



" Commands:

    " trim: Remove all trailing whitespace
    cnoreabbrev trim :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>



" Keybindings:


    " Vars:
    let vert=4
    let horz=8
    let scroll=5
    map <Space> <Leader>


    " Movement Up/Down "


        " Ctrl + Up/Down: Move up/down by {vert}.
            noremap  <expr> <C-Up>      "k" . string(vert-1) . "k"
            noremap  <expr> <C-Down>    "j" . string(vert-1) . "j"
            inoremap        <C-Up>      <Up><Up><Up><Up>
            inoremap        <C-Down>    <Down><Down><Down><Down>

        " Ctrl + k/j: Move up/down by {vert}.
            " Safe remap.
            noremap  <expr> <C-k>       "k" . string(vert-1) . "k"
            noremap  <expr> <C-j>       "j" . string(vert-1) . "j"


        " Shift + Up/Down: Scroll up/down by ${scroll}.
            noremap  <expr> <S-Up>      "<C-y>" . string(scroll-1) . "<C-y>"
            noremap  <expr> <S-Down>    "<C-e>" . string(scroll-1) . "<C-e>"
            inoremap <expr> <S-Up>      "<C-o>" . string(scroll)   . "<C-y>"
            inoremap <expr> <S-Down>    "<C-o>" . string(scroll)   . "<C-e>"

        " Shift + k/j: Scroll up/down by ${scroll}.
            noremap  <expr> <S-k>       "<C-y>" . string(scroll-1) . "<C-y>"
            noremap  <expr> <S-j>       "<C-e>" . string(scroll-1) . "<C-e>"


        " Alt + Up/Down: Move line up/down.
            nnoremap <A-Up>     ddkP
            nnoremap <A-Down>   ddp
            vnoremap <A-Up>     :m '<-2<CR>gv=gv
            vnoremap <A-Down>   :m '>+1<CR>gv=gv
            inoremap <A-Up>     <A-d>dkPa
            inoremap <A-Down>   <A-d>dpa

        " Alt + k/j: Move line up/down.
            nnoremap <A-k>      ddkP
            nnoremap <A-j>      ddp
            vnoremap <A-k>      :m '<-2<CR>gv=gv
            vnoremap <A-j>      :m '>+1<CR>gv=gv


        " Ctrl + Alt + Up/Down: Scroll up/down by ${scroll}.
            noremap  <expr> <C-A-Up>    "<C-y>" . string(scroll-1) . "<C-y>"
            noremap  <expr> <C-A-Down>  "<C-e>" . string(scroll-1) . "<C-e>"
            inoremap <expr> <C-A-Up>    "<C-o>" . string(scroll)   . "<C-y>"
            inoremap <expr> <C-A-Down>  "<C-o>" . string(scroll)   . "<C-e>"


        " Shift + Alt + Up/Down: Visual select up/down.
            nnoremap <S-A-Up>   <C-v>k
            nnoremap <S-A-Down> <C-v>j
            vnoremap <S-A-Up>   k
            vnoremap <S-A-Down> j
            inoremap <S-A-Up>   <Esc><C-v>k
            inoremap <S-A-Down> <Esc><C-v>j

        " Shift + Alt + k: Documentation.
            " Replaces Shift + k.
            noremap  <A-S-k>    K

        " Shift + Alt + j: Join lines.
            " Replaces Shift + j.
            noremap  <A-S-j>    J


        " ZZ: Center active line.
            noremap  ZZ     zz



    " Movement Left/Right "


        " Ctrl + Left/Right: Move left/right by word.
            noremap  <C-Left>   b
            noremap  <C-Right>  e
            inoremap <C-Right>  <C-o>e<Right>


        " Shift + Left/Right: Move left/right by {horz}.
            noremap  <expr> <S-Left>        "h" . string(horz-1) . "h"
            noremap  <expr> <S-Right>       "l" . string(horz-1) . "l"
            inoremap <expr> <S-Left>        "<C-o>" . string(horz) . "h"
            inoremap <expr> <S-Right>       "<C-o>" . string(horz) . "l"


        " Alt + Left/Right: Move to line start/end (nonblank).
            noremap  <A-Left>   ^
            noremap  <A-Right>  $
            inoremap <A-Left>   <A-I>
            inoremap <A-Right>  <A-A>


        " Ctrl + Alt + Left/Right: Move left/right by {horz}.
            " (Nvim-qt only)
            noremap  <expr> <C-A-Left>      "h" . string(horz-1) . "h"
            noremap  <expr> <C-A-Right>     "l" . string(horz-1) . "l"
            inoremap <expr> <C-A-Left>      "<C-o>" . string(horz) . "h"
            inoremap <expr> <C-A-Right>     "<C-o>" . string(horz) . "l"



    " Copy/Paste "


        " y/Y: Copy to clipboard:
            noremap  y  "+y
            nnoremap yy "+yy
            " Y -> Yank to end of line, like D.
            nnoremap Y  "+y$
            vnoremap Y  "+Y


        " s/S: Cut to clipboard.
            noremap  s      "+d
            nnoremap ss     "+dd
            noremap  S      "+D


        " v_x/X: Cut to clipboard.
            vnoremap x      "+d
            vnoremap X      "+d
            " n_x -> Delete character at cursor.
            " n_X -> Delete character before cursor.
            " v_x -> Cut selected.
            " v_X -> Cut selected lines!
            " v_d -> Delete selected.
            " v_D -> Delete selected lines!


        " p/P: Paste from clipboard:
            " Use ["x]gp/gP to paste from register x.
            noremap  p  "+p
            noremap  P  "+P


        " cw/yw: Change/yank inner word.
            nnoremap cw     ciw
            nnoremap yw     "+yiw


        " Ctrl + a: Select all.
            noremap  <C-a>  <Esc>gg0vG$


        " Ctrl + d: Select word.
            nnoremap <C-d>  viw
            vnoremap <C-d>  <Esc>viw
            inoremap <C-d>  <C-o>viw


        " Ctrl + c: Copy.
            nnoremap <C-c>  "+Y
            vnoremap <C-c>  "+y
            inoremap <C-c>  <C-o>"+Y


        " Ctrl + x: Cut.
            nnoremap <C-x>  "+dd
            vnoremap <C-x>  "+x
            inoremap <C-x>  <C-o>"+dd


        " Ctrl + v: Paste.
            nnoremap <C-v>  "+P
            vnoremap <C-v>  "+P
            inoremap <C-v>  <C-r><C-p>+


        " Ctrl + q / Alt + v: Visual block mode.
            " Replaces Ctrl + v.
            noremap  <A-v>  <C-v>
            inoremap <A-v>  <Esc><C-v>



    " Delete "


        " _ <- Black hole register.

        " d <- Delete + motion.


        " Backspace/del: Delete previous/current character.
            nnoremap <BS>       "_X
            vnoremap <BS>       "_d
            noremap  <del>      "_x
            nnoremap x          "_x
            nnoremap X          "_X


        " Ctrl + backspace: Delete to the start of word.
            " (Nvim-qt only)
            nnoremap <C-BS>     "_db
            inoremap <C-BS>     <C-W>

        " Ctrl + del: Delete to the end of word.
            nnoremap <C-del>    "_de
            inoremap <C-del>    <C-o>"_de


        " Alt + backspace/del: Delete to the start/end of line.
            nnoremap <A-BS>     "_d0
            nnoremap <A-del>    "_D
            inoremap <A-BS>     <C-u>
            inoremap <A-del>    <C-o>"_D


        " Shift + del: Delete line.
            nnoremap <S-del>    "_dd
            vnoremap <S-del>    "_D
            inoremap <S-del>    <C-o>"_dd



    " Search "


        " f/F: Search (/?).
            noremap  f  /
            noremap  F  ?


        " Alt + c: Toggle case senesitive search.
            noremap  <A-c>      :set ignorecase!<cr>


        " Alt + r: Toggle regex search.
            noremap  <A-r>      :set magic!<cr>



    " Other "


        " Alt + a: Increment number.
            " Replaces Ctrl + a.
            noremap <A-a>       <C-a>

        " Alt + x: Decrement number.
            " Replaces Ctrl + x.
            noremap  <A-x>      <C-x>
            inoremap <A-x>      <C-x>


        " Ctrl + [Shift +] Enter: New line below/above.
            " (Nvim-qt only)
            nnoremap <C-Enter>      o
            nnoremap <C-S-Enter>    O
            vnoremap <C-Enter>      <Esc>o
            vnoremap <C-S-Enter>    <Esc>O
            inoremap <C-Enter>      <A-o>
            inoremap <C-S-Enter>    <A-O>


        " Ctrl + s: Save file.
            nnoremap <C-s>      :w<cr>
            vnoremap <C-s>      :w<cr>
            inoremap <C-s>      <C-o>:w<cr>


        " Ctrl + u: Cursor undo.
            nnoremap <C-u>      <C-o>
            vnoremap <C-u>      <Esc><C-o>

        " Ctrl + i: Cursor redo.
            vnoremap <C-i>      <Esc><C-i>


        " Ctrl + z: Undo.
            nnoremap <C-z>      u
            vnoremap <C-z>      <Esc>u
            inoremap <C-z>      <C-o>u

        " Ctrl + r: Redo.
            nnoremap <C-r>      <C-r>
            vnoremap <C-r>      <Esc><C-r>
            inoremap <C-r>      <C-o><C-r>

        " n_U: Redo.
            nnoremap U          <C-r>


        " Alt + [/]: Unindent/indent.
            nnoremap <A-[>      <<
            nnoremap <A-]>      >>
            vnoremap <A-[>      <gv
            vnoremap <A-]>      >gv
            inoremap <A-[>      <C-d>
            inoremap <A-]>      <C-t>

        " Shift+Tab/Tab: Unindent/indent.
            nnoremap <S-Tab>    <<
           "nnoremap <Tab>      >>      "Can't rebind because of <C-i>
            vnoremap <S-Tab>    <gv
            vnoremap <Tab>      >gv
            inoremap <S-Tab>    <C-d>
           "inoremap <Tab>      <Tab>   "Tab is inserted literaly.


        " Ctrl + space: Open autocomplete.
            " Ctrl + e: Cancel insertion.
            nnoremap <C-Space>  a<C-n>
            inoremap <C-Space>  <C-n>
            vnoremap <C-Space>  <Esc>a



    " Leader "


        " Leader + f: File System Explore
        " https://stackoverflow.com/questions/9160499/go-to-back-directory-browsing-after-opening-file-in-vim
            noremap <Leader>f       <Esc>:Ex<cr>

        " Leader + n: New buffer
        " https://stackoverflow.com/questions/4478111/vim-how-do-you-open-another-no-name-buffer-like-the-one-on-startup
            noremap <Leader>n       <Esc>:tabnew<cr>

        " Leader + t: New buffer (new tab)
            noremap <Leader>t       <Esc>:tabnew<cr>

        " Leader + v: Vertical split.
            noremap <Leader>v       <Esc>:vs<cr>


        " Leader + w: Close tab.
            noremap <Leader>w       <Esc>:q<cr>

        " Leader + W: Force close tab.
            noremap <Leader>W       <Esc>:q!<cr>

        " Leader + kw: Close all tabs.
            noremap <Leader>kw      <Esc>:bufdo bwipeout<cr>

        " Leader + kW: Force close all tabs (don't save).
            noremap <Leader>kW      <Esc>:bufdo! bwipeout!<cr>

        " Leader + q: Quit.
            noremap <Leader>q       <Esc>:qa<cr>

        " Leader + Q: Force quit (don't save).
            noremap <Leader>Q       <Esc>:qa!<cr>


        " Unassigned: Trim whitespace.
            "noremap  <Leader>t  :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
            " Trim command doesn't work?
            "noremap  <Leader>t      :trim<cr>



    " Tabs "


        " Ctrl + pageUp/pageDown: Next/Previous tab. Works by default.

        " Ctrl + Shift + pageUp/pageDown: Move active tab left/right.
            " (Nvim-qt only)
            noremap <C-S-pageUp>    :tabm -1<cr>
            noremap <C-S-pageDown>  :tabm +1<cr>


        " Ctrl + T: New tab.
            nnoremap <C-T>      <Esc>:$tabnew<cr>


        " Alt + [number]: Go to tab [number].
            noremap  <A-1>      <Esc>1gt
            inoremap <A-1>      <Esc>1gta
            noremap  <A-2>      <Esc>2gt
            inoremap <A-2>      <Esc>2gta
            noremap  <A-3>      <Esc>3gt
            inoremap <A-3>      <Esc>3gta
            noremap  <A-4>      <Esc>4gt
            inoremap <A-4>      <Esc>4gta
            noremap  <A-5>      <Esc>5gt
            inoremap <A-5>      <Esc>5gta
            noremap  <A-6>      <Esc>6gt
            inoremap <A-6>      <Esc>6gta
            noremap  <A-7>      <Esc>7gt
            inoremap <A-7>      <Esc>7gta
            noremap  <A-8>      <Esc>8gt
            inoremap <A-8>      <Esc>8gta
            noremap  <A-9>      <Esc>9gt
            inoremap <A-9>      <Esc>9gta
