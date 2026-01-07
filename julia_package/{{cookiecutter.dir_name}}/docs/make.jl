using Documenter
using {{cookiecutter.project_slug}}

# Copy CHANGELOG.md to docs/src/CHANGELOG.md
cp(
  joinpath(@__DIR__, "../CHANGELOG.md"),
  joinpath(@__DIR__, "src/CHANGELOG.md");
  force=true
)

makedocs(
  sitename="{{cookiecutter.project_name}}",
  format=Documenter.HTML(
    assets=["assets/favicon.ico"],
  ),
  modules=[{{cookiecutter.project_slug}}],
  pages=[
    "Home" => "index.md",
    "API Reference" => "api.md",
    "Changelog" => "CHANGELOG.md",
  ]
)

deploydocs(
  repo="https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}.git"
)

