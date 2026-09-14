{
  config,
  pkgs,
  ...
}:

{
  languages.r = {
    enable = true;
    package = pkgs.rWrapper.override {
      packages = with pkgs.rPackages; [
        devtools
        Rcpp
        renv
        roxygen2
        testthat
      ];
    };
  };

  languages.cplusplus.enable = true;

  tasks = {
    "project:all" = {
      description = "Install the research package";
      after = [ "project:install" ];
    };

    "project:clean" = {
      description = "Remove compiled package files";
      cwd = config.devenv.root;
      exec = ''
        rm -f "{{cookiecutter.package_name}}"/src/*.o "{{cookiecutter.package_name}}"/src/*.so
      '';
    };

    "project:document" = {
      description = "Generate package documentation";
      after = [ "project:compile-attributes" ];
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::document("{{cookiecutter.package_name}}", roclets = c("rd", "collate", "namespace"))'
      '';
    };

    "project:compile-attributes" = {
      description = "Generate Rcpp bindings";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'Rcpp::compileAttributes("{{cookiecutter.package_name}}")'
      '';
    };

    "project:build" = {
      description = "Build a source package without the manual";
      after = [ "project:document" ];
      cwd = config.devenv.root;
      exec = ''
        R CMD build --no-manual "{{cookiecutter.package_name}}"
      '';
    };

    "project:build-cran" = {
      description = "Build a source package for CRAN";
      after = [ "project:compile-attributes" ];
      cwd = config.devenv.root;
      exec = ''
        R CMD build "{{cookiecutter.package_name}}"
      '';
    };

    "project:install" = {
      description = "Install the research package";
      after = [ "project:compile-attributes" ];
      cwd = config.devenv.root;
      exec = ''
        R CMD INSTALL --no-multiarch --with-keep.source "{{cookiecutter.package_name}}"
      '';
    };

    "project:clean-install" = {
      description = "Rebuild and install the research package";
      after = [ "project:compile-attributes" ];
      cwd = config.devenv.root;
      exec = ''
        R CMD INSTALL --preclean --no-multiarch --with-keep.source "{{cookiecutter.package_name}}"
      '';
    };

    "project:check" = {
      description = "Run R CMD check";
      after = [ "project:compile-attributes" ];
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::check("{{cookiecutter.package_name}}")'
      '';
    };

    "project:test" = {
      description = "Run package tests";
      after = [ "project:compile-attributes" ];
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::test("{{cookiecutter.package_name}}")'
      '';
    };

    "project:vignettes" = {
      description = "Build package vignettes";
      cwd = config.devenv.root;
      exec = ''
        Rscript -e 'devtools::build_vignettes("{{cookiecutter.package_name}}")'
      '';
    };
  };
}
