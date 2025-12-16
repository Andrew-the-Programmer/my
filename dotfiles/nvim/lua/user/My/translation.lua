local M = {}
local map = vim.keymap.set

M.LANGUAGES = {
    english = "eng",
    chinese = "zh-CH",
}

function M.GetText(text)
    if text then
        return text
    end
    text = My.nvim.get_visual_selection_text()
    if text then
        return text[1]
    end
    return vim.api.nvim_get_current_line()
end

function M.GetPinyin(text)
    local cmd = My.lua.GetCmd({ cmd = "pinyin-tool", input = text })
    return My.lua.GetCmdOutput(cmd)
end

---@class TranslationConfig
---@field language string arg to trans cmd
---@field from string language to translate from
---@field to string language to translate to
M.TranslationConfig = {}

---@return TranslationConfig
function M.TranslationConfig:new(o)
    ---@type table
    o = My.lua.IfNil(o, {})
    self.__index = self
    o = setmetatable(o, self)
    return o
end

---@param text string | nil
---@param opts TranslationConfig | nil
function M.TranslationCmd(text, opts)
    opts = My.lua.IfNil(opts, {}) or {}
    opts.from = My.lua.IfNil(opts.from, "")
    opts.to = My.lua.IfNil(opts.to, M.LANGUAGES.english)
    opts.language = My.lua.IfNil(opts.language, opts.from .. ":" .. opts.to)
    opts = M.TranslationConfig:new(opts)
    local cmd = My.lua.GetCmd({
        cmd = "trans",
        args = { "-b", opts.language },
        text = text,
    })
    return cmd
end

---@param opts TranslationConfig | nil
function M.GetTranslation(text, opts)
    local cmd = M.TranslationCmd(text, opts)
    return My.lua.GetCmdOutput(cmd)
end

return M
