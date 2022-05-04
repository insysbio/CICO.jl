#=
get_endpoint(
        [3., 2., 2.1],
        1,
        (x::Vector{Float64}) -> begin sleep(0.01); f_3p_1im_dep(x) end,
        method;
        loss_crit = 9.,
        silent = false
    )
=#

@testset "default options" begin
    method = :CICO_ONE_PASS
    res0 = [get_endpoint(
        [3., 2., 2.1],
        i,
        (x::Vector{Float64}) -> f_3p_1im_dep(x),
        method;
        loss_crit = 9.,
        silent = true
    ) for i in 1:3]

    @test isapprox(res0[1].value, 5.0, atol=1e-2)
    @test length(res0[1].profilePoints) > 0
    @test res0[1].status == :BORDER_FOUND_BY_SCAN_TOL
    @test res0[1].direction == :right
    @test isapprox(res0[2].value, 2.0+2.0*sqrt(2.), atol=1e-2)
    @test length(res0[2].profilePoints) > 0
    @test res0[2].status == :BORDER_FOUND_BY_SCAN_TOL
    @test res0[2].direction == :right
    @test length(res0[3].profilePoints) == 0
    @test res0[3].status == :SCAN_BOUND_REACHED
    @test res0[3].direction == :right
end

@testset ":left" begin
    method = :CICO_ONE_PASS
    res0 = [get_endpoint(
        [3., 2., 2.1],
        i,
        (x::Vector{Float64}) -> f_3p_1im_dep(x),
        method,
        :left;
        loss_crit = 9.,
        silent = true
    ) for i in 1:3]

    @test isapprox(res0[1].value, 1.0, atol=1e-2)
    @test length(res0[1].profilePoints) > 0
    @test res0[1].status == :BORDER_FOUND_BY_SCAN_TOL
    @test res0[1].direction == :left
    @test isapprox(res0[2].value, 2.0-2.0*sqrt(2.), atol=1e-2)
    @test length(res0[2].profilePoints) > 0
    @test res0[2].status == :BORDER_FOUND_BY_SCAN_TOL
    @test res0[2].direction == :left
    @test length(res0[3].profilePoints) == 0
    @test res0[3].status == :SCAN_BOUND_REACHED
    @test res0[3].direction == :left
end

@testset ":log" begin
    method = :CICO_ONE_PASS
    res0 = [get_endpoint(
        [3., 2., 2.1],
        i,
        (x::Vector{Float64}) -> f_3p_1im_dep(x),
        method,
        :right;
        loss_crit = 9.,
        scale = [:log, :direct, :log],
        silent = true
    ) for i in 1:3]

    @test isapprox(log10(res0[1].value), log10(5.), atol=1e-2)
    @test length(res0[1].profilePoints) > 0
    @test res0[1].status == :BORDER_FOUND_BY_SCAN_TOL
    @test res0[1].direction == :right
    @test isapprox(res0[2].value, 2.0+2.0*sqrt(2.), atol=1e-2)
    @test length(res0[2].profilePoints) > 0
    @test res0[2].status == :BORDER_FOUND_BY_SCAN_TOL
    @test res0[2].direction == :right
    @test length(res0[3].profilePoints) == 0
    @test res0[3].status == :SCAN_BOUND_REACHED
    @test res0[3].direction == :right
end
