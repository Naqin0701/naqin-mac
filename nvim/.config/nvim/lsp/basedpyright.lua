-- ~/.config/nvim/lsp/basedpyright.lua
return {
	settings = {
		basedpyright = {
			analysis = {
				-- 常用推荐设置
				typeCheckingMode = "standard", -- 可改成 "basic" / "strict" / "recommended"
				diagnosticMode = "openFilesOnly", -- 只分析打开的文件，速度更快；改 "workspace" 则全项目分析

				-- 禁用你觉得没用的 diagnostic（重点）
				diagnosticSeverityOverrides = {
					reportAny = "none", -- 禁止 reportAny（最常见噪音）
					reportExplicitAny = "none", -- 显式写 Any 也关闭（可选）
					reportMissingTypeStubs = "none", -- 第三方库没类型桩，经常烦人
					reportUnusedImport = "warning", -- 未使用 import 改成 warning（或 "none"）
					reportUnusedVariable = "warning",
					reportUnusedFunction = "warning",
					reportUnusedClass = "warning",
					reportUnusedCoroutine = "warning",
					reportPrivateImportUsage = "warning",

					-- 其他你可能想调整的（根据个人喜好）
					-- reportGeneralTypeIssues = "error",
					-- reportOptionalMemberAccess = "warning",
					-- reportCallIssue = "warning",
					-- reportUnreachable = "warning",
				},

				-- 可选的其他实用设置
				inlayHints = {
					callArgumentNames = true, -- 函数调用时显示参数名
					variableTypes = true,
					functionReturnTypes = true,
				},

				useLibraryCodeForTypes = true,
				autoSearchPath = true,
			},
		},
	},
}
