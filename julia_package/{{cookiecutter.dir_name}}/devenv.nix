{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.go-task
    pkgs.panache
    pkgs.taplo
  ];

  languages = {
    julia = {
      enable = true;

      package = (
        pkgs.julia-bin.withPackages [
          "Aqua"
          "Test"
          "Documenter"
        ]
      );
    };
  };

  git-hooks.hooks.panache-format = {
    enable = true;
    entry = "panache format";
    files = "\\.(md|qmd|Rmd)$";
    language = "system";
  };
}
