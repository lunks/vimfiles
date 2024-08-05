return {
  {
    'terrortylor/nvim-comment',
    keys = {
      {
        '<leader><space>',
        ':CommentToggle<CR>',
        mode = { 'n', 'v' },
        silent = true
      },
    },
    cmd = 'CommentToggle',
  },
}
