{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.go-task
    pkgs.panache
    pkgs.ruff
    pkgs.taplo
  ];

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
    venv.enable = true;
  };

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
}
