local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        -- basic configuration {{{
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        -- some appearance settings
        -- set_env = { ['TERM'] = vim.env.TERM },
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        -- borderchars = {
        --   { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        --   -- { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        --   -- prompt = { '', '', ' ', '', '', '', '', '' },
        --   -- results = { '', '', '', '', '', '', '', '' },
        --   -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        --   -- preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- },
        prompt_prefix = "   ", -- alternative : 
        selection_caret = " ➜ ", -- alternative : »
        entry_prefix = "   ",
        winblend = 0,
        file_ignore_patterns = { "%.jpg", "%.jpeg", "%.png", "%.otf", "%.ttf" },
        path_display = { "smart", "absolute", "truncate" },

        -- main behavior stuff
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "bottom_pane", -- 'flex', 'horizontal'
        prompt_position = "bottom",
        layout_config = {
            -- prompt_position = "bottom",
            preview_cutoff = 100,
            horizontal = { mirror = false, preview_width = 0.45 },
            vertical = { mirror = false },
        },

        color_devicons = true,
        use_less = true,
        -- sorters and previewers
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

        -- }}}

        -- set mappings TODO: think on best mappings {{{
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },

        -- }}}

        -- where to look for the history {{{
        history = {
            path = vim.fn.stdpath "data" .. "/telescope_history.sqlite3",
        },

        -- }}}
    },

    -- set pickers titles and options {{{
    pickers = {
        buffers = {
            prompt_prefix = " B  ",
            -- sort_mru = true,
            -- sort_lastused = true,
            -- show_all_buffers = true,
            -- ignore_current_buffer = true,
            -- previewer = true,
            -- mappings = {
            --   i = { ['<c-x>'] = 'delete_buffer' },
            --   n = { ['<c-x>'] = 'delete_buffer' },
            -- },
        },

        oldfiles = {
            prompt_prefix = " O  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
            file_ignore_patterns = { ".git/" },
        },

        live_grep = {
            prompt_prefix = "LG  ",
            results_title = "",
            preview_title = "",
            prompt_title = "Ripgrep Live Grep",
            file_ignore_patterns = { ".git/" },
        },

        current_buffer_fuzzy_find = {
            prompt_prefix = "GB  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
            previewer = false,
            shorten_path = false,
        },

        lsp_code_actions = {
            theme = "cursor",
        },

        colorscheme = {
            enable_preview = true,
        },

        find_files = {
            prompt_prefix = " F  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
            hidden = true,
            file_ignore_patterns = { ".git/" },
        },

        git_branches = {
            prompt_prefix = " F  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
        },

        git_bcommits = {
            prompt_prefix = " F  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
            layout_config = {
                horizontal = {
                    preview_width = 0.55,
                },
            },
        },

        git_commits = {
            prompt_prefix = " F  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
            layout_config = {
                horizontal = {
                    preview_width = 0.55,
                },
            },
        },

        reloader = {
            prompt_prefix = " R  ",
            results_title = "",
            preview_title = "",
            prompt_title = "",
        },
    },

    -- }}}

    -- plug some extensions {{{
    extensions = {
        frecency = {
            workspaces = {
                conf = vim.env.DOTFILES,
                project = vim.env.PROJECTS_DIR,
                wiki = vim.g.wiki_path,
            },
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
        },
        bibtex = {
            -- Depth for the *.bib file
            depth = 2,
            -- Custom format for citation label
            custom_formats = {},
            -- Format to use for citation label.
            -- Try to match the filetype by default, or use 'plain'
            format = '',
            -- Path to global bibliographies (placed outside of the project)
            global_files = {},
            -- Define the search keys to use in the picker
            search_keys = { 'label', 'author', 'year', 'title' },
            -- Template for the formatted citation
            --[[ citation_format = '{{author}} ({{year}}) -> {{title}}.', ]]
            citation_format = "[[^@{{label}}]]: {{author}} ({{year}}), {{title}}.",
            -- Only use initials for the authors first name
            citation_trim_firstname = true,
            -- Max number of authors to write in the formatted citation
            -- following authors will be replaced by "et al."
            citation_max_auth = 2,
            -- Context awareness disabled by default
            context = false,
            -- Fallback to global/directory .bib files if context not found
            -- This setting has no effect if context = false
            context_fallback = true,
            -- Wrapping in the preview window is disabled by default
            wrap = false,
        },
    },

    -- }}}
}

