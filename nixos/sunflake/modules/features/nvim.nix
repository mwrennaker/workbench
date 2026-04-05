{ inputs, self, ... }:
{
  flake.homeModules.nvim =
    { pkgs, config, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        viAlias = true;
        extraPackages = with pkgs; [
          git
          # LSPs
          nil # nix lsp
          rust-analyzer # rust lsp
          clang-tools # c lsp
          pyright # python lsp

          python3 # python interpreter

          # formatters
          nixfmt
          rustfmt # rust
          clang-tools # c
          python3Packages.pylint # python linter
          python3Packages.black # python formatter
          python3Packages.isort # python import organizer

          gcc # for treesitter at runtime
        ];
        plugins = with pkgs.vimPlugins; [
          # Treesitter
          {
            plugin = nvim-treesitter.withAllGrammars;
          }

          # LSP
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = ''
              vim.lsp.config("nil_ls", {})
              vim.lsp.config("rust_analyzer", {
                settings = {
                  ["rust-analyzer"] = {
                    checkOnSave = true,
                    check = { command = "clippy" },
                    diagnostics = { enable = true },
                  },
                },
              })
              vim.lsp.config("clangd", {})
              vim.lsp.config("pyright", {})

              vim.lsp.enable("nil_ls")
              vim.lsp.enable("rust_analyzer")
              vim.lsp.enable("clangd")
              vim.lsp.enable("pyright")
            '';
          }

          # Completion
          {
            plugin = nvim-cmp;
            type = "lua";
            config = ''
              local cmp = require("cmp")
              cmp.setup({
                snippet = {
                  expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                  end,
                },
                mapping = cmp.mapping.preset.insert({
                  ["<C-Space>"] = cmp.mapping.complete(),
                  ["<C-e>"]     = cmp.mapping.abort(),
                  ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                  ["<Tab>"]     = cmp.mapping.select_next_item(),
                  ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                  { name = "path" },
                }, {
                  { name = "buffer" },
                }),
              })
            '';
          }
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          luasnip
          cmp_luasnip

          # Autopairs
          {
            plugin = nvim-autopairs;
            type = "lua";
            config = ''
              require("nvim-autopairs").setup({
                check_ts = true,  -- use treesitter to check pairs
              })
              -- hook into cmp so confirmed completions also close pairs
              local cmp_autopairs = require("nvim-autopairs.completion.cmp")
              local cmp = require("cmp")
              cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            '';
          }

          # Formatter
          {
            plugin = conform-nvim;
            type = "lua";
            config = ''
              require("conform").setup({
                formatters_by_ft = {
                  nix  = { "nixfmt" },
                  rust = { "rustfmt" },
                  c    = { "clang_format" },
                  python = { "black", "isort" },
                },
                format_on_save = {
                  timeout_ms = 500,
                  lsp_fallback = true,
                },
              })
            '';
          }

          # File tree
          {
            plugin = neo-tree-nvim;
            type = "lua";
            config = ''
              require("neo-tree").setup({
                close_if_last_window = true,
                window = { width = 30 },
                filesystem = {
                  follow_current_file = { enabled = true },
                  hijack_netrw_behavior = "open_current",
                },
              })
            '';
          }
          plenary-nvim
          nvim-web-devicons
          nui-nvim

          # Statusbar
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              require("lualine").setup({
                options = {
                  theme = "auto",   -- picks up stylix/whatever terminal theme
                  globalstatus = true,
                  component_separators = { left = "", right = "" },
                  section_separators   = { left = "", right = "" },
                },
                sections = {
                  lualine_a = { "mode" },
                  lualine_b = { "branch", "diff", "diagnostics" },
                  lualine_c = { { "filename", path = 1 } },  -- relative path
                  lualine_x = { "filetype" },
                  lualine_y = { "progress" },
                  lualine_z = { "location" },
                },
              })
            '';
          }
          {
            plugin = oxocarbon-nvim;
            type = "lua";
            config = ''
              vim.opt.background = "dark"
              vim.cmd.colorscheme "oxocarbon"
              vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
              vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
              vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            '';
          }
        ];

        initLua = ''
          -- leader
          vim.g.mapleader      = " "
          vim.g.maplocalleader = " "

          -- appearance
          vim.opt.termguicolors  = true
          vim.opt.number         = true
          vim.opt.relativenumber = true
          vim.opt.wrap           = false
          vim.opt.showmode       = false  -- lualine shows mode already
          vim.opt.list           = true
          vim.opt.listchars      = {
            trail         = "·",
            tab           = "→·",
            nbsp          = "␣",
            extends       = "›",
            precedes      = "‹",
          }

          -- indentation
          vim.opt.tabstop     = 2
          vim.opt.shiftwidth  = 2
          vim.opt.expandtab   = true
          vim.opt.smarttab    = true

          -- search
          vim.opt.incsearch  = true
          vim.opt.hlsearch   = true
          vim.opt.ignorecase = true
          vim.opt.smartcase  = true  -- case sensitive if you use a capital

          -- undo
          vim.opt.undofile   = true
          vim.opt.undodir    = vim.fn.expand("~/.nvim/backup")
          vim.opt.undoreload = 10000

          -- misc
          vim.opt.mouse    = "a"
          vim.opt.backup   = false
          vim.opt.history  = 1000

          -- split navigation
          vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
          vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
          vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
          vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

          -- neo-tree
          vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

          -- buffer navigation
          vim.keymap.set("n", "<leader>h", ":bp<CR>", { noremap = true, silent = true })
          vim.keymap.set("n", "<leader>l", ":bn<CR>", { noremap = true, silent = true })

          -- clear search highlight
          vim.keymap.set("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true })

          -- LSP keybinds on attach
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local opts = { buffer = args.buf, noremap = true, silent = true }
              vim.keymap.set("n", "gd",         vim.lsp.buf.definition,    opts)
              vim.keymap.set("n", "K",          vim.lsp.buf.hover,         opts)
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,        opts)
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,   opts)
              vim.keymap.set("n", "<leader>x",  vim.diagnostic.setloclist, opts)
              vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,  opts)
              vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,  opts)
            end
          })

          -- diagnostics display
          vim.diagnostic.config({
            virtual_text    = true,
            signs           = true,
            underline       = true,
            update_in_insert = false,
            severity_sort   = true,
          })
        '';
      };
    };
}
