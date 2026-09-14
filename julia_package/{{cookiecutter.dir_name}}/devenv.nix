{
  config,
  pkgs,
  ...
}:

{
  packages = [
    pkgs.panache
    pkgs.quartoMinimal
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

  tasks = {
    "project:default" = {
      description = "Install dependencies";
      after = [ "project:install" ];
    };

    "project:install" = {
      description = "Instantiate package dependencies";
      cwd = config.devenv.root;
      exec = ''
        julia --project=. -e 'using Pkg; Pkg.instantiate()'
      '';
    };

    "project:test" = {
      description = "Run package tests";
      cwd = config.devenv.root;
      exec = ''
        julia --project=. -e 'using Pkg; Pkg.test()'
      '';
    };

    "project:docs" = {
      description = "Build documentation";
      cwd = config.devenv.root;
      exec = ''
        julia --project=docs/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
        julia --project=docs/ docs/make.jl
      '';
    };

    "project:readme" = {
      description = "Generate README from a Quarto document";
      cwd = config.devenv.root;
      exec = ''
        julia --project=readme/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
        quarto render readme/README.qmd --output README.md
        mv readme/README_files README_files
      '';
    };
  };

  git-hooks.hooks.panache-format = {
    enable = true;
    entry = "panache format";
    files = "\\.(md|qmd|Rmd)$";
    language = "system";
  };
}
