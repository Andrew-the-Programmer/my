local M = {}

M.InputList = {}
M.OutputList = {}

function M.StoreInput()
	local filepath = My.oil.functions.GetFullPathUnderCursor()
	table.insert(M.InputList, filepath)
end

function M.StoreOutput()
	local filepath = My.oil.functions.GetFullPathUnderCursor()
	table.insert(M.OutputList, filepath)
end

function M.ClearLists()
	M.InputList = {}
	M.OutputList = {}
end

function M.CopyInputToOutput()
	for _, file in pairs(M.InputList) do
		for _, folder in pairs(M.OutputList) do
			My.sys.CopyFile(file, folder)
		end
	end
	M.ClearLists()
end

function M.MoveInputToOutput()
	for _, file in pairs(M.InputList) do
		for _, folder in pairs(M.OutputList) do
			My.sys.CopyFile(file, folder)
		end
	end
	for _, file in pairs(M.InputList) do
		My.sys.DeleteFile(file)
	end
	M.ClearLists()
end

function M.ShowInputList()
	My.lua.Print(M.InputList, { sep = "\n", endl = "" })
end

function M.ShowOutputList()
	My.lua.Print(M.OutputList, { sep = "\n", endl = "" })
end

function M.ShowLists()
    local input = My.lua.Dump(M.InputList, { sep = "\n", endl = "" })
    local output = My.lua.Dump(M.OutputList, { sep = "\n", endl = "" })
    My.nvim.Notify(input .. " -> " .. output)
end

return M
