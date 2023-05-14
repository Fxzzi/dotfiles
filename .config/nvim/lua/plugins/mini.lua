return {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"echasnovski/mini.comment",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
}
