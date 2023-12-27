vim.opt.number = true
vim.opt.showmode = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shortmess:append{c = true}
vim.opt.scrolloff = 12
vim.o.pumheight = 10
vim.opt.cinoptions = 'L0'
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.signcolumn = 'no'
vim.opt.completeopt = {'menu','menuone','noinsert'}
vim.opt.mouse = ""

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

-- vim.g.netrw_banner = "off"
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_winsize = 20

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]])
