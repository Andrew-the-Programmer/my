---@type Term
local cpp_term = My.term.TermExecute:new({
    display_name = "c++ terminal",
})

---@param execute boolean|nil
local function Execute(cmd, execute)
    ---@type boolean
    execute = My.lua.IfNil(execute, true)
    ---@type SendConfig
    local opts = My.term.SendConfig:new()
    opts.check_error = true
    opts.execute = execute
    cpp_term:Send(cmd, opts)
end

return {
    name = "g++ - normal",
    builder = function()
        local outdirname = "out"
        local dir = My.nvim.Dir()
        local outdir = dir .. "/" .. outdirname
        local filebasename = My.nvim.FileBaseName()
        local execfile = outdir .. "/" .. filebasename
        local file = My.nvim.File()

        local args = {
            "g++",
            "-std=c++20",
            "-I/usr/local/include",
            "-L/usr/local/lib",
            "-lboost_system",
            "-lboost_coroutine",
            "-lboost_context",
            "-o " .. execfile,
            file,
        }
        local cmd = ""

        for _, v in pairs(args) do
            cmd = cmd .. " " .. v
        end

        cpp_term:ChangeDir(dir)
        Execute("mkdir -p " .. outdir)
        Execute(cmd)
        Execute(execfile, false)

        return {
            name = "Done",
            cmd = { "echo" },
            args = { "Done" },
        }
    end,
    condition = {
        filetype = { "cpp" },
        -- dir = vim.fn.getcwd(),
    },
}
