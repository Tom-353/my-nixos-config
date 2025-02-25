{
  config.vim = {
    viAlias = true;
    vimAlias = true;
    luaConfigRC.myconfig = /* lua */ ''
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
      vim.opt.undodir = { prefix .. "/nvim/.undo//"}
      vim.opt.backupdir = {prefix .. "/nvim/.backup//"}
      vim.opt.directory = { prefix .. "/nvim/.swp//"}
    '';
    spellcheck = {
      enable = true;
      languages = ["en" "cs"];
      #programmingWordlist.enable = true;
    };
    lsp = {
      lspkind.enable = false;
      lspsaga.enable = false;
      trouble.enable = true;
      lspSignature.enable = true;
      nvim-docs-view.enable = true;
    };
    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;
    telescope.enable = true;
    treesitter.context.enable = true;
    tabline = {
      nvimBufferline.enable = true;
    };
    statusline.lualine.enable = true;
    snippets.luasnip.enable = true;
    languages = {
      #enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      enableDAP = true;
      nix = {
        enable = true;
      };
      python = {
        enable = true;
        dap.enable = true;
      };
      clang.enable = true;
      css.enable = true;
      markdown.enable = true;
      bash.enable = true;
    };
    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };
    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };
    visuals = {
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;
      highlight-undo.enable = true;
      indent-blankline.enable = true;
    };
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };
    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };
    minimap.codewindow.enable = true;
    notes.todo-comments.enable = true;
    utility = {
      icon-picker.enable = true;
    };
    notify.nvim-notify.enable = true;
    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true;
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          go = ["90" "130"];
        };
      };
      fastaction.enable = true;
    };
  };
}
