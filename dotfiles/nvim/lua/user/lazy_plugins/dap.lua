return {
	{
		-- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			vim.keymap.set("n", "<leader>ab", "<cmd>DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<F9>", "<cmd>DapContinue<CR>")
			vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>")
			vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>")
			vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<CR>")

			-- setup cpptools adapter
			dap.adapters.cpptools = {
				type = "executable",
				name = "cpptools",
				command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
				args = {},
				attach = {
					pidProperty = "processId",
					pidSelect = "ask",
				},
			}
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = {},
			}
			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
				name = "lldb",
			}

			-- this configuration should start cpptools and the debug the executable main in the current directory when executing :DapContinue
			dap.configurations.cpp = {
				{
					name = "Launch gdb",
					type = "gdb",
					request = "launch",
					program = function()
                        local file = vim.fn.expand("%:p:h:h") .. "/out/debug/Solution"
                        print(file)
                        return file
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}
		end,
	},
	{
		-- https://github.com/rcarriga/nvim-dap-ui
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			-- "folke/lazydev.nvim",
		},
		config = function()
			--[[ require("lazydev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			}) ]]
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
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
		end,
	},
	{
		-- https://github.com/jay-babu/mason-nvim-dap
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
}
