using {{cookiecutter.slug}}
using Test

@testset "Basic" begin
  project_root = @projectroot()

  @test 1 + 2 == 3
end

include(joinpath(@__DIR__, "aqua.jl"))
