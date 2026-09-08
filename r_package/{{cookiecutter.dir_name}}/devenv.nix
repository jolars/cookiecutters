{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.bashInteractive
    pkgs.go-task
    pkgs.air-formatter
    pkgs.panache
    pkgs.quartoMinimal
  ];

  languages.r = {
    enable = true;
    package = (
      pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          covr
          devtools
          roxygen2
          spelling
          testthat
        ];
      }
    );
  };

  git-hooks.hooks = {
    air = {
      enable = true;
      entry = "air format --check";
      files = "\\.(r|R)$";
      language = "system";
    };

    panache-format = {
      enable = true;
      entry = "panache format";
      files = "\\.(md|qmd|Rmd)$";
      language = "system";
    };
  };
}
