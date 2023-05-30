local servers = {
	["bashls"] = {},
	["cssls"] = {},
	["html"] = {},
	["lua_ls"] = {},
	["tsserver"] = {},
	["pylsp"] = {},
}
local servers_key = vim.tbl_keys(servers)
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			{ "folke/neodev.nvim", config = true },
			{
				"williamboman/mason-lspconfig.nvim",
				opts = { ensure_installed = servers_key },
			},
			"jose-elias-alvarez/null-ls.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"RRethy/vim-illuminate",
		},
		opts = {
			-- vim.diagnostic.config()
			virtual_text = true,
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
		config = function(_, opts)
			vim.diagnostic.config(opts)
			local lspconf = require("lspconfig")
			local function on_attach(client, bufnr)
				BUF = bufnr
				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })
				-- plugin.map_keys(bufnr)
				require("illuminate").on_attach(client)
			end
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for server, opts in pairs(servers) do
				opts = vim.tbl_deep_extend("force", opts, {
					capabilities = capabilities,
					on_attach = on_attach,
				})
				lspconf[server].setup(opts)
				require("which-key").register({
					["<leader>l"] = {
						name = "+LSP",
						s = {
							name = "+Symbol",
							r = { vim.lsp.buf.rename, "Rename" },
							f = { require("telescope.builtin").lsp_document_symbols, "Find" },
						},
						w = {
							name = "+Workspace",
							a = { vim.lsp.buf_add_workspace_folder, "Add Folder" },
							d = { vim.lsp.buf_remove_workspace_folder, "Remove Folder" },
							s = {
								function()
									print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
								end,
								"List Folders",
							},
						},
						L = {
							name = "+Plugin",
							i = { "<CMD>LspInfo<CR>", "LSP Info" },
							r = { "<CMD>LspRestart<CR>", "LSP Restart" },
							m = { "<CMD>Mason<CR>", "Mason" },
						},
						c = { vim.lsp.buf.code_action, "Code Action" },
						i = { vim.lsp.buf.signature_help, "Signature Documentation" },
						d = { vim.diagnostic.open_float, "Diagnostic Float" },
					},
					g = {
						name = "+Goto",
						d = { vim.lsp.buf.definition, "Definition" },
						D = { vim.lsp.buf.declaration, "Declaration" },
						r = { require("telescope.builtin").lsp_references, "References" },
						i = { vim.lsp.buf.implementation, "Implementation" },
					},
					K = { vim.lsp.buf.hover, "Documentation Float" },
				}, { buffer = BUF, silent = true, noremap = true })
			end
			local nls = require("null-ls")
			local builtin = nls.builtins
			nls.setup({
				sources = {
					builtin.formatting.stylua,
					-- builtin.formatting.rustfmt,
					builtin.formatting.prettierd,
					builtin.formatting.shfmt,
					-- builtin.diagnostics.shellcheck,
					builtin.formatting.stylua,
					-- builtin.formatting.markdownlint,
					builtin.formatting.pylint,
				},
			})
		end,
	},
}
