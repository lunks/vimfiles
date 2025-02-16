return {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      vim.api.nvim_create_user_command('CommentToggle', function()
        require('Comment.api').toggle.linewise.current()
      end, {})
    end,
  },
}
