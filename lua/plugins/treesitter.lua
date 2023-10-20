require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true,
        disable = {
            'python',
            'cpp'
        }
    },
    autotag = {
        enable = true
    }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = {"javascript", "typescript.tsx"}

