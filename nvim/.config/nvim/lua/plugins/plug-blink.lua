local ok, blink = pcall(require, "blink.cmp")
if not ok then
	vim.notify("blink.cmp not found — run :restart to install plugins", vim.log.levels.WARN)
	return
end

blink.setup({
	fuzzy = {
		implementation = "lua",
	},
	completion = {
		documentation = { auto_show = true },
		ghost_text = { enabled = true },
		menu = {
			draw = {
				components = {
					-- customize the drawing of kind icons
					kind_icon = {
						text = function(ctx)
							-- default kind icon
							local icon = ctx.kind_icon
							-- if LSP source, check for color derived from documentation
							if ctx.item.source_name == "LSP" then
								local color_item =
									require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr ~= "" then
									icon = color_item.abbr
								end
							end
							return icon .. ctx.icon_gap
						end,
						highlight = function(ctx)
							-- default highlight group
							local highlight = "BlinkCmpKind" .. ctx.kind
							-- if LSP source, check for color derived from documentation
							if ctx.item.source_name == "LSP" then
								local color_item =
									require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
								if color_item and color_item.abbr_hl_group then
									highlight = color_item.abbr_hl_group
								end
							end
							return highlight
						end,
					},
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
})

local capabilities = blink.get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable({ "lua_ls" })
