vim.api.nvim_create_augroup("Binary", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
  pattern = "*.bin",
  group = "Binary",
  callback = function()
    if vim.bo.binary then
      vim.cmd("%!xxd")
      vim.bo.filetype = "xxd"
      vim.bo.modified = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.bin",
  group = "Binary",
  callback = function()
    if vim.bo.binary then
      vim.cmd("%!xxd -r")
    end
  end,
})
