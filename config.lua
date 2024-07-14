--[[ lvim is the global options object

Linters should be
a global executable or a path to
filled in as strings with either
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general

if vim.loader then
  vim.loader.enable()
end

lvim.log.level = "warn"
lvim.format_on_save.enabled = false
-- lvim.colorscheme = "catppuccin-mocha"
lvim.colorscheme = "oh-lucy"
lvim.builtin.bufferline.active = false
lvim.builtin.lualine.options.theme = "nightfly"
--
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"                     -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.g.copilot_assume_mapped = true
-- lvim.transparent_window = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-x>"] = ":BufferKill<cr>"       --
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"       --
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"      -- center after page up
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"      -- center after page down
lvim.keys.normal_mode["n"] = "nzz"              -- center after search
lvim.keys.normal_mode["N"] = "Nzz"              -- center after search
lvim.keys.insert_mode["<C-e>"] = "<C-o>A"       -- insert at the end of the line
lvim.keys.visual_mode["K"] = ":m '>+1<CR>gv=gv" -- shift code upper
lvim.keys.visual_mode["J"] = ":m '>-2<CR>gv=gv" -- shift code lower
lvim.keys.normal_mode["-"] = ":Oil<CR>"         -- open oil
vim.cmd [[
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
]]
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }
--



lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension "harpoon"

  local current_theme = vim.g.colors_name
  if current_theme == "catppuccin" then
    local colors = require("catppuccin.palettes").get_palette()
    local TelescopeColor = {
      TelescopeMatching = { fg = colors.flamingo },
      TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

      TelescopePromptPrefix = { bg = colors.surface0 },
      TelescopePromptNormal = { bg = colors.surface0 },
      TelescopeResultsNormal = { bg = colors.mantle },
      TelescopePreviewNormal = { bg = colors.mantle },
      TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
      TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
      TelescopeResultsTitle = { fg = colors.mantle },
      TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    }

    for hl, col in pairs(TelescopeColor) do
      vim.api.nvim_set_hl(0, hl, col)
    end
  end
end

-- horizontal layout for live grep picker
lvim.builtin.telescope.pickers.live_grep = {
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.9,
    height = 0.8,
  },
}

---- Harpoon Keybinding
lvim.builtin.which_key.mappings["1"] = { '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', "Goto File 1" }
lvim.builtin.which_key.mappings["2"] = { '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', "Goto File 2" }
lvim.builtin.which_key.mappings["3"] = { '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', "Goto File 3" }
lvim.builtin.which_key.mappings["4"] = { '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', "Goto File 4" }
lvim.builtin.which_key.mappings["h"] = {
  name = 'Harpoon',
  a = { '<cmd>lua require("harpoon.mark").add_file()<CR>', "Add" },
  h = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Menu" },
  n = { '<cmd>lua require("harpoon.ui").nav_next()<CR>', "Next" },
  p = { '<cmd>lua require("harpoon.ui").nav_prev()<CR>', "Prev" }
}

lvim.builtin.which_key.mappings["r"] = {
  name = 'Replace',
  r = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace In File" },
  p = { "<cmd>lua require('spectre').open()<CR>", "Replace In Project" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Current Word" },
}

lvim.builtin.which_key.mappings["o"] = { '<cmd>Telescope buffers<CR>', "Open Buffers" }
lvim.builtin.which_key.mappings["sT"] = { '<cmd>TodoTelescope<cr>', "Todo" }
lvim.builtin.which_key.mappings["ss"] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', "Find in buffer" }
lvim.builtin.which_key.mappings["sc"] = {
  '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({default_text=vim.fn.expand("<cword>")})<cr>',
  "Find current word in project" }
lvim.builtin.which_key.mappings["n"] = { '<cmd>BufferLineCycleNext<CR>', "Next Buffer" }

lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings["e"] = {}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- ESLint
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    exe = "eslint_d",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
    }
  },
  {
    command = "mypy",
    filetypes = {
      "python",
    }
  }
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}


lvim.plugins = {
  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        patterns = {
          {
            file_pattern = '*.env',
            cloak_pattern = '=.+',
            replace = nil,
          },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "wojciechkepka/vim-github-dark",
  },
  { "Yazeed1s/oh-lucy.nvim" },
  {
    "catppuccin/nvim",
  },
  {
    "ThePrimeagen/harpoon",
  },
  {
    "bluz71/vim-nightfly-colors"
  },
  {
    'mfussenegger/nvim-dap'
  },
  {
    "mfussenegger/nvim-dap-python",
  },
  {
    "rcarriga/nvim-dap-ui",
  },
  {
    'nyoom-engineering/oxocarbon.nvim'
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        keymaps = {
          ["l"] = "actions.select",
        },
      })
    end
  },
  {
    "anuvyklack/pretty-fold.nvim",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
  },
  {
    "vimwiki/vimwiki",
  },
  {
    "tools-life/taskwiki"
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      {
        "s",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump(
            {
              search = {
                mode = function(str)
                  return "\\<" .. str
                end,
              },
            }
          )
        end,
        desc = "Flash"
      },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      {
        "<Leader>j",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^"
          })
        end,
        desc = "Flash Treesitter"
      },
      {
        "<Leader>k",
        mode = { "n", "o", "x" },
        function()
          require("flash").jump({
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^"
          })
        end,
        desc = "Flash Treesitter"
      },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  }
}

  -- {
  --   "github/copilot.vim",
  --   init = function()
  --     vim.g.copilot_no_tab_map = true
  --   end,
    -- config = function()
    --   vim.keymap.set('i', '<C-w>', [[copilot#Accept("\<CR>")]], {
    --     silent = true,
    --     expr = true,
    --     script = true,
    --     replace_keycodes = false,
    --   })
    -- end,
  -- },

-- Debug Configuration
lvim.builtin.dap.active = true

-- python
local dap_python = require 'dap-python'
dap_python.setup('/usr/bin/python3')

local dap = require 'dap'

dap.adapters.python_remote = {
  type = 'server',
  host = '127.0.0.1',
  port = 8001,
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
  },
  {
    type = 'python_remote',
    name = 'Generic remote',
    request = 'attach',
    pathMappings = { {
      -- Update this as needed
      localRoot = vim.fn.getcwd(),
      remoteRoot = "/",
    } },
  },
}

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


require('pretty-fold').setup({
  matchup_patterns = {
    { '{',  '}' },
    { '%(', ')' }, -- % to escape lua pattern char
    { '%[', ']' }, -- % to escape lua pattern char
  },
})

require("luasnip.loaders.from_vscode").lazy_load()


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- add `pyright` to `skipped_servers` list
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- remove `jedi_language_server` from `skipped_servers` list
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "pylsp"
-- end, lvim.lsp.automatic_configuration.skipped_servers)
--
--
