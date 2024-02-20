using Documenter
using {{cookiecutter.slug}}

# Copy CHANGELOG.md to docs/src/CHANGELOG.md
cp(
  joinpath(@__DIR__, "../CHANGELOG.md"),
  joinpath(@__DIR__, "src/CHANGELOG.md");
  force=true
)

makedocs(
  sitename="{{cookiecutter.slug}}",
  format=Documenter.HTML(
    assets=["assets/favicon.ico"],
  ),
  modules=[{{cookiecutter.slug}}],
  pages=[
    "Home" => "index.md",
    "API Reference" => "api.md",
    "Changelog" => "CHANGELOG.md",
  ]
)

deploydocs(
  repo="https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.slug}}.jl.git"
)

