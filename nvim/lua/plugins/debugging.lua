return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		-- DAP UI setup
		require("dapui").setup()

		-- Event listeners for dap-ui
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- cpptools adapter
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "/home/tiagofw/.dotfiles/debugAdapters/bin/OpenDebugAD7",
		}

		-- C/C++ configurations with argument prompt
		dap.configurations.c = {
			{
				name = "Launch with arguments",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = false,
				args = function()
					local input = vim.fn.input("Arguments (separate with spaces): ")
					return vim.split(input, " ", { trimempty = true })
				end,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "Enable GDB pretty printing",
						ignoreFailures = false,
					},
				},
			},
		}

		-- Reuse the C configuration for C++
		dap.configurations.cpp = dap.configurations.c

		-- Key mappings
		vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
		vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
		vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
		vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
	end,
}
