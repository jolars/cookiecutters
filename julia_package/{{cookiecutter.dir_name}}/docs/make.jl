using Documenter
using {{cookiecutter.project_name}}

# Copy CHANGELOG.md to docs/src/CHANGELOG.md
cp(
  joinpath(@__DIR__, "../CHANGELOG.md"),
  joinpath(@__DIR__, "src/CHANGELOG.md");
  force=true
)

documenter_options = haskey(ENV, "GITHUB_ACTIONS") ? (;) : (; remotes=nothing)

makedocs(;
  sitename="{{cookiecutter.project_name}}",
  format=Documenter.HTML(
    assets=["assets/favicon.ico"],
    edit_link="main",
    repolink="https://github.com/{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}",
  ),
  modules=[{{cookiecutter.project_name}}],
  pages=[
    "Home" => "index.md",
    "API Reference" => "api.md",
    "Changelog" => "CHANGELOG.md",
  ],
  documenter_options...
)

deploydocs(
  devbranch="main",
  repo="github.com/{{cookiecutter.github_user}}/{{cookiecutter.github_repo}}.git"
)
