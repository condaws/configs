require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

--Mason-lspconfig
require("mason-lspconfig").setup()

-- LSP
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- Mappings. See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp = require('lspconfig')


-- Terraform
lsp['terraformls'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        filetypes = { "tf" }
    }
}

-- Python
lsp['pyright'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}


-- TypeScript
lsp['tsserver'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        completions = {
            completeFunctionCalls = true
        }
    }
}

-- C++
lsp['clangd'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    cmd = {"clangd-14"}
}

-- lua
lsp['lua_ls'].setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}


-- Diagnostics
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    underline = false,
    severity_sort = false,
    float = false,
})

local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

