# SPDX-License-Identifier: MIT

# author: Jook Walraven - 14-2-2023

# ==============================================================================
#                               CoulombIntegrals.jl
# ==============================================================================

# ------------------------------------------------------------------------------
#           a_direct(k::Int, l::Int, ml::Int, l′::Int, ml′::Int)
# ------------------------------------------------------------------------------

@doc raw"""
    a_direct(k::Int, l::Int, ml::Int, l′::Int, ml′::Int)

Coulomb angular integral - direct part:

```math
a^{k}(lm_{l};l^{\prime}m_{l^{\prime}})=(-)^{m_{l}+m_{l^{\prime}}}
(2l+1)(2l^{\prime}+1)\left(\begin{array}{ccc}
l & k & l\\
0 & 0 & 0
\end{array}\right)\left(\begin{array}{ccc}
l & k & l\\
-m_{l} & 0 & m_{l}
\end{array}\right)\left(\begin{array}{ccc}
l^{\prime} & k & l^{\prime}\\
0 & 0 & 0
\end{array}\right)\left(\begin{array}{ccc}
l^{\prime} & k & l^{\prime}\\
-m_{l^{\prime}} & 0 & m_{l^{\prime}}
\end{array}\right)
```
#### Example:
```
a_direct(2,1,1,2,2)
    2//35

a_direct(6,3,2,3,-1)
    -250//20449
```
"""
function a_direct(k::Int, l::Int, ml::Int, l′::Int, ml′::Int)

    Base.iseven(k) || return 0
    0 ≤ k ≤ 2min(l, l′) || return 0
    k > 0 || return 1

    Δ1 = CamiMath.triangle_coefficient(l, k, l)
    Δ2 = CamiMath.triangle_coefficient(l′, k, l′)
    T = CamiMath._Racah_sqrt2(l, 0, k, 0, l, 0) * CamiMath._Racah_sqrt2(l, -ml, k, 0, l, ml) * CamiMath._Racah_sqrt2(l′, 0, k, 0, l′, 0) * CamiMath._Racah_sqrt2(l′, -ml′, k, 0, l′, ml′)
    S = CamiMath._Racah_sum(l, 0, k, 0, l) * CamiMath._Racah_sum(l, -ml, k, 0, l) * CamiMath._Racah_sum(l′, 0, k, 0, l′) * CamiMath._Racah_sum(l′, -ml′, k, 0, l′)

    a = (2l + 1) * (2l′ + 1) * Δ1 * Δ2 * S
    o = a * a * T
    num = Int(sqrt(numerator(o)))
    den = Int(sqrt(denominator(o)))

    o = sign(S) * num // den

    return o

end

# ------------------------------------------------------------------------------
#           b_exchange(k::Int, l::Int, ml::Int, l′::Int, ml′::Int)
# ------------------------------------------------------------------------------

@doc raw"""
    b_exchange(k::Int, l::Int, ml::Int, l′::Int, ml′::Int)

Coulomb angular integral - exchange part:

```math
b^{k}(lm_{l};l^{\prime}m_{l^{\prime}})=(2l+1)(2l^{\prime}+1)
\left(\begin{array}{ccc}
l & k & l^{\prime}\\
0 & 0 & 0
\end{array}\right)^{2}\left(\begin{array}{ccc}
l & k & l^{\prime}\\
-m_{l} & (m_{l}-m_{l^{\prime}}) & m_{l^{\prime}}
\end{array}\right)^{2}
```
#### Example:
```
b_exchange(1,1,1,2,2)
    2//5

b_exchange(6,3,2,3,-1)
    1050//20449
```
"""
function b_exchange(k::Int, l::Int, ml::Int, l′::Int, ml′::Int)

    Base.iseven(k+l+l′) || return 0
    abs(l-l′) ≤ k ≤ l+l′ || return 0

    Δ = CamiMath.triangle_coefficient(l, k, l′)
    T = CamiMath._Racah_sqrt2(l, 0, k, 0, l′, 0) * CamiMath._Racah_sqrt2(l, -ml, k, ml-ml′, l′, ml′)
    S = CamiMath._Racah_sum(l, 0, k, 0, l′) * CamiMath._Racah_sum(l, -ml, k, ml-ml′, l′)

    o = abs((2l+1) * (2l′+1) * Δ * Δ * S * S * T)
    num = Int(numerator(o))
    den = Int(denominator(o))

    o = num//den

    return o

end

# ======================== scrUG(k, Z, grid) ===================================

