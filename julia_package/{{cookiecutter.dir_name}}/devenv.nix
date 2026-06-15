{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.git
    pkgs.cmake
    pkgs.go-task
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
}
