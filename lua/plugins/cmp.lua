-- Luasnip 
local luasnip = require('luasnip')

luasnip.config.set_config({
    region_check_events = 'InsertEnter',
    delete_check_events = 'InsertLeave'
})

require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Completion menu icons
local kind_icons = {
    Text = " ",
    Method = " ",
    Function = " ",
    Field = " ",
    Variable = " ",
    Class = ' ',
    Interface = " ",
    Module = " ",
    Property = ' ',
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " "
}

-- Autopairs
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },

    view = {
        entries = {
            name = "custom",
            selection_order = "near_cursor"
        }
    },

    performance = {
        max_view_entries = 10
    },

    window = {
        completion = cmp.config.window.bordered {
            side_padding = 1,
            winhighlight = 'Normal:CmpDocumentation,CursorLine:PmenuSel,Search:None,FloatBorder:CmpDocumentationBorder'
        },
        documentation = cmp.config.window.bordered {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = 'Normal:CmpDocumentation,CursorLine:CmpDocPmenuSel,Search:None,FloatBorder:CmpDocumentationBorder',
        },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s ", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ""
            
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, 30)

            if truncated_label ~= label then
              vim_item.abbr = truncated_label .. '...'
            elseif string.len(label) < 30 then
              local padding = string.rep(' ', 30 - string.len(label))
              vim_item.abbr = label .. padding
            end

            return vim_item
        end
    },

    completion = {
        completeopt = 'menu,menuone,noinsert',
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
        ["<C-n>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-l>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ["<CR>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() ~= 0 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-e><CR>", true, true, true), "n")
            else
                fallback()
            end
        end),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),

        -- go to previous placeholder in the snippet
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),
    }),
    
    sources = cmp.config.sources({
        {
            name = "buffer",
            keyword_length = 4
        },
        {
            name = "nvim_lsp"
        },
        {
            name = "luasnip",
            max_item_count = 3
        },
        {
            name = "path"
        },
    })
})

-- cmp.setup.cmdline({ '/', '?' }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })
-- 
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = 'path' }
--     }, {
--             { name = 'cmdline' }
--         })
-- })