@doc raw"""
    UG(k::Int, P1::Vector{T}, P2::Vector{T}, grid::CamiDiff.Grid{V}) where {T<:Real, V<:Real}

Potential for *exchange* screening,

```math
U_{G}^{k}(\rho)
=\frac{1}{\rho^{k+1}}\int_{0}^{\rho}\varrho^{k}\tilde{R}_{nl}(\varrho)
\tilde{R}_{n^{\prime}l^{\prime}}(\varrho)\,
\varrho^{2}d\varrho+\rho^{k}\int_{\rho}^{\infty}
\frac{1}{\varrho^{k+1}}\tilde{R}_{nl}(\varrho)
\tilde{R}_{n^{\prime}l^{\prime}}(\varrho)\,\varrho^{2}d\varrho.
```
#### Example:
```
atom = castAtom(Z=2, A=4, Q=0; msg=true)
orbit1 = castOrbit(n=1, ℓ=0; msg=true)
orbit2 = castOrbit(n=2, ℓ=0; msg=true)
scr = nothing
grid = autoGrid(atom, [orbit1,orbit2], Float64; Nboost=1, msg=true)
def1 = castDef(grid, atom, orbit1, codata; scr)
E = initE(def1)
adams = castAdams(E, grid, def1)
E, def, adams, Z1 = adams_moulton_master(E, grid, def1, adams; Δν=Value(1,"kHz"), imax=50, msg=false);

def2 = castDef(grid, atom, orbit2, codata; scr)
E = initE(def2)
adams = castAdams(E, grid, def2)
E, def, adams, Z2 = adams_moulton_master(E, grid, def2, adams; Δν=Value(1,"kHz"), imax=50, msg=false);

P1 = real(Z1);
P2 = real(Z2);

UG0 = UG(0, P1, P2, grid);
plot_function(UG0, 1:grid.N, grid; title="He4(1s,2s):  exchange screening potential")
```
The plot is made using `CairomMakie`.
NB.: `plot_function` is not included in the `CamiXon` package.
![Image](./assets/He41s-UG0.png)
"""
function UG(k::Int, P1::Vector{T}, P2::Vector{T}, grid::CamiDiff.Grid{V}) where {T<:Real, V<:Real}

    N = grid.N
    r = grid.r

    UG_inner = [CamiDiff.grid_integration(r.^k .* P1 .* P2, grid, 1:n) for n=2:N]
    UG_outer = [CamiDiff.grid_integration((1.0 ./ r).^(k+1) .* P1 .* P2, grid, n:N) for n=2:N]

    o = (UG_inner .* r[2:N].^-(k+1)) .+ (UG_outer .* r[2:N].^k)

    p = CamiDiff.fdiff_interpolation(o, 0; k=4)

    prepend!(o,p)

    return o

end

# ======================== UF(k, Z, grid) ===================================
@doc raw"""
    UF(k::Int, P::Vector{T}, grid::CamiDiff.Grid{V}) where {T<:Real, V<:Real}

Potential for *directe* screening,

```math
U_{F}^{k}(\rho)
=\frac{1}{\rho^{k+1}}\int_{0}^{\rho}\varrho^{k}
\left[\tilde{R}_{nl}(\varrho)\right]^{2}
\varrho^{2}d\varrho+\rho^{k}\int_{\rho}^{\infty}
\frac{1}{\varrho^{k+1}}
\left[\tilde{R}_{nl}(\varrho)\right]^{2}\varrho^{2}d\varrho.
```
#### Example:
```
atom = castAtom(Z=2, A=4, Q=0; msg=true)
orbit = castOrbit(n=1, ℓ=0; msg=true)
scr = nothing
grid = autoGrid(atom, orbit, Float64; Nboost=1, msg=true)
def = castDef(grid, atom, orbit, codata; scr)
E = initE(def1)
adams = castAdams(E, grid, def)
E, def, adams, Z = adams_moulton_master(E, grid, def, adams; Δν=Value(1,"kHz"), imax=50, msg=false);

P1 = real(Z)
UF0P1 = UF(0, P1, grid);
plot_function(scrUF0P1, 1:grid.N, grid; title="He4(1s,1s):  direct screening potential")
```
The plot is made using `CairomMakie`.
NB.: `plot_function` is not included in the `CamiXon` package.
![Image](./assets/He41s-UF0.png)
"""
function UF(k::Int, P::Vector{T}, grid::CamiDiff.Grid{V}) where {T<:Real, V<:Real}

    return UG(k, P, P, grid)

end
