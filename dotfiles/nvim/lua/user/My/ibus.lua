local M = {}

---@return integer
function M.ibus_curr()
	local cmd = [[
        dbus-send --session --type=method_call --print-reply=literal --dest=org.gnome.Shell /org/gnome/Shell/Extensions/IbusSwitcher org.gnome.Shell.Extensions.IbusSwitcher.CurrentSource
    ]]
	local stdout = My.sys.capture(cmd, false)
	local code = stdout:match("(%d)|")
	return tonumber(code)
end

function M.ibus_switch()
	local lang = M.ibus_curr()
	if lang == 0 then
		lang = 1
	else
		lang = 0
	end
	local cmd = ([[
        dbus-send --session --type=method_call --print-reply=literal --dest=org.gnome.Shell /org/gnome/Shell/Extensions/IbusSwitcher org.gnome.Shell.Extensions.IbusSwitcher.SwitchSource uint32:%s string:
    ]]):format(lang)
	os.execute(cmd)
end

function M.ibus_emoji()
	local cur_lang = M.ibus_curr()
	local lang_map = {
		[0] = "🇺🇸",
		[1] = "🇷🇺",
		[2] = "🇨🇳",
	}
    emoji = lang_map[cur_lang]
    print(cur_lang, emoji)
	return emoji
end

return M
