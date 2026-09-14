{
  config,
  pkgs,
  ...
}:

{
  packages = [
    pkgs.panache
    pkgs.ruff
    pkgs.taplo
  ];

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
    venv.enable = true;
  };

  tasks = {
    "project:format" = {
      description = "Format source and documentation";
      cwd = config.devenv.root;
      exec = ''
        ruff format .
        panache format .
      '';
    };

    "project:format-check" = {
      description = "Check source and documentation formatting";
      cwd = config.devenv.root;
      exec = ''
        ruff format --check .
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

    "project:test" = {
      description = "Run tests";
      after = [ "devenv:python:uv" ];
      cwd = config.devenv.root;
      exec = ''
        pytest
      '';
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

  processes.docs = {
    cwd = config.devenv.root;
    exec = "sphinx-autobuild docs/source docs/build/html --watch {{cookiecutter.project_slug}}";
  };

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
}
