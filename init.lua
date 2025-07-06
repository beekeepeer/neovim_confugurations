-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})

-- Set shell to PowerShell 7 with properly escaped path
vim.opt.shell = '"C:\\Program Files\\PowerShell\\7\\pwsh.exe"'
vim.opt.shellcmdflag = "-NoLogo -NoProfile -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.opt.spell = true -- Enable spell checking
