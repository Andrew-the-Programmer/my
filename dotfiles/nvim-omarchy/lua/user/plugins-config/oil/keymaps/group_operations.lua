local go = My.oil.group_operations

local keymaps = {
    ["<localleader>,"] = {
        go.StoreInput,
        desc = "Store input",
    },
    ["<localleader>."] = {
        go.StoreOutput,
        desc = "Store output",
    },
    ["<localleader>X"] = {
        go.ClearLists,
        desc = "Clear lists",
    },
    ["<localleader>C"] = {
        go.CopyInputToOutput,
        desc = "Copy input to output",
    },
    ["<localleader>M"] = {
        go.MoveInputToOutput,
        desc = "Move input to output",
    },
    ["<localleader>L"] = {
        go.ShowLists,
        desc = "Show lists",
    },
}

return keymaps
