{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      SudoEdit-vim
      ale
      asyncomplete-lsp-vim
      asyncomplete-vim
      context_filetype-vim
      editorconfig-vim
      nerdtree
      tcomment_vim
      vim-airline
      vim-airline-clock
      vim-airline-themes
      vim-colorschemes
      vim-fugitive
      vim-indent-guides
      vim-lsp
      vim-lsp-settings
      vim-surround
      vim-vsnip
      vim-vsnip-integ
      vimagit
    ];
  };
}
