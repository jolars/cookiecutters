{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.bashInteractive
    pkgs.go-task
    pkgs.air
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
  };
}
