local telescope = require('telescope')

telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
        --
    file_ignore_patterns = {
        "^node_modules/",
        "%.o",
    },

    wrap_results = true,
    path_display = {
        "smart"
    },

    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top"
      }
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure

    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },

    file_browser = {
      hijack_netrw = true,
    }
  }
}

-- This will load fzf_native and have it override the default file sorter
telescope.load_extension('fzf')
telescope.load_extension('file_browser')

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>twd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>tr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>tgc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>te', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', {silent=true})
vim.keymap.set('n', '<leader>td', function()
    builtin.diagnostics({ bufnr = 0 })
end)

