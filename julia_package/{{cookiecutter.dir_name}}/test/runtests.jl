using {{cookiecutter.project_name}}
using Test

@testset "Basic" begin
  @test 1 + 2 == 3
end

include(joinpath(@__DIR__, "aqua.jl"))
