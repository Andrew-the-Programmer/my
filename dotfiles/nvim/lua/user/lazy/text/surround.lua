return {
	--[[
    https://github.com/kylechui/nvim-surround

    Quick reminder
    See https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt#L9

	* - cursor position
	|...| - selection borders

	Old text                    Command         New text ~
	local str = H*ello          ysiw"           local str = "Hello"
	require"nvim-surroun*d"     ysa")           require("nvim-surround")
	char c = *x;                ysl'            char c = 'x';
	int a[] = *32;              yst;}           int a[] = {32};

	local str = *               <C-g>s"         local str = "*"
	local tab = *               <C-g>s}         local str = {*}
	local str = |some text|     S'              local str = 'some text'
	|div id="test"|</div>       S>              <div id="test"></div>

	local x = ({ *32 })         ds)             local x = { 32 }
	See ':h h*elp'              ds'             See :h help
	local str = ""Hell*o""      ds"             local str = "Hello"

	'*some string'              cs'"            "some string"
	use<*"hello">               cs>)            use("hello")
	`some text*`                cs`}            {some text}
    ]]

	"kylechui/nvim-surround",
	event = { "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	config = true,
}
