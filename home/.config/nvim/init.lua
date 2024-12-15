local augroup = vim.api.nvim_create_augroup("vimrc", { clear = true })

-- {{{ General

-- keep backup file after overwriting a file
vim.opt.backup = true
-- default backupdir is .,~/.local/state/nvim/backup//
vim.opt.backupdir:remove(".")
-- save undo information in a file
vim.opt.undofile = true
-- ignore case in search patterns
vim.opt.ignorecase = true
-- no ignore case when pattern has uppercase
vim.opt.smartcase = true

vim.cmd("silent! packadd! cfilter")

-- }}}
-- {{{ Editing

-- Use the appropriate number of spaces to insert a <Tab>
vim.opt.expandtab = true
-- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2
-- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.softtabstop = 2
-- Copy the structure of the existing lines indent when autoindenting a new line
vim.opt.copyindent = true
-- When changing the indent of the current line, preserve as much of the indent structure as possible.
vim.opt.preserveindent = true
-- how automatic formatting is to be done (useful for Asian text)
vim.opt.formatoptions:append("mB")
-- a list of character encodings considered when starting to edit an existing file
vim.opt.fileencodings = {
  "ucs-bom",
  "utf-8",
  "iso-2022-jp",
  "euc-jp",
  "cp932",
  "default",
  "latin1",
}

-- }}}
-- {{{ UI

-- highlighted column at
vim.opt.colorcolumn = "81"
vim.opt.foldenable = false
-- Markers are used to specify folds
vim.opt.foldmethod = "marker"
vim.opt.lazyredraw = true
-- the use of the mouse is enabled in all modes
vim.opt.mouse = "a"
vim.opt.number = true
-- When a bracket is inserted, briefly jump to the matching one
vim.opt.showmatch = true
-- the title of the window will be set to the value of 'titlestring'
vim.opt.title = true
-- case is ignored when completing file names and directories
vim.opt.wildignorecase = true
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "algorithm:histogram",
  "indent-heuristic",
}

-- highlight trailing spaces
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "ColorScheme" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd([[highlight TrailingSpaces term=underline guibg=Red ctermbg=Red]])
    vim.cmd([[match TrailingSpaces /\s\+$/]])
  end,
})

-- }}}
-- {{{ Keybindings

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- go to next modified buffer
vim.keymap.set("n", "<Leader>b", "<Cmd>bmodified<CR>")
-- find merge conflict marker
vim.keymap.set({"n", "x", "o"}, "<Leader>fc", [[/\v^[<=>]{7}( .*<Bar>$)<CR>]])

-- text objects
--- select the entire current line in Visual mode
vim.keymap.set("x", "al", "<Esc>0v$")
--- select the inner part of the current line in Visual mode
vim.keymap.set("x", "il", "<Esc>^vg_")
--- select the inner part of the current line in Operator-pending mode
vim.keymap.set("o", "il", "<Cmd>normal! ^vg_<CR>")
--- select the entire file in visual mode
vim.keymap.set("x", "ag", "gg0oG$")
--- select the entire file while preserving the cursor in Operator-pending mode
vim.keymap.set("o", "ag", [[<Cmd>exe "normal! m`"<Bar>keepjumps normal! ggVG<CR>]])

-- toggles
--- spell checking
vim.keymap.set("n", "<Leader>ts", "<Cmd>setlocal spell! spell?<CR>")
-- show the line number relative to the current line
vim.keymap.set("n", "<Leader>t#", "<Cmd>setlocal relativenumber! relativenumber?<CR>")

-- }}}

vim.keymap.set('n', '<C-q>', '<Nop>')
vim.keymap.set('v', '<C-q>', '<Nop>')
