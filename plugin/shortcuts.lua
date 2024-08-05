vim.keymap.set('n', '<Leader>e', ':e ' .. vim.fn.expand('%:p:h') .. '/')
vim.keymap.set('n', '//', ':nohlsearch<CR>')

vim.keymap.set('n', 'j', function() return vim.v.count == 0 and 'gj' or 'j' end,
  { expr = true })
vim.keymap.set('n', 'k', function() return vim.v.count == 0 and 'gk' or 'k' end,
  { expr = true })

vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
