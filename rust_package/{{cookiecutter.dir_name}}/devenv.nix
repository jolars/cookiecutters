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

  languages.rust = {
    enable = true;
    toolchainFile = ./rust-toolchain.toml;
  };

  git-hooks.hooks = {
    clippy = {
      enable = true;
      settings.allFeatures = true;
    };

    rustfmt.enable = true;

    panache-format = {
      enable = true;
      entry = "panache format";
      files = "\\.(md|qmd|Rmd)$";
      language = "system";
    };
  };
}
