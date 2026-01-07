using Aqua

@testset "Aqua.jl" begin
  Aqua.test_all({{cookiecutter.project_slug}})
end
