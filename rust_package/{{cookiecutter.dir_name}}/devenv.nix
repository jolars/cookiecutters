{
  config,
  pkgs,
  ...
}:

{
  packages = [
    pkgs.panache
    pkgs.taplo
  ];

  languages.rust = {
    enable = true;
    toolchainFile = ./rust-toolchain.toml;
  };

  tasks = {
    "project:format" = {
      description = "Format source and documentation";
      cwd = config.devenv.root;
      exec = ''
        cargo fmt --all
        panache format .
      '';
    };

    "project:format-check" = {
      description = "Check source and documentation formatting";
      cwd = config.devenv.root;
      exec = ''
        cargo fmt --all -- --check
        panache format --check .
      '';
    };

    "project:lint" = {
      description = "Lint source and documentation";
      cwd = config.devenv.root;
      exec = ''
        cargo clippy --all-targets --all-features -- -D warnings
        panache lint .
      '';
    };

    "project:test" = {
      description = "Run tests";
      cwd = config.devenv.root;
      exec = ''
        cargo test --all-features
      '';
    };

    "project:docs" = {
      description = "Build documentation";
      cwd = config.devenv.root;
      exec = ''
        RUSTDOCFLAGS="-D warnings" cargo doc --no-deps --all-features
      '';
    };

    "project:check" = {
      description = "Run all required checks";
      after = [
        "project:format-check"
        "project:lint"
        "project:test"
        "project:docs"
      ];
    };
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
