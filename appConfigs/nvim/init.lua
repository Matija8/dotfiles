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

vim.opt.mouse = 'a'

vim.g.mapleader = ' '

-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set

vim.keymap.set('n', '<Leader>f', '<Esc>:Ex<cr>')
vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {
    desc = 'Save'
})
