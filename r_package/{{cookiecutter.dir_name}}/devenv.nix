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

  # https://devenv.sh/languages/
  languages.r = {
    enable = true;
    package = (
      pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          devtools
          roxygen2
          spelling
          testthat
        ];
      }
    );
  };

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    air = {
      enable = true;
      entry = "air format --check";
      files = "\\.(r|R)$";
      language = "system";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
