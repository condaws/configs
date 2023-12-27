local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
            require('plugins.lualine')
        end
    },

    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
            require('plugins.tokyonight')
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            require('plugins.treesitter')
        end,
        dependencies = {
            {
                'windwp/nvim-ts-autotag',
                config = function ()
                    require('plugins.autotag')
                end
            }
        }
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function ()
            require('plugins.telescope')
        end
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim'
        }
    },

    -- LSP 
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {
        'neovim/nvim-lspconfig',
    	config = function ()
    	    require('plugins.lsp')
    	end
    },

    -- Autocompletion
    {
        'windwp/nvim-autopairs',
        dependencies = {
            'hrsh7th/nvim-cmp',
            -- event = 'InsertEnter',
            dependencies = {
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-nvim-lua'},
            },
            config = function ()
                require('plugins.cmp')
            end
        },
        config = function ()
            require('plugins.autopairs')
        end
    },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp'
    },
    {'rafamadriz/friendly-snippets'},
    {'mfussenegger/nvim-jdtls'}
}

local opts = {}

require('lazy').setup(plugins, opts)

