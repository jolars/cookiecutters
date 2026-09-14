{
  config,
  pkgs,
  ...
}:

{
  packages = [
    pkgs.bashInteractive
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

  tasks = {
    "project:default" = {
      description = "Install the package";
      after = [ "project:install" ];
    };

    "project:clean" = {
      description = "Remove compiled files";
      cwd = config.devenv.root;
      exec = ''
        rm -f src/*.o src/*.so
      '';
    };

    "project:docs" = {
      description = "Generate package documentation";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::document(roclets = c("rd", "collate", "namespace"))'
      '';
    };

    "project:build" = {
      description = "Build a source package without manuals or vignettes";
      after = [ "project:docs" ];
      cwd = config.devenv.root;
      exec = ''
        package_dir="$PWD"
        cd ..
        R CMD build "$package_dir" --no-manual --no-build-vignettes
      '';
    };

    "project:build-cran" = {
      description = "Build a source package for CRAN";
      cwd = config.devenv.root;
      exec = ''
        package_dir="$PWD"
        cd ..
        R CMD build "$package_dir"
      '';
    };

    "project:install" = {
      description = "Install the package";
      cwd = config.devenv.root;
      exec = ''
        R CMD INSTALL . --no-multiarch --with-keep.source
      '';
    };

    "project:clean-install" = {
      description = "Rebuild and install the package";
      cwd = config.devenv.root;
      exec = ''
        R CMD INSTALL --preclean --no-multiarch --with-keep.source .
      '';
    };

    "project:check" = {
      description = "Run R CMD check";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::check()'
      '';
    };

    "project:test" = {
      description = "Run package tests";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::test()'
      '';
    };

    "project:format" = {
      description = "Format source and documentation";
      cwd = config.devenv.root;
      exec = ''
        air format .
        panache format .
      '';
    };

    "project:format-check" = {
      description = "Check source and documentation formatting";
      cwd = config.devenv.root;
      exec = ''
        air format --check .
        panache format --check .
      '';
    };

    "project:lint" = {
      description = "Lint source and documentation";
      cwd = config.devenv.root;
      exec = ''
        air format --check .
        panache lint .
      '';
    };

    "project:verify" = {
      description = "Run all required checks";
      after = [
        "project:check"
        "project:format-check"
        "project:lint"
      ];
    };

    "project:readme" = {
      description = "Build the README";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::build_readme()'
      '';
    };

    "project:vignettes" = {
      description = "Build package vignettes";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::build_vignettes()'
      '';
    };
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
