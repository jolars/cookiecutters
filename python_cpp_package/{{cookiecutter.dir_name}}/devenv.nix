{
  pkgs,
  ...
}:

{
  # https://devenv.sh/packages/
  packages = [
    pkgs.bashInteractive
    pkgs.cmake
    pkgs.clang-tools
    pkgs.go-task
    pkgs.ninja
    pkgs.panache
    pkgs.ruff
    pkgs.taplo
  ];

  # https://devenv.sh/languages/
  languages.python = {
    enable = true;

    uv = {
      enable = true;

      sync = {
        enable = true;
        allExtras = true;
        allGroups = true;
      };
    };

    venv = {
      enable = true;
    };
  };

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    ruff.enable = true;
    ruff-format.enable = true;
    panache-format = {
      enable = true;
      entry = "panache format";
      files = "\\.(md|qmd|Rmd)$";
      language = "system";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
