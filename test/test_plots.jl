using Plots
# plotly()

@testset "plot with no errors" begin
    res0 = [get_interval(
        [3., 2., 2.1],
        i,
        f_3p_1im_dep,
        :LIN_EXTRAPOL;
        local_alg = :LN_NELDERMEAD,
        theta_bounds = [(-12., 12.), (-12., 12.), (-12., 12.)],
        loss_tol = 1e-3,
        loss_crit = 9.,
        silent = true
    ) for i in 1:3]
    update_profile_points!(res0[1]; max_recursions=1)
    a_grid_1 = CICOCore.get_grid(res0[1])
    @test length(a_grid_1[2]) > 0
    p = plot(res0[1])
    @test p isa Plots.Plot
end
