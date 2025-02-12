# Visualization

[`CICOBase.get_interval`](@ref) function returns estimated
confidence interval along with other data as
[`CICOBase.ParamInterval`](@ref) structure.

**CICOBase** provides a `@recipe` for **Plots.jl** to visualize
confidence interval estimation and plot parameter's profile based on
[`CICOBase.ParamInterval`](@ref).

```
using CICOBase

# Likelihood function
f(x) = 5.0 + (x[1]-3.0)^2 + (x[1]-x[2]-1.0)^2 + 0*x[3]^2

# Calculate parameters intervals for x[1], x[2], x[3]
res = [
    get_interval(
        [3., 2., 2.1],
        i,
        f,
        :CICO_ONE_PASS;
        loss_crit = 9.
    ) for i in 1:3]

# Plot parameter profile x[2]
using Plots
plotly()
plot(res[2])
```

![](https://github.com/insysbio/CICOBase.jl/blob/master/img/plot_cico.png?raw=true)

To make a smooth plot one can compute more profile points with [`CICOBase.update_profile_points!`](@ref) which internally uses [`PlotUtils.adapted_grid`](https://github.com/JuliaPlots/PlotUtils.jl/blob/master/src/adapted_grid.jl)

```
update_profile_points!(res[2])

plot(res[2])
```

![](https://github.com/insysbio/CICOBase.jl/blob/master/img/plot_cico_smooth.png?raw=true)
