-- https://neovim.io/doc/user/lua-guide.html
-- https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/
-- https://github.com/nanotee/nvim-lua-guide
--
-- https://www.youtube.com/watch?v=J9yqSdvAKXY
-- https://www.youtube.com/watch?v=w7i4amO_zaE
--
-- You need neovim version 0.5 or higher for lua to work.
-- https://stackoverflow.com/questions/75906887/file-init-lua-script-in-neovim-not-working
-- print("DEBUG: Init.lua loaded")
--
vim.cmd("colorscheme dracula")

vim.opt.syntax = 'on'
vim.opt.number = true
vim.opt.rnu = false
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.showtabline = 2

vim.opt.smarttab = true

vim.opt.mouse = 'a'

vim.g.mapleader = ' '

vertCount = 4
horzCount = 8
scrollCount = 5

vim.keymap.set({'n', 'v'}, '<S-k>', string.rep('<C-y>', scrollCount))
vim.keymap.set({'n', 'v'}, '<S-j>', string.rep('<C-e>', scrollCount))

-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set

vim.keymap.set('n', '<Leader>f', '<Esc>:Ex<cr>')

-- Leader + w: Close tab.
vim.keymap.set('n', '<Leader>w', '<Esc>:q<cr>')
-- Leader + W: Force close tab.
vim.keymap.set('n', '<Leader>W', '<Esc>:q!<cr>')

-- Ctrl + s: Save file.
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('v', '<C-s>', ':w<cr>')
vim.keymap.set('i', '<C-s>', '<C-o>:w<cr>')
