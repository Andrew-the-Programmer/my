local function LspKeymaps(event)
	local function AddKeymap(mode, map, cmd, opts)
		local deflspopts = { buffer = event.buf }
		opts = opts or {}
		local fopts = vim.tbl_extend("force", deflspopts, opts)
		vim.keymap.set(mode, map, cmd, fopts)
	end

	local severity = vim.diagnostic.severity

	AddKeymap("n", "<leader>cgd", vim.lsp.buf.definition, { desc = "Go to definition" })
	AddKeymap("n", "<leader>cgD", vim.lsp.buf.declaration, { desc = "Go to definition" })

	AddKeymap("n", "M", vim.lsp.buf.hover, { desc = "View definition" })

	AddKeymap("n", "<leader>cws", vim.lsp.buf.workspace_symbol, { desc = "Workspace symbol" })
	AddKeymap("n", "<leader>cvf", vim.diagnostic.open_float, { desc = "View diagnostic" })
	AddKeymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
	AddKeymap("n", "<leader>cvr", vim.lsp.buf.references, { desc = "View references" })
	AddKeymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
	AddKeymap("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format buffer" })
	AddKeymap("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature help" })
	-- AddKeymap("n", "[d", vim.lsp.diagnostic.goto_next, { desc = "Next diagnostic" })
	-- AddKeymap("n", "]d", vim.lsp.diagnostic.goto_prev, { desc = "Previous diagnostic" })
	-- Goto next diagnostic of any severity
	AddKeymap("n", "]d", function()
		vim.diagnostic.goto_next({})
	end, { desc = "Next diagnostic" })

	-- Goto previous diagnostic of any severity
	AddKeymap("n", "[d", function()
		vim.diagnostic.goto_prev({})
	end, { desc = "Previous diagnostic" })

	-- Goto next error diagnostic
	AddKeymap("n", "]e", function()
		vim.diagnostic.goto_next({ severity = severity.ERROR })
	end, { desc = "Next error diagnostic" })

	-- Goto previous error diagnostic
	AddKeymap("n", "[e", function()
		vim.diagnostic.goto_prev({ severity = severity.ERROR })
	end, { desc = "Previous error diagnostic" })

	-- Goto next warning diagnostic
	AddKeymap("n", "]w", function()
		vim.diagnostic.goto_next({ severity = severity.WARN })
	end, { desc = "Next warning diagnostic" })

	-- Goto previous warning diagnostic
	AddKeymap("n", "[w", function()
		vim.diagnostic.goto_prev({ severity = severity.WARN })
	end, { desc = "Previous warning diagnostic" })
end

return {
	{
		-- https://github.com/williamboman/mason.nvim
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			local mason = require("mason")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				auto_install = true,
				ensure_installed = {
					"lua_ls",
				},
			})
		end,
	},
	{
		-- https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		config = function()
			vim.diagnostic.config({
				-- update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					LspKeymaps(event)
				end,
			})

			-- require("lspconfig").sourcery.setup({
			-- 	init_options = {
			-- 		token = "<YOUR_TOKEN>",
			-- 		extension_version = "vim.lsp",
			-- 		editor_version = "vim",
			-- 	},
			--
			-- 	--- the rest of your options...
			-- })
		end,
	},
	{
		-- https://github.com/williamboman/mason-lspconfig.nvim
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
		},

		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local lspconfig = require("lspconfig")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			local handlers = {
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["bashls"] = function()
					lspconfig.bashls.setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = {
										"vim",
									},
								},
							},
						},
					})
				end,
				-- ["ruff-lsp"] = function()
				--     lspconfig.ruff_lsp.setup({
				--         init_options = {
				--             settings = {
				--                 args = {},
				--             },
				--         },
				--     })
				-- end,
			}

			require("mason-lspconfig").setup({
				handlers = handlers,
			})
		end,
	},
	{
		-- https://github.com/folke/lazydev.nvim
		-- Better lsp for lua
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}
