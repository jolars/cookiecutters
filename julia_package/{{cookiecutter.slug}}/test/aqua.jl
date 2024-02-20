using Aqua

@testset "Aqua.jl" begin
  Aqua.test_all({{cookiecutter.slug}})
end
