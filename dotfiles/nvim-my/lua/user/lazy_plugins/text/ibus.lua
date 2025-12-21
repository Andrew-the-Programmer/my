return {
	"kevinhwang91/nvim-ibus-sw",
	event = "InsertEnter",
	config = function()
		require("ibus-sw").setup()
	end,
	--[[
https://extensions.gnome.org/extension/5497/ibus-switcher/
<or>
yay gnome-shell-extension-ibus-switcher-git
<reboot>
mb even: gnome-extensions enable ibus-switcher@kevinhwang91.github.com
    --]]
}
