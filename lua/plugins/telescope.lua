return {
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      return {
        {
          "<leader>,",
          "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
          desc = "切换 Buffer",
        },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "History Commands" },
        { "<leader><space>", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "切换 Buffer" },
        { "<leader>fc", LazyVim.pick.config_files(), desc = "搜索配置文件" },
        { "<leader>ff", LazyVim.pick("files"), desc = "搜索文件" },
        { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "当前目录搜索文件" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
        -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
        { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
        { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
        { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
        { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
        { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
        {
          "<leader>ss",
          function()
            require("telescope.builtin").lsp_document_symbols({
              symbols = LazyVim.config.get_kind_filter(),
            })
          end,
          desc = "Goto Symbol",
        },
        {
          "<leader>sS",
          function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols({
              symbols = LazyVim.config.get_kind_filter(),
            })
          end,
          desc = "Goto Symbol (Workspace)",
        },
      }
    end,
    opts = function()
      local actions = require("telescope.actions")

      local function find_command()
        if 1 == vim.fn.executable("rg") then
          return { "rg", "--files", "--color", "never", "-g", "!.git" }
        elseif 1 == vim.fn.executable("fd") then
          return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("fdfind") then
          return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
        elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
          return { "find", ".", "-type", "f" }
        elseif 1 == vim.fn.executable("where") then
          return { "where", "/r", ".", "*" }
        end
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]" },
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              -- ["<c-t>"] = open_with_trouble,
              -- ["<a-t>"] = open_with_trouble,
              -- ["<a-i>"] = find_files_no_ignore,
              -- ["<a-h>"] = find_files_with_hidden,
              ["<D-k>"] = actions.preview_scrolling_up,
              ["<D-j>"] = actions.preview_scrolling_down,
              ["<D-h>"] = actions.preview_scrolling_left,
              ["<D-l>"] = actions.preview_scrolling_right,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<M-f>"] = actions.results_scrolling_left,
              ["<M-k>"] = actions.results_scrolling_right,
            },
            n = {
              ["q"] = actions.close,
              ["<D-k>"] = actions.preview_scrolling_up,
              ["<D-j>"] = actions.preview_scrolling_down,
              ["<D-h>"] = actions.preview_scrolling_left,
              ["<D-l>"] = actions.preview_scrolling_right,
              ["h"] = actions.results_scrolling_left,
              ["l"] = actions.results_scrolling_right,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = find_command,
            hidden = true,
          },
        },
      }
    end,
  },
}
