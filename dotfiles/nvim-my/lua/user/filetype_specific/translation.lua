local mt = My.translation
local Keymap = My.keymaps.Keymap

---@type Keymap[]
local keymaps = {}

local function New(mode, lhs, rhs, opts)
	local new = Keymap:new_nvim(mode, lhs, rhs, opts)
	table.insert(keymaps, new)
end

New({ "n", "v" }, "<localleader>cp", function()
	local text = mt.GetText()
	local opts = { sep = " - " }
	local pinyin = mt.GetPinyin(text)
	My.nvim.AppendText(pinyin, opts)
	My.nvim.EnterNormalMode()
end, { desc = "Append pinyin" })

New({ "n", "v" }, "<localleader>cP", function()
	local text = mt.GetText()
	local pinyin = mt.GetPinyin(text)
	My.nvim.InsertLine(pinyin)
	My.nvim.EnterNormalMode()
end, { desc = "Insert pinyin" })

New({ "n", "v" }, "<localleader>ct", function()
	local text = mt.GetText()
	local pinyin = mt.GetPinyin(text)
	local t_opts = mt.TranslationConfig:new()
	t_opts.from = mt.LANGUAGES.chinese
	local translation = mt.GetTranslation(text, t_opts)
	local a_opts = { sep = " - " }
	My.nvim.AppendText(pinyin, a_opts)
	My.nvim.AppendText(translation, a_opts)
	My.nvim.EnterNormalMode()
end, { desc = "Append translation from chinese" })

New({ "n", "v" }, "<localleader>cT", function()
	local text = mt.GetText()
	local pinyin = mt.GetPinyin(text)
	local t_opts = mt.TranslationConfig:new()
	t_opts.from = mt.LANGUAGES.chinese
	local translation = mt.GetTranslation(text, t_opts)
	My.nvim.InsertLine(translation)
	My.nvim.InsertLine(pinyin)
	My.nvim.EnterNormalMode()
end, { desc = "Insert translation from chinese" })

New({ "v" }, "<localleader>cy", function()
	local text = mt.GetText()
	local pinyin = mt.GetPinyin(text)
	local t_opts = mt.TranslationConfig:new()
	t_opts.from = mt.LANGUAGES.chinese
	local translation = mt.GetTranslation(text, t_opts)
	My.nvim.InsertLine(text)
	local a_opts = { sep = " - " }
	My.nvim.GoDown(1)
	My.nvim.AppendText(pinyin, a_opts)
	My.nvim.AppendText(translation, a_opts)
	My.nvim.EnterNormalMode()
end, { desc = "Append translation from chinese of visual selection" })

New({ "n", "v" }, "<localleader>tt", function()
	local text = mt.GetText()
	local translation = mt.GetTranslation(text)
	local a_opts = { sep = " - " }
	My.nvim.AppendText(translation, a_opts)
	My.nvim.EnterNormalMode()
end, { desc = "Append translation" })

New({ "n", "v" }, "<localleader>tT", function()
	local text = mt.GetText()
	local translation = mt.GetTranslation(text)
	My.nvim.InsertLine(translation)
	My.nvim.EnterNormalMode()
end, { desc = "Insert translation" })

New({ "n", "v" }, "<localleader>tc", function()
	local text = mt.GetText()
	local t_opts = mt.TranslationConfig:new()
	t_opts.to = mt.LANGUAGES.chinese
	local translation = mt.GetTranslation(text, t_opts)
	local a_opts = { sep = " - " }
	My.nvim.AppendText(translation, a_opts)
	My.nvim.EnterNormalMode()
end, { desc = "Append translation to chinese" })

New({ "n", "v" }, "<localleader>tC", function()
	local text = mt.GetText()
	local t_opts = mt.TranslationConfig:new()
	t_opts.to = mt.LANGUAGES.chinese
	local translation = mt.GetTranslation(text, t_opts)
	My.nvim.InsertLine(translation)
	My.nvim.EnterNormalMode()
end, { desc = "Insert translation to chinese" })

return My.FiletypeConfig:new({
	pattern = { "*.txt", "*.md" },
	keymaps = keymaps,
})
