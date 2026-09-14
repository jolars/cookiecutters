{
  config,
  pkgs,
  ...
}:

{
  # https://devenv.sh/packages/
  packages = [
    pkgs.bashInteractive
    pkgs.cmake
    pkgs.clang-tools
    pkgs.ninja
    pkgs.panache
    pkgs.ruff
    pkgs.taplo
  ];

  # https://devenv.sh/languages/
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

    venv = {
      enable = true;
    };
  };

  tasks = {
    "project:default" = {
      description = "Install the package in development mode";
      after = [ "project:install" ];
    };

    "project:install" = {
      description = "Install the package in development mode";
      after = [ "devenv:python:uv" ];
      cwd = config.devenv.root;
      exec = ''
        uv pip install -e . --group dev
      '';
    };

    "project:build" = {
      description = "Build distribution packages";
      cwd = config.devenv.root;
      exec = ''
        rm -rf dist
        uv build
      '';
    };

    "project:test-pypi" = {
      description = "Upload the source distribution to TestPyPI using UV_PUBLISH_TOKEN";
      cwd = config.devenv.root;
      exec = ''
        uv publish --publish-url https://test.pypi.org/legacy/ dist/*.tar.gz
      '';
    };

    "project:clean" = {
      description = "Remove compiled files";
      cwd = config.devenv.root;
      exec = ''
        rm -f src/*.o src/*.so
      '';
    };

    "project:test" = {
      description = "Run all tests";
      after = [ "project:doctest" ];
      cwd = config.devenv.root;
      exec = ''
        pytest
      '';
    };

    "project:format-check" = {
      description = "Check source and documentation formatting";
      cwd = config.devenv.root;
      exec = ''
        ruff format --check .
        clang-format --dry-run --Werror src/*.cpp
        panache format --check .
      '';
    };

    "project:lint" = {
      description = "Lint source and documentation";
      cwd = config.devenv.root;
      exec = ''
        ruff check .
        panache lint .
      '';
    };

    "project:check" = {
      description = "Run all required checks";
      after = [
        "project:format-check"
        "project:lint"
        "project:test"
      ];
    };

    "project:docs" = {
      description = "Build documentation";
      after = [ "devenv:python:uv" ];
      cwd = config.devenv.root;
      exec = ''
        sphinx-build -M html docs/source docs/build
      '';
    };

    "project:doctest" = {
      description = "Run documentation tests";
      after = [ "devenv:python:uv" ];
      cwd = config.devenv.root;
      exec = ''
        sphinx-build -M doctest docs/source docs/build
      '';
    };
  };

  processes.docs = {
    cwd = config.devenv.root;
    exec = "sphinx-autobuild docs/source docs/build/html --watch {{cookiecutter.project_slug}}";
  };

  # https://devenv.sh/git-hooks/
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

  # See full reference at https://devenv.sh/reference/options/
}
