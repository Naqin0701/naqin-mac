-- ~/.config/nvim/lsp/ruff.lua
return {
	init_options = {
		settings = {
			-- 核心设置
			organizeImports = false, -- 禁用自动 organize imports（防止排序 + 删除 unused imports）
			fixAll = false, -- 禁用自动 fix all（包括删除 unused imports 和变量）

			-- Lint 配置：显示问题，但不自动修复 unused 相关规则
			lint = {
				enable = true,
				run = "onType", -- 或 "onSave"，按需选择
				select = { -- 你想启用的规则组（推荐）
					"E",
					"W",
					"F",
					"B",
					"C4",
					"SIM",
					"UP",
					"RUF", -- 常用有用规则
					-- "I"  -- 注释掉或不加，避免 import sorting
				},
				ignore = { -- 明确忽略不想看到的（可选）
					"F401", -- unused-import（显示但不 autofix）
					"F841", -- unused-variable
					"E501",
				},
			},

			-- 格式化设置（推荐保持默认 Black 风格）
			format = {
				preview = true, -- 启用预览版格式化（更智能）
			},
		},
	},

	-- 可选：on_attach 中禁用 Ruff 的某些 code action
	on_attach = function(client, bufnr)
		-- 如果你想彻底禁用 organizeImports 和 fixAll 的 code action
		client.server_capabilities.codeActionProvider = {
			codeActionKinds = { "quickfix", "refactor" }, -- 保留常用，但移除 organize/fixAll
		}
	end,
}