-- Custom functions {{{

local function frecency()
    telescope.extensions.frecency.frecency {
        -- NOTE: remove default text as it's slow
        -- default_text = ':CWD:',
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false,
    }
end

-- fzf dotfiles from anywhere
local function search_dotfiles()
    require("telescope.builtin").find_files {
        prompt_title = "Search fictional couscous",
        cwd = "~/.dotfiles",
        show_line = false,
        -- results_title = '',
        -- preview_title = '',
        no_ignore = true,
        hidden = true,
    }
end

local function search_dotfiles()
    require("telescope.builtin").find_files {
        prompt_title = "Search nvim config",
        cwd = "~/.config/nvim",
        show_line = false,
        -- results_title = '',
        -- preview_title = '',
        no_ignore = true,
        hidden = true,
    }
end

local function gh_notifications()
    telescope.extensions.ghn.ghn()
end

local function installed_plugins()
    require("telescope.builtin").find_files {
        cwd = os.getenv "HOME" .. "/.local/share/nvim/site/pack/packer",
    }
end

local function tmux_sessions()
    telescope.extensions.tmux.sessions {}
end

local function tmux_windows()
    telescope.extensions.tmux.windows {
        entry_format = "#S: #T",
    }
end

-- }}}

-- Keymapings {{{

-- language server {{{

require("which-key").register({
    ["l"] = {
        name = "lsp",
        ["d"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
        ["q"] = { "<cmd>Telescope quickfix<cr>" }, -- builtins.lsp_document_symbols "Quickfix")
        ["s"] = { "<cmd>Telescope lsp_document_symbols<cr>" }, -- builtins.lsp_document_symbols "Document Symbols")
        ["w"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" }, -- builtins.lsp_dynamic_workspace_symbols "Workspace Symbols")
    },
}, { mode = "n", buffer = nil, silent = true, noremap = true, nowait = true, prefix = "<leader>" })
require("which-key").register({
    ["t"] = {
        name = "Tools",
        ["b"] = { "<cmd>Telescope bibtex<cr>", "Bibliography" },
    },
}, { mode = "n", buffer = nil, silent = true, noremap = true, nowait = true, prefix = "<leader>" })

-- }}}

-- finding stuff {{{

-- core.map({'n'}, "<leader>fa", builtins.builtin, "Builtins")  --NOTE I dont understand this
-- require('which-key').register({
--   ["<leader>"] = { "<cmd>Telescope find_files<cr>", "Find file" }, -- builtins.find_files core.map({'n'}, "<leader>ff", "<cmd>Telescope find_files<cr>", "Find File") -- builtins.find_files
--   ["b"]  = { "<cmd>Telescope buffers<cr>", "Search in current buffer" },
--   ['f'] = {
--     name = 'find',
--     ["b"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in current bufferr" },
--     ["c"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
--     ["C"] = { "<cmd>Telescope commands<cr>", "Commands" },
--     ["d"] = { search_dotfiles, "Dotfiles" },  --NOTE I dont understand this
--     ["g"] = { "<cmd>Telescope live_grep<cr>", "Live grep text" },
--     ["m"] = { "<cmd>Telescope man_pages<cr>", "Man Page" }, -- builtins.man_pages
--     ["n"] = { search_dotfiles, "Dotfiles" },  --NOTE I dont understand this
--     ["r"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--     ["R"] = { "<cmd>Telescope registers<cr>", "Registers" },
--     ["k"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
--     ["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },  -- builtins.help_tags
--     },
--   },
--   { mode = 'n', buffer = nil, silent = true, noremap = true, nowait = true,
--     prefix = "<leader>" }
-- )

-- core.map({'n'}, "<leader>fn", gh_notifications, "Find Help")

-- require('which-key').register {
--   ['<c-p>'] = { project_files, 'telescope: find files' },
--   ['<leader>f'] = {
--     name = '+telescope',
--     h = { frecency, 'history' },
--     c = { nvim_config, 'nvim config' },
--     o = { builtins.buffers, 'buffers' },
--     p = { installed_plugins, 'plugins' },
--     O = { orgfiles, 'org files' },
--     N = { norgfiles, 'norg files' },
--     R = { builtins.reloader, 'module reloader' },
--     r = { builtins.resume, 'resume last picker' },
--     s = { builtins.live_grep, 'grep string' },
--     t = {
--       name = '+tmux',
--       s = { tmux_sessions, 'sessions' },
--       w = { tmux_windows, 'windows' },
--     },
--   },
-- }
-- }}}

-- }}}

-- vim: fdm=marker
