# ⌨️ Keymaps

**LazyVim** uses [which-key.nvim](https://github.com/folke/which-key.nvim) to help you remember your keymaps. Just press any key like `<space>` and you'll see a popup with all possible keymaps starting with `<space>`.

![image](https://user-images.githubusercontent.com/292349/211862473-1ff5ee7a-3bb9-4782-a9f6-014f0e5d4474.png)

- default `<leader>` is `<space>`
- default `<localleader>` is `\`

## General

| Key                  | Description                           | Mode                       |
| -------------------- | ------------------------------------- | -------------------------- |
| `j`                  | Down                                  | **n**, **x**               |
| `<Down>`             | Down                                  | **n**, **x**               |
| `k`                  | Up                                    | **n**, **x**               |
| `<Up>`               | Up                                    | **n**, **x**               |
| `<C-h>`              | Go to Left Window                     | **n**                      |
| `<C-j>`              | Go to Lower Window                    | **n**                      |
| `<C-k>`              | Go to Upper Window                    | **n**                      |
| `<C-l>`              | Go to Right Window                    | **n**                      |
| `<C-Up>`             | Increase Window Height                | **n**                      |
| `<C-Down>`           | Decrease Window Height                | **n**                      |
| `<C-Left>`           | Decrease Window Width                 | **n**                      |
| `<C-Right>`          | Increase Window Width                 | **n**                      |
| `<A-j>`              | Move Down                             | **n**, **i**, **v**        |
| `<A-k>`              | Move Up                               | **n**, **i**, **v**        |
| `<S-h>`              | Prev Buffer                           | **n**                      |
| `<S-l>`              | Next Buffer                           | **n**                      |
| `[b`                 | Prev Buffer                           | **n**                      |
| `]b`                 | Next Buffer                           | **n**                      |
| `<leader>bb`         | Switch to Other Buffer                | **n**                      |
| `` <leader>` ``      | Switch to Other Buffer                | **n**                      |
| `<leader>bd`         | Delete Buffer                         | **n**                      |
| `<leader>bo`         | Delete Other Buffers                  | **n**                      |
| `<leader>bD`         | Delete Buffer and Window              | **n**                      |
| `<esc>`              | Escape and Clear hlsearch             | **i**, **n**, **s**        |
| `<leader>ur`         | Redraw / Clear hlsearch / Diff Update | **n**                      |
| `n`                  | Next Search Result                    | **n**, **x**, **o**        |
| `N`                  | Prev Search Result                    | **n**, **x**, **o**        |
| `<C-s>`              | Save File                             | **i**, **x**, **n**, **s** |
| `<leader>K`          | Keywordprg                            | **n**                      |
| `gco`                | Add Comment Below                     | **n**                      |
| `gcO`                | Add Comment Above                     | **n**                      |
| `<leader>l`          | Lazy                                  | **n**                      |
| `<leader>fn`         | New File                              | **n**                      |
| `<leader>xl`         | Location List                         | **n**                      |
| `<leader>xq`         | Quickfix List                         | **n**                      |
| `[q`                 | Previous Quickfix                     | **n**                      |
| `]q`                 | Next Quickfix                         | **n**                      |
| `<leader>cf`         | Format                                | **n**, **x**               |
| `<leader>cd`         | Line Diagnostics                      | **n**                      |
| `]d`                 | Next Diagnostic                       | **n**                      |
| `[d`                 | Prev Diagnostic                       | **n**                      |
| `]e`                 | Next Error                            | **n**                      |
| `[e`                 | Prev Error                            | **n**                      |
| `]w`                 | Next Warning                          | **n**                      |
| `[w`                 | Prev Warning                          | **n**                      |
| `<leader>uf`         | Toggle Auto Format (Global)           | **n**                      |
| `<leader>uF`         | Toggle Auto Format (Buffer)           | **n**                      |
| `<leader>us`         | Toggle Spelling                       | **n**                      |
| `<leader>uw`         | Toggle Wrap                           | **n**                      |
| `<leader>uL`         | Toggle Relative Number                | **n**                      |
| `<leader>ud`         | Toggle Diagnostics                    | **n**                      |
| `<leader>ul`         | Toggle Line Numbers                   | **n**                      |
| `<leader>uc`         | Toggle Conceal Level                  | **n**                      |
| `<leader>uA`         | Toggle Tabline                        | **n**                      |
| `<leader>uT`         | Toggle Treesitter Highlight           | **n**                      |
| `<leader>ub`         | Toggle Dark Background                | **n**                      |
| `<leader>uD`         | Toggle Dimming                        | **n**                      |
| `<leader>ua`         | Toggle Animations                     | **n**                      |
| `<leader>ug`         | Toggle Indent Guides                  | **n**                      |
| `<leader>uS`         | Toggle Smooth Scroll                  | **n**                      |
| `<leader>dpp`        | Toggle Profiler                       | **n**                      |
| `<leader>dph`        | Toggle Profiler Highlights            | **n**                      |
| `<leader>uh`         | Toggle Inlay Hints                    | **n**                      |
| `<leader>gL`         | Git Log (cwd)                         | **n**                      |
| `<leader>gb`         | Git Blame Line                        | **n**                      |
| `<leader>gf`         | Git Current File History              | **n**                      |
| `<leader>gl`         | Git Log                               | **n**                      |
| `<leader>gB`         | Git Browse (open)                     | **n**, **x**               |
| `<leader>gY`         | Git Browse (copy)                     | **n**, **x**               |
| `<leader>qq`         | Quit All                              | **n**                      |
| `<leader>ui`         | Inspect Pos                           | **n**                      |
| `<leader>uI`         | Inspect Tree                          | **n**                      |
| `<leader>L`          | LazyVim Changelog                     | **n**                      |
| `<leader>fT`         | Terminal (cwd)                        | **n**                      |
| `<leader>ft`         | Terminal (Root Dir)                   | **n**                      |
| `<c-/>`              | Terminal (Root Dir)                   | **n**, **t**               |
| `<c-_>`              | which_key_ignore                      | **n**, **t**               |
| `<leader>-`          | Split Window Below                    | **n**                      |
| `<leader>\|`         | Split Window Right                    | **n**                      |
| `<leader>wd`         | Delete Window                         | **n**                      |
| `<leader>wm`         | Toggle Zoom Mode                      | **n**                      |
| `<leader>uZ`         | Toggle Zoom Mode                      | **n**                      |
| `<leader>uz`         | Toggle Zen Mode                       | **n**                      |
| `<leader><tab>l`     | Last Tab                              | **n**                      |
| `<leader><tab>o`     | Close Other Tabs                      | **n**                      |
| `<leader><tab>f`     | First Tab                             | **n**                      |
| `<leader><tab><tab>` | New Tab                               | **n**                      |
| `<leader><tab>]`     | Next Tab                              | **n**                      |
| `<leader><tab>d`     | Close Tab                             | **n**                      |
| `<leader><tab>[`     | Previous Tab                          | **n**                      |

## LSP

|Key|Description|Mode|
|---|---|---|
|`<leader>cl`|Lsp Info|**n**|
|`gd`|Goto Definition|**n**, **n**|
|`gr`|References|**n**, **n**|
|`gI`|Goto Implementation|**n**, **n**|
|`gy`|Goto T[y]pe Definition|**n**, **n**|
|`gD`|Goto Declaration|**n**|
|`K`|Hover|**n**|
|`gK`|Signature Help|**n**|
|`<c-k>`|Signature Help|**i**|
|`<leader>ca`|Code Action|**n**, **x**|
|`<leader>cc`|Run Codelens|**n**, **x**|
|`<leader>cC`|Refresh & Display Codelens|**n**|
|`<leader>cR`|Rename File|**n**|
|`<leader>cr`|Rename|**n**|
|`<leader>cA`|Source Action|**n**|
|`]]`|Next Reference|**n**|
|`[[`|Prev Reference|**n**|
|`<a-n>`|Next Reference|**n**|
|`<a-p>`|Prev Reference|**n**|
|`<leader>ss`|LSP Symbols|**n**|
|`<leader>sS`|LSP Workspace Symbols|**n**|
|`gai`|C[a]lls Incoming|**n**|
|`gao`|C[a]lls Outgoing|**n**|

## [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>bl`|Delete Buffers to the Left|**n**|
|`<leader>bp`|Toggle Pin|**n**|
|`<leader>bP`|Delete Non-Pinned Buffers|**n**|
|`<leader>br`|Delete Buffers to the Right|**n**|
|`[b`|Prev Buffer|**n**|
|`[B`|Move buffer prev|**n**|
|`]b`|Next Buffer|**n**|
|`]B`|Move buffer next|**n**|
|`<S-h>`|Prev Buffer|**n**|
|`<S-l>`|Next Buffer|**n**|

## [conform.nvim](https://github.com/stevearc/conform.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>cF`|Format Injected Langs|**n**, **x**|

## [flash.nvim](https://github.com/folke/flash.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<c-s>`|Toggle Flash Search|**c**|
|`r`|Remote Flash|**o**|
|`R`|Treesitter Search|**o**, **x**|
|`s`|Flash|**n**, **o**, **x**|
|`S`|Flash Treesitter|**n**, **o**, **x**|
|`<c-space>`|Treesitter Incremental Selection|**n**, **o**, **x**|

## [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>sr`|Search and Replace|**n**, **x**|

## [mason.nvim](https://github.com/mason-org/mason.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>cm`|Mason|**n**|

## [noice.nvim](https://github.com/folke/noice.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<c-b>`|Scroll Backward|**n**, **i**, **s**|
|`<c-f>`|Scroll Forward|**n**, **i**, **s**|
|`<leader>sn`|+noice|**n**|
|`<leader>sna`|Noice All|**n**|
|`<leader>snd`|Dismiss All|**n**|
|`<leader>snh`|Noice History|**n**|
|`<leader>snl`|Noice Last Message|**n**|
|`<leader>snt`|Noice Picker (Telescope/FzfLua)|**n**|
|`<S-Enter>`|Redirect Cmdline|**c**|

## [persistence.nvim](https://github.com/folke/persistence.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>qd`|Don't Save Current Session|**n**|
|`<leader>ql`|Restore Last Session|**n**|
|`<leader>qs`|Restore Session|**n**|
|`<leader>qS`|Select Session|**n**|

## [snacks.nvim](https://github.com/folke/snacks.nvim.git)

| Key               | Description                         | Mode         |
| ----------------- | ----------------------------------- | ------------ |
| `<leader><space>` | Find Files (Root Dir)               | **n**        |
| `<leader>,`       | Buffers                             | **n**        |
| `<leader>.`       | Toggle Scratch Buffer               | **n**        |
| `<leader>/`       | Grep (Root Dir)                     | **n**        |
| `<leader>:`       | Command History                     | **n**        |
| `<leader>dps`     | Profiler Scratch Buffer             | **n**        |
| `<leader>e`       | Explorer Snacks (root dir)          | **n**        |
| `<leader>E`       | Explorer Snacks (cwd)               | **n**        |
| `<leader>fb`      | Buffers                             | **n**        |
| `<leader>fB`      | Buffers (all)                       | **n**        |
| `<leader>fc`      | Find Config File                    | **n**        |
| `<leader>fe`      | Explorer Snacks (root dir)          | **n**        |
| `<leader>fE`      | Explorer Snacks (cwd)               | **n**        |
| `<leader>ff`      | Find Files (Root Dir)               | **n**        |
| `<leader>fF`      | Find Files (cwd)                    | **n**        |
| `<leader>fg`      | Find Files (git-files)              | **n**        |
| `<leader>fp`      | Projects                            | **n**        |
| `<leader>fr`      | Recent                              | **n**        |
| `<leader>fR`      | Recent (cwd)                        | **n**        |
| `<leader>gd`      | Git Diff (hunks)                    | **n**        |
| `<leader>gD`      | Git Diff (origin)                   | **n**        |
| `<leader>gi`      | GitHub Issues (open)                | **n**        |
| `<leader>gI`      | GitHub Issues (all)                 | **n**        |
| `<leader>gp`      | GitHub Pull Requests (open)         | **n**        |
| `<leader>gP`      | GitHub Pull Requests (all)          | **n**        |
| `<leader>gs`      | Git Status                          | **n**        |
| `<leader>gS`      | Git Stash                           | **n**        |
| `<leader>n`       | Notification History                | **n**        |
| `<leader>S`       | Select Scratch Buffer               | **n**        |
| `<leader>s"`      | Registers                           | **n**        |
| `<leader>s/`      | Search History                      | **n**        |
| `<leader>sa`      | Autocmds                            | **n**        |
| `<leader>sb`      | Buffer Lines                        | **n**        |
| `<leader>sB`      | Grep Open Buffers                   | **n**        |
| `<leader>sc`      | Command History                     | **n**        |
| `<leader>sC`      | Commands                            | **n**        |
| `<leader>sd`      | Diagnostics                         | **n**        |
| `<leader>sD`      | Buffer Diagnostics                  | **n**        |
| `<leader>sg`      | Grep (Root Dir)                     | **n**        |
| `<leader>sG`      | Grep (cwd)                          | **n**        |
| `<leader>sh`      | Help Pages                          | **n**        |
| `<leader>sH`      | Highlights                          | **n**        |
| `<leader>si`      | Icons                               | **n**        |
| `<leader>sj`      | Jumps                               | **n**        |
| `<leader>sk`      | Keymaps                             | **n**        |
| `<leader>sl`      | Location List                       | **n**        |
| `<leader>sm`      | Marks                               | **n**        |
| `<leader>sM`      | Man Pages                           | **n**        |
| `<leader>sp`      | Search for Plugin Spec              | **n**        |
| `<leader>sq`      | Quickfix List                       | **n**        |
| `<leader>sR`      | Resume                              | **n**        |
| `<leader>su`      | Undotree                            | **n**        |
| `<leader>sw`      | Visual selection or word (Root Dir) | **n**, **x** |
| `<leader>sW`      | Visual selection or word (cwd)      | **n**, **x** |
| `<leader>uC`      | Colorschemes                        | **n**        |
| `<leader>un`      | Dismiss All Notifications           | **n**        |

## [todo-comments.nvim](https://github.com/folke/todo-comments.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>st`|Todo|**n**|
|`<leader>sT`|Todo/Fix/Fixme|**n**|
|`<leader>xt`|Todo (Trouble)|**n**|
|`<leader>xT`|Todo/Fix/Fixme (Trouble)|**n**|
|`[t`|Previous Todo Comment|**n**|
|`]t`|Next Todo Comment|**n**|

## [trouble.nvim](https://github.com/folke/trouble.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<leader>cs`|Symbols (Trouble)|**n**|
|`<leader>cS`|LSP references/definitions/... (Trouble)|**n**|
|`<leader>xL`|Location List (Trouble)|**n**|
|`<leader>xQ`|Quickfix List (Trouble)|**n**|
|`<leader>xx`|Diagnostics (Trouble)|**n**|
|`<leader>xX`|Buffer Diagnostics (Trouble)|**n**|
|`[q`|Previous Trouble/Quickfix Item|**n**|
|`]q`|Next Trouble/Quickfix Item|**n**|

## [which-key.nvim](https://github.com/folke/which-key.nvim.git)

|Key|Description|Mode|
|---|---|---|
|`<c-w><space>`|Window Hydra Mode (which-key)|**n**|
|`<leader>?`|Buffer Keymaps (which-key)|**n**|

## [avante.nvim](https://github.com/yetone/avante.nvim.git)

Part of [lazyvim.plugins.extras.ai.avante](https://www.lazyvim.org/extras/ai/avante)

|Key|Description|Mode|
|---|---|---|
|`<leader>aa`|Ask Avante|**n**|
|`<leader>ac`|Chat with Avante|**n**|
|`<leader>ae`|Edit Avante|**n**|
|`<leader>af`|Focus Avante|**n**|
|`<leader>ah`|Avante History|**n**|
|`<leader>am`|Select Avante Model|**n**|
|`<leader>an`|New Avante Chat|**n**|
|`<leader>ap`|Switch Avante Provider|**n**|
|`<leader>ar`|Refresh Avante|**n**|
|`<leader>as`|Stop Avante|**n**|
|`<leader>at`|Toggle Avante|**n**|

## [claudecode.nvim](https://github.com/coder/claudecode.nvim.git)

Part of [lazyvim.plugins.extras.ai.claudecode](https://www.lazyvim.org/extras/ai/claudecode)

|Key|Description|Mode|
|---|---|---|
|`<leader>a`|+ai|**n**, **v**|
|`<leader>aa`|Accept diff|**n**|
|`<leader>ab`|Add current buffer|**n**|
|`<leader>ac`|Toggle Claude|**n**|
|`<leader>aC`|Continue Claude|**n**|
|`<leader>ad`|Deny diff|**n**|
|`<leader>af`|Focus Claude|**n**|
|`<leader>ar`|Resume Claude|**n**|
|`<leader>as`|Add file|**n**|
|`<leader>as`|Send to Claude|**v**|

## [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim.git)

Part of [lazyvim.plugins.extras.ai.copilot-chat](https://www.lazyvim.org/extras/ai/copilot-chat)

|Key|Description|Mode|
|---|---|---|
|`<c-s>`|Submit Prompt|**n**|
|`<leader>a`|+ai|**n**, **x**|
|`<leader>aa`|Toggle (CopilotChat)|**n**, **x**|
|`<leader>ap`|Prompt Actions (CopilotChat)|**n**, **x**|
|`<leader>aq`|Quick Chat (CopilotChat)|**n**, **x**|
|`<leader>ax`|Clear (CopilotChat)|**n**, **x**|

## [sidekick.nvim](https://github.com/folke/sidekick.nvim.git)

Part of [lazyvim.plugins.extras.ai.sidekick](https://www.lazyvim.org/extras/ai/sidekick)

|Key|Description|Mode|
|---|---|---|
|`<leader>a`|+ai|**n**, **v**|
|`<leader>aa`|Sidekick Toggle CLI|**n**|
|`<leader>ad`|Detach a CLI Session|**n**|
|`<leader>af`|Send File|**n**|
|`<leader>ap`|Sidekick Select Prompt|**n**, **x**|
|`<leader>as`|Select CLI|**n**|
|`<leader>at`|Send This|**n**, **x**|
|`<leader>av`|Send Visual Selection|**x**|
|`<c-.>`|Sidekick Toggle|**n**, **i**, **t**, **x**|

## [mini.surround](https://github.com/nvim-mini/mini.surround.git)

Part of [lazyvim.plugins.extras.coding.mini-surround](https://www.lazyvim.org/extras/coding/mini-surround)

|Key|Description|Mode|
|---|---|---|
|`gsa`|Add Surrounding|**n**, **x**|
|`gsd`|Delete Surrounding|**n**|
|`gsf`|Find Right Surrounding|**n**|
|`gsF`|Find Left Surrounding|**n**|
|`gsh`|Highlight Surrounding|**n**|
|`gsn`|Update `MiniSurround.config.n_lines`|**n**|
|`gsr`|Replace Surrounding|**n**|

## [neogen](https://github.com/danymat/neogen.git)

Part of [lazyvim.plugins.extras.coding.neogen](https://www.lazyvim.org/extras/coding/neogen)

|Key|Description|Mode|
|---|---|---|
|`<leader>cn`|Generate Annotations (Neogen)|**n**|

## [yanky.nvim](https://github.com/gbprod/yanky.nvim.git)

Part of [lazyvim.plugins.extras.coding.yanky](https://www.lazyvim.org/extras/coding/yanky)

|Key|Description|Mode|
|---|---|---|
|`<leader>p`|Open Yank History|**n**, **x**|
|`<p`|Put and Indent Left|**n**|
|`<P`|Put Before and Indent Left|**n**|
|`=p`|Put After Applying a Filter|**n**|
|`=P`|Put Before Applying a Filter|**n**|
|`>p`|Put and Indent Right|**n**|
|`>P`|Put Before and Indent Right|**n**|
|`[p`|Put Indented Before Cursor (Linewise)|**n**|
|`[P`|Put Indented Before Cursor (Linewise)|**n**|
|`[y`|Cycle Forward Through Yank History|**n**|
|`]p`|Put Indented After Cursor (Linewise)|**n**|
|`]P`|Put Indented After Cursor (Linewise)|**n**|
|`]y`|Cycle Backward Through Yank History|**n**|
|`gp`|Put Text After Selection|**n**, **x**|
|`gP`|Put Text Before Selection|**n**, **x**|
|`p`|Put Text After Cursor|**n**, **x**|
|`P`|Put Text Before Cursor|**n**, **x**|
|`y`|Yank Text|**n**, **x**|

## [nvim-dap](https://github.com/mfussenegger/nvim-dap.git)

Part of [lazyvim.plugins.extras.dap.core](https://www.lazyvim.org/extras/dap/core)

|Key|Description|Mode|
|---|---|---|
|`<leader>da`|Run with Args|**n**|
|`<leader>db`|Toggle Breakpoint|**n**|
|`<leader>dB`|Breakpoint Condition|**n**|
|`<leader>dc`|Run/Continue|**n**|
|`<leader>dC`|Run to Cursor|**n**|
|`<leader>dg`|Go to Line (No Execute)|**n**|
|`<leader>di`|Step Into|**n**|
|`<leader>dj`|Down|**n**|
|`<leader>dk`|Up|**n**|
|`<leader>dl`|Run Last|**n**|
|`<leader>do`|Step Out|**n**|
|`<leader>dO`|Step Over|**n**|
|`<leader>dP`|Pause|**n**|
|`<leader>dr`|Toggle REPL|**n**|
|`<leader>ds`|Session|**n**|
|`<leader>dt`|Terminate|**n**|
|`<leader>dw`|Widgets|**n**|

## [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui.git)

Part of [lazyvim.plugins.extras.dap.core](https://www.lazyvim.org/extras/dap/core)

|Key|Description|Mode|
|---|---|---|
|`<leader>de`|Eval|**n**, **x**|
|`<leader>du`|Dap UI|**n**|

## [aerial.nvim](https://github.com/stevearc/aerial.nvim.git)

Part of [lazyvim.plugins.extras.editor.aerial](https://www.lazyvim.org/extras/editor/aerial)

|Key|Description|Mode|
|---|---|---|
|`<leader>cs`|Aerial (Symbols)|**n**|

## [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)

Part of [lazyvim.plugins.extras.editor.aerial](https://www.lazyvim.org/extras/editor/aerial)

|Key|Description|Mode|
|---|---|---|
|`<leader>ss`|Goto Symbol (Aerial)|**n**|

## [dial.nvim](https://github.com/monaqa/dial.nvim.git)

Part of [lazyvim.plugins.extras.editor.dial](https://www.lazyvim.org/extras/editor/dial)

|Key|Description|Mode|
|---|---|---|
|`<C-a>`|Increment|**n**, **v**|
|`<C-x>`|Decrement|**n**, **v**|
|`g<C-a>`|Increment|**n**, **x**|
|`g<C-x>`|Decrement|**n**, **x**|

## [harpoon](https://github.com/ThePrimeagen/harpoon.git)

Part of [lazyvim.plugins.extras.editor.harpoon2](https://www.lazyvim.org/extras/editor/harpoon2)

|Key|Description|Mode|
|---|---|---|
|`<leader>1`|Harpoon to File 1|**n**|
|`<leader>2`|Harpoon to File 2|**n**|
|`<leader>3`|Harpoon to File 3|**n**|
|`<leader>4`|Harpoon to File 4|**n**|
|`<leader>5`|Harpoon to File 5|**n**|
|`<leader>6`|Harpoon to File 6|**n**|
|`<leader>7`|Harpoon to File 7|**n**|
|`<leader>8`|Harpoon to File 8|**n**|
|`<leader>9`|Harpoon to File 9|**n**|
|`<leader>h`|Harpoon Quick Menu|**n**|
|`<leader>H`|Harpoon File|**n**|

## [vim-illuminate](https://github.com/RRethy/vim-illuminate.git)

Part of [lazyvim.plugins.extras.editor.illuminate](https://www.lazyvim.org/extras/editor/illuminate)

|Key|Description|Mode|
|---|---|---|
|`[[`|Prev Reference|**n**|
|`]]`|Next Reference|**n**|

## [leap.nvim](https://github.com/ggandor/leap.nvim.git)

Part of [lazyvim.plugins.extras.editor.leap](https://www.lazyvim.org/extras/editor/leap)

|Key|Description|Mode|
|---|---|---|
|`gs`|Leap from Windows|**n**, **o**, **x**|
|`s`|Leap Forward to|**n**, **o**, **x**|
|`S`|Leap Backward to|**n**, **o**, **x**|

## [mini.surround](https://github.com/nvim-mini/mini.surround.git)

Part of [lazyvim.plugins.extras.editor.leap](https://www.lazyvim.org/extras/editor/leap)

|Key|Description|Mode|
|---|---|---|
|`gz`|+surround|**n**|

## [mini.diff](https://github.com/nvim-mini/mini.diff.git)

Part of [lazyvim.plugins.extras.editor.mini-diff](https://www.lazyvim.org/extras/editor/mini-diff)

|Key|Description|Mode|
|---|---|---|
|`<leader>go`|Toggle mini.diff overlay|**n**|

## [mini.files](https://github.com/nvim-mini/mini.files.git)

Part of [lazyvim.plugins.extras.editor.mini-files](https://www.lazyvim.org/extras/editor/mini-files)

|Key|Description|Mode|
|---|---|---|
|`<leader>fm`|Open mini.files (Directory of Current File)|**n**|
|`<leader>fM`|Open mini.files (cwd)|**n**|

## [outline.nvim](https://github.com/hedyhli/outline.nvim.git)

Part of [lazyvim.plugins.extras.editor.outline](https://www.lazyvim.org/extras/editor/outline)

|Key|Description|Mode|
|---|---|---|
|`<leader>cs`|Toggle Outline|**n**|

## [overseer.nvim](https://github.com/stevearc/overseer.nvim.git)

Part of [lazyvim.plugins.extras.editor.overseer](https://www.lazyvim.org/extras/editor/overseer)

|Key|Description|Mode|
|---|---|---|
|`<leader>ob`|Task builder|**n**|
|`<leader>oc`|Clear cache|**n**|
|`<leader>oi`|Overseer Info|**n**|
|`<leader>oo`|Run task|**n**|
|`<leader>oq`|Action recent task|**n**|
|`<leader>ot`|Task action|**n**|
|`<leader>ow`|Task list|**n**|

## [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim.git)

Part of [lazyvim.plugins.extras.editor.refactoring](https://www.lazyvim.org/extras/editor/refactoring)

|Key|Description|Mode|
|---|---|---|
|`<leader>r`|+refactor|**n**, **x**|
|`<leader>rb`|Extract Block|**n**, **x**|
|`<leader>rc`|Debug Cleanup|**n**|
|`<leader>rf`|Extract Function|**n**, **x**|
|`<leader>rF`|Extract Function To File|**n**, **x**|
|`<leader>ri`|Inline Variable|**n**, **x**|
|`<leader>rp`|Debug Print Variable|**n**, **x**|
|`<leader>rP`|Debug Print|**n**|
|`<leader>rs`|Refactor|**n**, **x**|
|`<leader>rx`|Extract Variable|**n**, **x**|

## [snacks.nvim](https://github.com/folke/snacks.nvim.git)

Part of [lazyvim.plugins.extras.editor.snacks_explorer](https://www.lazyvim.org/extras/editor/snacks_explorer)

|Key|Description|Mode|
|---|---|---|
|`<leader>e`|Explorer Snacks (root dir)|**n**|
|`<leader>E`|Explorer Snacks (cwd)|**n**|
|`<leader>fe`|Explorer Snacks (root dir)|**n**|
|`<leader>fE`|Explorer Snacks (cwd)|**n**|

## [snacks.nvim](https://github.com/folke/snacks.nvim.git)

Part of [lazyvim.plugins.extras.editor.snacks_picker](https://www.lazyvim.org/extras/editor/snacks_picker)

|Key|Description|Mode|
|---|---|---|
|`<leader><space>`|Find Files (Root Dir)|**n**|
|`<leader>,`|Buffers|**n**|
|`<leader>/`|Grep (Root Dir)|**n**|
|`<leader>:`|Command History|**n**|
|`<leader>fb`|Buffers|**n**|
|`<leader>fB`|Buffers (all)|**n**|
|`<leader>fc`|Find Config File|**n**|
|`<leader>ff`|Find Files (Root Dir)|**n**|
|`<leader>fF`|Find Files (cwd)|**n**|
|`<leader>fg`|Find Files (git-files)|**n**|
|`<leader>fp`|Projects|**n**|
|`<leader>fr`|Recent|**n**|
|`<leader>fR`|Recent (cwd)|**n**|
|`<leader>gd`|Git Diff (hunks)|**n**|
|`<leader>gD`|Git Diff (origin)|**n**|
|`<leader>gi`|GitHub Issues (open)|**n**|
|`<leader>gI`|GitHub Issues (all)|**n**|
|`<leader>gp`|GitHub Pull Requests (open)|**n**|
|`<leader>gP`|GitHub Pull Requests (all)|**n**|
|`<leader>gs`|Git Status|**n**|
|`<leader>gS`|Git Stash|**n**|
|`<leader>n`|Notification History|**n**|
|`<leader>s"`|Registers|**n**|
|`<leader>s/`|Search History|**n**|
|`<leader>sa`|Autocmds|**n**|
|`<leader>sb`|Buffer Lines|**n**|
|`<leader>sB`|Grep Open Buffers|**n**|
|`<leader>sc`|Command History|**n**|
|`<leader>sC`|Commands|**n**|
|`<leader>sd`|Diagnostics|**n**|
|`<leader>sD`|Buffer Diagnostics|**n**|
|`<leader>sg`|Grep (Root Dir)|**n**|
|`<leader>sG`|Grep (cwd)|**n**|
|`<leader>sh`|Help Pages|**n**|
|`<leader>sH`|Highlights|**n**|
|`<leader>si`|Icons|**n**|
|`<leader>sj`|Jumps|**n**|
|`<leader>sk`|Keymaps|**n**|
|`<leader>sl`|Location List|**n**|
|`<leader>sm`|Marks|**n**|
|`<leader>sM`|Man Pages|**n**|
|`<leader>sp`|Search for Plugin Spec|**n**|
|`<leader>sq`|Quickfix List|**n**|
|`<leader>sR`|Resume|**n**|
|`<leader>su`|Undotree|**n**|
|`<leader>sw`|Visual selection or word (Root Dir)|**n**, **x**|
|`<leader>sW`|Visual selection or word (cwd)|**n**, **x**|
|`<leader>uC`|Colorschemes|**n**|

## [todo-comments.nvim](https://github.com/folke/todo-comments.nvim.git)

Part of [lazyvim.plugins.extras.editor.snacks_picker](https://www.lazyvim.org/extras/editor/snacks_picker)

|Key|Description|Mode|
|---|---|---|
|`<leader>st`|Todo|**n**|
|`<leader>sT`|Todo/Fix/Fixme|**n**|

## [nvim-ansible](https://github.com/mfussenegger/nvim-ansible.git)

Part of [lazyvim.plugins.extras.lang.ansible](https://www.lazyvim.org/extras/lang/ansible)

|Key|Description|Mode|
|---|---|---|
|`<leader>ta`|Ansible Run Playbook/Role|**n**|

## [haskell-tools.nvim](https://github.com/mrcjkb/haskell-tools.nvim.git)

Part of [lazyvim.plugins.extras.lang.haskell](https://www.lazyvim.org/extras/lang/haskell)

|Key|Description|Mode|
|---|---|---|
|`<localleader>e`|Evaluate All|**n**|
|`<localleader>h`|Hoogle Signature|**n**|
|`<localleader>r`|REPL (Package)|**n**|
|`<localleader>R`|REPL (Buffer)|**n**|

## [telescope_hoogle](https://github.com/luc-tielen/telescope_hoogle.git)

Part of [lazyvim.plugins.extras.lang.haskell](https://www.lazyvim.org/extras/lang/haskell)

|Key|Description|Mode|
|---|---|---|
|`<localleader>H`|Hoogle|**n**|

## [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim.git)

Part of [lazyvim.plugins.extras.lang.markdown](https://www.lazyvim.org/extras/lang/markdown)

|Key|Description|Mode|
|---|---|---|
|`<leader>cp`|Markdown Preview|**n**|

## [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python.git)

Part of [lazyvim.plugins.extras.lang.python](https://www.lazyvim.org/extras/lang/python)

|Key|Description|Mode|
|---|---|---|
|`<leader>dPc`|Debug Class|**n**|
|`<leader>dPt`|Debug Method|**n**|

## [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim.git)

Part of [lazyvim.plugins.extras.lang.python](https://www.lazyvim.org/extras/lang/python)

|Key|Description|Mode|
|---|---|---|
|`<leader>cv`|Select VirtualEnv|**n**|

## [nvim-metals](https://github.com/scalameta/nvim-metals.git)

Part of [lazyvim.plugins.extras.lang.scala](https://www.lazyvim.org/extras/lang/scala)

|Key|Description|Mode|
|---|---|---|
|`<leader>mc`|Metals compile cascade|**n**|
|`<leader>me`|Metals commands|**n**|
|`<leader>mh`|Metals hover worksheet|**n**|

## [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui.git)

Part of [lazyvim.plugins.extras.lang.sql](https://www.lazyvim.org/extras/lang/sql)

|Key|Description|Mode|
|---|---|---|
|`<leader>D`|Toggle DBUI|**n**|

## [vimtex](https://github.com/lervag/vimtex.git)

Part of [lazyvim.plugins.extras.lang.tex](https://www.lazyvim.org/extras/lang/tex)

|Key|Description|Mode|
|---|---|---|
|`<localLeader>l`|+vimtex|**n**|

## [typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim.git)

Part of [lazyvim.plugins.extras.lang.typst](https://www.lazyvim.org/extras/lang/typst)

|Key|Description|Mode|
|---|---|---|
|`<leader>cp`|Toggle Typst Preview|**n**|

## [neotest](https://github.com/nvim-neotest/neotest.git)

Part of [lazyvim.plugins.extras.test.core](https://www.lazyvim.org/extras/test/core)

|Key|Description|Mode|
|---|---|---|
|`<leader>t`|+test|**n**|
|`<leader>ta`|Attach to Test (Neotest)|**n**|
|`<leader>tl`|Run Last (Neotest)|**n**|
|`<leader>to`|Show Output (Neotest)|**n**|
|`<leader>tO`|Toggle Output Panel (Neotest)|**n**|
|`<leader>tr`|Run Nearest (Neotest)|**n**|
|`<leader>ts`|Toggle Summary (Neotest)|**n**|
|`<leader>tS`|Stop (Neotest)|**n**|
|`<leader>tt`|Run File (Neotest)|**n**|
|`<leader>tT`|Run All Test Files (Neotest)|**n**|
|`<leader>tw`|Toggle Watch (Neotest)|**n**|

## [nvim-dap](https://github.com/mfussenegger/nvim-dap.git)

Part of [lazyvim.plugins.extras.test.core](https://www.lazyvim.org/extras/test/core)

|Key|Description|Mode|
|---|---|---|
|`<leader>td`|Debug Nearest|**n**|

## [edgy.nvim](https://github.com/folke/edgy.nvim.git)

Part of [lazyvim.plugins.extras.ui.edgy](https://www.lazyvim.org/extras/ui/edgy)

|Key|Description|Mode|
|---|---|---|
|`<leader>ue`|Edgy Toggle|**n**|
|`<leader>uE`|Edgy Select Window|**n**|

## [chezmoi.nvim](https://github.com/xvzc/chezmoi.nvim.git)

Part of [lazyvim.plugins.extras.util.chezmoi](https://www.lazyvim.org/extras/util/chezmoi)

|Key|Description|Mode|
|---|---|---|
|`<leader>sz`|Chezmoi|**n**|

## [gh.nvim](https://github.com/ldelossa/gh.nvim.git)

Part of [lazyvim.plugins.extras.util.gh](https://www.lazyvim.org/extras/util/gh)

|Key|Description|Mode|
|---|---|---|
|`<leader>G`|+Github|**n**|
|`<leader>Gc`|+Commits|**n**|
|`<leader>Gcc`|Close|**n**|
|`<leader>Gce`|Expand|**n**|
|`<leader>Gco`|Open To|**n**|
|`<leader>Gcp`|Pop Out|**n**|
|`<leader>Gcz`|Collapse|**n**|
|`<leader>Gi`|+Issues|**n**|
|`<leader>Gio`|Open|**n**|
|`<leader>Gip`|Preview|**n**|
|`<leader>Gl`|+Litee|**n**|
|`<leader>Glt`|Toggle Panel|**n**|
|`<leader>Gp`|+Pull Request|**n**|
|`<leader>Gpc`|Close|**n**|
|`<leader>Gpd`|Details|**n**|
|`<leader>Gpe`|Expand|**n**|
|`<leader>Gpo`|Open|**n**|
|`<leader>Gpp`|PopOut|**n**|
|`<leader>Gpr`|Refresh|**n**|
|`<leader>Gpt`|Open To|**n**|
|`<leader>Gpz`|Collapse|**n**|
|`<leader>Gr`|+Review|**n**|
|`<leader>Grb`|Begin|**n**|
|`<leader>Grc`|Close|**n**|
|`<leader>Grd`|Delete|**n**|
|`<leader>Gre`|Expand|**n**|
|`<leader>Grs`|Submit|**n**|
|`<leader>Grz`|Collapse|**n**|
|`<leader>Gt`|+Threads|**n**|
|`<leader>Gtc`|Create|**n**|
|`<leader>Gtn`|Next|**n**|
|`<leader>Gtt`|Toggle|**n**|

## [mason.nvim](https://github.com/mason-org/mason.nvim.git)

Part of [lazyvim.plugins.extras.util.gitui](https://www.lazyvim.org/extras/util/gitui)

|Key|Description|Mode|
|---|---|---|
|`<leader>gg`|GitUi (Root Dir)|**n**|
|`<leader>gG`|GitUi (cwd)|**n**|

## [octo.nvim](https://github.com/pwntester/octo.nvim.git)

Part of [lazyvim.plugins.extras.util.octo](https://www.lazyvim.org/extras/util/octo)

|Key|Description|Mode|
|---|---|---|
|`<leader>gi`|List Issues (Octo)|**n**|
|`<leader>gI`|Search Issues (Octo)|**n**|
|`<leader>gp`|List PRs (Octo)|**n**|
|`<leader>gP`|Search PRs (Octo)|**n**|
|`<leader>gr`|List Repos (Octo)|**n**|
|`<leader>gS`|Search (Octo)|**n**|
|`<localleader>a`|+assignee (Octo)|**n**|
|`<localleader>c`|+comment/code (Octo)|**n**|
|`<localleader>g`|+goto_issue (Octo)|**n**|
|`<localleader>i`|+issue (Octo)|**n**|
|`<localleader>l`|+label (Octo)|**n**|
|`<localleader>p`|+pr (Octo)|**n**|
|`<localleader>pr`|+rebase (Octo)|**n**|
|`<localleader>ps`|+squash (Octo)|**n**|
|`<localleader>r`|+react (Octo)|**n**|
|`<localleader>v`|+review (Octo)|**n**|

## [fzf-lua](https://github.com/ibhagwan/fzf-lua.git)

Part of [lazyvim.plugins.extras.util.project](https://www.lazyvim.org/extras/util/project)

|Key|Description|Mode|
|---|---|---|
|`<leader>fp`|Projects|**n**|

## [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git)

Part of [lazyvim.plugins.extras.util.project](https://www.lazyvim.org/extras/util/project)

|Key|Description|Mode|
|---|---|---|
|`<leader>fp`|Projects|**n**|

## [kulala.nvim](https://github.com/mistweaverco/kulala.nvim.git)

Part of [lazyvim.plugins.extras.util.rest](https://www.lazyvim.org/extras/util/rest)

|Key|Description|Mode|
|---|---|---|
|`<leader>R`|+Rest|**n**|
|`<leader>Rb`|Open scratchpad|**n**|
|`<leader>Rc`|Copy as cURL|**n**|
|`<leader>RC`|Paste from curl|**n**|
|`<leader>Re`|Set environment|**n**|
|`<leader>Rg`|Download GraphQL schema|**n**|
|`<leader>Ri`|Inspect current request|**n**|
|`<leader>Rn`|Jump to next request|**n**|
|`<leader>Rp`|Jump to previous request|**n**|
|`<leader>Rq`|Close window|**n**|
|`<leader>Rr`|Replay the last request|**n**|
|`<leader>Rs`|Send the request|**n**|
|`<leader>RS`|Show stats|**n**|
|`<leader>Rt`|Toggle headers/body|**n**|

[Edit this page](https://github.com/LazyVim/lazyvim.github.io/tree/main/docs/keymaps.md)

[

Previous

📰 What's new?

](https://www.lazyvim.org/news)[

Next

⚙️ Configuration

](https://www.lazyvim.org/configuration)

Docs

- [Getting Started](https://www.lazyvim.org/)

Community

- [Discussions](https://github.com/LazyVim/LazyVim/discussions)
- [Twitter](https://twitter.com/folke)

More

- [GitHub](https://github.com/LazyVim/LazyVim)

Copyright © 2025 LazyVim, Inc. Built with Docusaurus.

[](chrome://extensions/shortcuts)