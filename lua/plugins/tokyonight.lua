require("tokyonight").setup({
    style = "night",
    styles = {
        floats = "transparent",
        sidebars = "transparent"
    },
    on_highlights = function (hl, c)
        hl.TelescopeBorder = {
            fg = "#27445c"
        }
        hl.CmpDocumentationBorder = {
            fg = "#27445c"
        }
        hl.PmenuThumb = {
            bg = "#27445c"
        }
        hl.FloatBorder = {
            fg = "#27445c"
        }
        hl.NormalFloat = {
            fg = "#565f89"
        }
    end,

})

vim.cmd[[colorscheme tokyonight]]

