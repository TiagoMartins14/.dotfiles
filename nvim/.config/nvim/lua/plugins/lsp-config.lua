return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true, -- Automatically install LSPs from mason-lspconfig
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			-- Lua LSP (lua_ls) configuration
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- C++ LSP configuration
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
				single_file_support = true,
			})

			-- Global LSP keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "LSP Find References" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
		end,
	},
}
