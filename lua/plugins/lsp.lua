return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
  },
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        enabled = true,
        runtime = true,
        plugins = true,
        types = true,
      },
      setup_jsonls = true,
      lspconfig = true,
      pathStrict = true,

    }
  },
  {
    'aznhe21/actions-preview.nvim',
    keys = { 'gf' },
    config = function()
      local actions_preview = require 'actions-preview'
      vim.keymap.set({ 'v', 'n' }, 'gf', actions_preview.code_actions)

      actions_preview.setup {
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = 'top',
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      }
    end,
  },
  {
    'williamboman/mason.nvim',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require 'mason'.setup()
      require 'mason-lspconfig'.setup {
        automatic_installation = true,
        ensure_installed = { 'lua_ls', 'jsonls' }
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'lukas-reineke/lsp-format.nvim' },
    config = function()
      local lspconfig = require 'lspconfig'
      local lspformat = require 'lsp-format'
      lspformat.setup { inlay_hints = { enabled = true } }
      local on_attach = lspformat.on_attach

      local handlers = {
        function(server_name)
          local server = require("lspconfig")[server_name]
          server.setup { on_attach = on_attach }
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ["rust_analyzer"] = function()
          require("rust-tools").setup {}
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup {
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                }
              }
            }
          }
        end,
        ["clangd"] = function()
          local cmp_nvim_lsp = require "cmp_nvim_lsp"
          lspconfig.clangd.setup {
            on_attach = on_attach,
            capabilities = cmp_nvim_lsp.default_capabilities(),
            cmd = {
              "clangd",
              "--offset-encoding=utf-16",
            }
          }
        end,
        ["basedpyright"] = function()
          lspconfig.basedpyright.setup {
            on_attach = on_attach,
            settings = { pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
              strictOptional = true
            },
              basedpyright = {
                analysis = {
                  typeCheckingMode = "basic"
                },
              }
            },
          }
        end,
      }

      -- alt 1. Either pass handlers when setting up mason-lspconfig:
      require("mason-lspconfig").setup({ handlers = handlers })
      require 'mason'.setup()
      require 'mason-lspconfig'.setup()

      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      vim.keymap.set('n', '<space>r', vim.lsp.codelens.run)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" },
        json = { "jsonlint" },
        dockerfile = { "hadolint" },
        terraform = { "tflint" },
      }

      -- Create an autocmd to trigger linting
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },
  {
    "rshkarin/mason-nvim-lint",
    opts = { quiet_mode = true }
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    ft = { "elixir", "heex" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")
      local lspformat = require 'lsp-format'

      elixir.setup {
        nextls = {
          enable = true,
        },
        elixirls = {
          enable = true,
          tag = "v0.22.1",
          settings = elixirls.settings {
            dialyzerEnabled = true,
            enableTestLenses = true,
            suggestSpecs = true
          },
          on_attach = function(client, bufnr)
            lspformat.on_attach(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>",
              { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>",
              { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>",
              { buffer = true, noremap = true })
          end,
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set('i', '<F8>', 'copilot#Accept("") . "<Esc>:w<CR>"', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    lazy = false,
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      --debug = true, -- Enable debugging
      model = "claude-3.7-sonnet-thought",
      show_folds = false
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      -- Define custom git project context
      opts.contexts = {
        git_project = {
          resolve = function()
            local handle = io.popen('git ls-tree -r HEAD --name-only')
            local files = {}
            if handle then
              for file in handle:lines() do
                local content = vim.fn.readfile(file)
                if content then
                  table.insert(files, { filename = file, content = table.concat(content, '\n') })
                end
              end
              handle:close()
            end
            return files
          end,
        }
      }

      local base_system_prompt = string.format([[
You are an expert in Python, C, Elixir and others with a profound knowledge and understanding of programming languages.
You prefer a functional programming paradigm.
Your answers are very brief, and if they should be code snippets, you answer with the code—no comments. You write incredibly efficient and direct code.

The user is working on a %s machine. Please respond with system specific commands if applicable.

IMPORTANT: Every code block MUST have a header with this exact format:
[file:<file_name>](<file_path>) line:<start_line>-<end_line>
The line numbers are REQUIRED - never omit them.
Always prefer full diffs over partial diffs, try to condense as much changes as possible into a single diff.
If the file is under 200 lines, include the entire file in the diff.

Often you will be asked to fix or change the code. If you do, always check and address any diagnostics issues.

If response would be too long:
   - Never cut off in the middle of a code block
   - Complete the current code block
   - End with "**`[Response truncated] Please ask for the remaining changes.`**"
   - Next response should continue with the next code block

      ]], vim.loop.os_uname().sysname)

      opts.system_prompt = base_system_prompt

      opts.prompts = {
        ExplainAllBuffers = {
          prompt = "> #buffers:all\n\nExplain all open buffers:",
        },
        GenerateAllBuffers = {
          prompt =
          "> #buffers:all\n\nGenerate code based on all open buffers and the following request:\n",
        },
        ExplainProject = {
          prompt =
          "> /COPILOT_EXPLAIN\n$gemini-2.0-flash-001\n> #git_project\n\nExplain all the code in the project in addition to the following question:\n",
        },
        GenerateProject = {
          prompt =
          "> $gemini-2.0-flash-001\n> #git_project\n\nGenerate code based on the entire project and the following request:\n",
        },
        AskProject = {
          prompt =
          "> #git_project\n$gemini-2.0-flash-001\nAnswer the following question about the project:\n",
        },
      }

      chat.setup(opts)
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
    end,
    keys = {
      {
        "gh",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions(), {
            prompt_title = "CopilotChat Prompts",
            attach_mappings = function(_, map)
              map("i", "<CR>", function(prompt_bufnr)
                local selection = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                if selection then
                  local picked = actions.prompt_actions().actions[selection.value]
                  if picked.callback then
                    local chat = require('CopilotChat')
                    chat.ask(picked.prompt, picked)
                  else
                    vim.cmd("CopilotChat")
                    local lines = vim.split(picked.prompt, "\n", { plain = true }) -- Split by newline
                    vim.api.nvim_put(lines, "", false, true)
                  end
                  -- Open CopilotChat window first
                end
              end)
              return true
            end,
          })
        end,
        mode = { "x", "n" },
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>av",
        ":CopilotChatVisual ",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>ccs",
        function()
          local input = vim.fn.input("Perplexity: ")
          if input ~= "" then
            require("CopilotChat").ask(input, {
              agent = "perplexityai",
              selection = false,
            })
          end
        end,
        desc = "CopilotChat - Perplexity Search",
        mode = { "n", "v" },
      },
    }
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",

    version = false,
    opts = {
      provider = "copilot",
      cursor_applying_provider = "copilot",
      auto_suggestion_provider = nil,
      copilot = {
        model = "claude-3.7-sonnet",
      },
      behaviour = {
        enable_cursor_planning_mode = true,
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_apply_diff_after_generation = true,
      },
      windows = {
        ask = {
          start_insert = false,
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
    keys = {
      { "<F7>", function() require("avante").toggle() end, mode = { "n", "i" }, desc = "Toggle Avante" },
    },
  }
}
