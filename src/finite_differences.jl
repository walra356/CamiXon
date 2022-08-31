# ==================== fdiff_weight(k, j) ======================================
@doc raw"""
    fdiff_weight(k::Int, j::Int)

Finite difference weight coefficient,

```math
c_{j}^{k}=(-1)^{k+j}\binom{k}{j}.
```
#### Example:
```
c(k,j) = fdiff_weight(k,j)

[[c(k,j) for j=0:k] for k=0:3] == [[1], [1, -1], [1, -2, 1], [1, -3, 3, -1]]
  true

[[c(k,k-j) for j=0:k] for k=0:3] == [[1], [-1, 1], [1, -2, 1], [-1, 3, -3, 1]]
  true
```
"""
function fdiff_weight(k::Int, j::Int)

    return Base.iseven(j) ? Base.binomial(k,j) : -Base.binomial(k,j)

end

# ============== fdiff_expansion_weights(coeffs, bwd, rev) =====================

# ..............................................................................
function reg_fwd_expansion_weights(coeffs)

    k = Base.length(coeffs)-1

    o = [Base.sum([coeffs[p+1] * fdiff_weight(p, p-j) for p=j:k]) for j=0:k]

    return o

end
# ..............................................................................
function rev_fwd_expansion_weights(coeffs)

    k = Base.length(coeffs)-1

    o = [Base.sum([coeffs[p+1] * fdiff_weight(p, p-j) for p=j:k]) for j=k:-1:0]

    return o

end
# ..............................................................................
function reg_bwd_expansion_weights(coeffs)

    k = Base.length(coeffs)-1

    o = [sum([coeffs[p+1] * fdiff_weight(p, j) for p=j:k]) for j=0:k]

    return o

end
# ..............................................................................
function rev_bwd_expansion_weights(coeffs)

    k = Base.length(coeffs)-1

    o = [sum([coeffs[p+1] * fdiff_weight(p, j) for p=j:k]) for j=k:-1:0]

    return o

end
# ..............................................................................
@doc raw"""
    fdiff_expansion_weights(coeffs[, notation=bwd[, ordering=rev]])

Expansion weights corresponding to the expansion coefficients `coeffs` of
a finite difference expansion.

**Forward difference notation** (`notation = fwd`)

Weight vector ``F^k ≡ [F_k^k,⋯\ F_0^k]`` corresponding to the
expansion coefficients ``α ≡ [α_0^k,⋯\ α_k^k]`` of the ``k^{th}``-order
*forward-difference* expansion,

```math
\sum_{p=0}^{k}α_{p}Δ^{p}f[n]
=\sum_{j=0}^{k}F_{j}^{k}f[n+j]
=F^{k} \cdot f[n:n+k],
```

where ``f[n:n+k]`` are elements of the
analytic function ``f`` tabulated in *forward* order.

[`fdiff_expansion_weights(α, fwd, reg)`](@ref)
``→ F^k ≡ [F_0^k,⋯\ F_k^k]``,

where `` α ≡ [α_0,⋯\ α_k]`` has to be supplied in combination with `fwd` to
indicate that the weights must be evaluated in forward-difference notation.

**Backward difference notation** (`notation = bwd`)

Weight vector ``\bar{B}^{k} ≡ [B_k^k,⋯\ B_0^k]`` corresponding to the
expansion coefficients ``β ≡ [β_0,⋯\ β_k]`` of
the ``k^{th}``-order *backward-difference* expansion,

```math
\sum_{p=0}^{k}β_{p}∇^{p}f[n]
=\sum_{j=0}^{k}B_{j}^kf[n-j]
=\bar{B}^k \cdot f[n-k:n].
```

where ``f[n-k:n]`` are elements of the
analytic function ``f`` tabulated in *forward* order.

[`fdiff_expansion_weights(β, bwd, rev)`](@ref)
`` → \bar{B}^{k} ≡ [B_k^k,⋯\ B_0^k]``,

where `` β ≡ [β_0,⋯\ β_k]`` has to be supplied in combination with `bwd` to
indicate that the weights must be evaluated in backward-difference notation.
#### Example:

Consider the expansions,

```math
f[n-1]=(1+Δ)^{-1}f[n]=(1-Δ+Δ^2-Δ^3+⋯)f[n].
```
```math
f[n+1]=(1-∇)^{-1}f[n]=(1+∇+∇^2+∇^3+⋯)f[n],
```
```
α = [1,-1,1,-1,1]
β = [1,1,1,1,1]
Fk = fdiff_expansion_weights(α, fwd, reg); println("Fk = $(Fk)")
  Fk = [5, -10, 10, -5, 1]

Bk = fdiff_expansion_weights(β, bwd, reg); println("Bk = $(Bk)")
  Bk = [5, -10, 10, -5, 1]

revFk = fdiff_expansion_weights(α, fwd, rev); println("revFk = $(revFk)")
  revFk = [1, -5, 10, -10, 5]

revBk = fdiff_expansion_weights(β, bwd, rev); println("revBk = $(revBk)")
  revBk = [1, -5, 10, -10, 5]
```
"""
function fdiff_expansion_weights(coeffs, notation=bwd, ordering=rev)

    if isforward(notation)

        o = isregular(ordering) ? reg_fwd_expansion_weights(coeffs) :
                                  rev_fwd_expansion_weights(coeffs)
    else

        o = isregular(ordering) ? reg_bwd_expansion_weights(coeffs) :
                                  rev_bwd_expansion_weights(coeffs)
    end

    return o

end

# =========== fdiff_expansion(coeffs, f, notation=bwd) =========================

# ..............................................................................
@doc raw"""
    fdiff_expansion(coeffs, f[, notation=bwd])

Finite difference expansion of the analytical function f(x) tabulated
in *forward order* (growing index) at ``k+1`` positions on a uniform grid.
The expansion coefficients are specified by the vector `coeffs`. By default
`coeffs` are assumed to be in backward-difference notation (`bwd`). For `coeffs`
in forward-difference notation the third argument must be `fwd`.

**Forward difference notation** (`notation = fwd`)
```math
\sum_{p=0}^{k}α_{p}Δ^{p}f[n] = F^{k} \cdot f[n:n+k],
```
where ``f[n:n+k]`` are elements of the
analytical function ``f`` (tabulated in *forward* order) and
``α ≡ [α_0,⋯\ α_k]`` is the vector `coeffs`, which has to be supplied to
define the forward-difference expansion.
The corresponding weights vector ``F^{k}`` is internally generated.

**Backward difference notation** (`notation = bwd`)
```math
\sum_{p=0}^{k}β_{p}∇^{p}f[n] = \bar{B}^k \cdot f[n-k:n].
```
where ``f[n-k:n]`` are elements of the
analytical function ``f`` (tabulated in *forward* order) and
``β ≡ [β_0,⋯\ β_k]`` is the vector `coeffs`, which has to be supplied to
define the backward-difference expansion. The corresponding weights vector
``\bar{B}^k`` is internally generated.

#### Examples:
Consider the function ``f(x)=x^2`` and the expansions,
```math
f(x-1)=(1+Δ)^{-1}=(1-Δ+Δ^2-Δ^3+⋯)f(x).
```
```math
f(x+1)=(1-∇)^{-1}=(1+∇+∇^2+∇^3+⋯)f(x),
```
To fourth order `(k=4)` the forward- and backward-difference coefficient vectors
are `α=[1,-1,1,-1,1]` and `β=[1,1,1,1,1]`, respectively. We tabulate the function
at ``k+1`` points, `f=[1,4,9,16,25]`.
```
α = [1,-1,1,-1,1]
Fk = fdiff_expansion_weights(α, fwd, reg); println("Fk = $(Fk)")
  Fk = [5, -10, 10, -5, 1]

β = [1,1,1,1,1]
revBk = fdiff_expansion_weights(β, bwd, rev); println("revBk = $(revBk)")
  revBk = [1, -5, 10, -10, 5]

f = [1,4,9,16,25]
o = fdiff_expansion(α, f, fwd); println("f[0] = $(o)")
  f[0] = 0

o = Fk ⋅ f; println("Fk ⋅ f = $(o)")
  Fk ⋅ f = 0

o = fdiff_expansion(β, f, bwd); println("f[6] = $(o)")
  f[6] = 36

o = revBk ⋅ f; println("revBk ⋅ f = $(o)")
  revBk ⋅ f = 36
```
In these cases the results are exact because the function is quadratic and
the expansion is third order (based on the polynomial of ``k^{th}`` degree
running through the ``k+1`` points of the tabulated function).
"""
function fdiff_expansion(coeffs, f, notation=bwd)

    ordering = isforward(notation) ? reg : rev
    w = fdiff_expansion_weights(coeffs, notation, ordering)

    return w ⋅ f

end

# ======= fdiff_interpolation_expansion_coeffs(k, x, notation=bwd) =============

#...............................................................................
function fwd_interpolation_expansion_coeffs(Δν::T, k=3) where T<:Real

    o = Base.ones(T,k+1)
    x == 0 ? (for p=2:k+1; o[p] = 0 end) :
             (for p=1:k; o[p+1] = o[p]*(Δν-p+1)/p end)

    return o

end
#...............................................................................
function bwd_interpolation_expansion_coeffs(Δν::T, k=3) where T<:Real

    o = Base.ones(T,k+1)
    x == 0 ? (for p=2:k+1; o[p] = 0 end) :
             (for p=1:k; o[p+1] = o[p]*(p-Δν-1)/p end)

    return o

end
#...............................................................................
@doc raw"""
    fdiff_interpolation_expansion_coeffs(Δν::T [, k=3 [, notation=bwd]]) where T<:Real

Finite-difference expansion coefficient vector defining the ``k^{th}``-order
lagrangian interpolation any tabulated analytic function ``f[n]``
at offset ``Δν`` with respect to index position ``n``, which is positive for
increasing index and negative for decreasing index.

**Forward difference notation** (`notation = fwd`)

```math
f[n-σ] = (1 + Δ)^{-σ} f[n] = \sum_{p=0}^k α_p Δ^p f[n] + ⋯,
```
where ``(σ)_{p}`` is the [`pochhammer`](@ref) symbol.
Interpolation corresponds to the interval ``-k\le\ σ\le 0``;
extrapolation to ``σ\ge 0``.

[`fdiff_interpolation_expansion_coeffs(Δν, k, fwd)`](@ref)
→ ``α^k(σ) ≡ [α_0(σ),⋯\ α_k(σ)]``

Offset convention: ``Δν = -σ`` with respect to index ``n`` in tabulated
interval ``f[n:n+k]``

**Backward difference notation** (`notation = bwd`)

```math
f[n+σ] = (1 - ∇)^{-σ} f[n] = \sum_{p=0}^k β_p ∇^p f[n] + ⋯,
```

[`fdiff_interpolation_expansion_coeffs(Δν, k, bwd)`](@ref)
→ ``β^k(σ) ≡ [β_0(σ),⋯\ β_k(σ)]``

Offset convention: ``Δν = σ`` with respect to index ``n`` in tabulated
interval ``f[n-k:n]``

#### Examples:
```
k = 5
Δν = -1
α = fdiff_interpolation_expansion_coeffs(Δν, k, fwd); println("α = $α")
β = fdiff_interpolation_expansion_coeffs(Δν, k, bwd); println("β = $β")
  α = [1, 1, 0, 0, 0, 0]
  β = [1, 1, 1, 1, 1, 1]

Δν = 0
α = fdiff_interpolation_expansion_coeffs(Δν, k, fwd); println("α = $α")
β = fdiff_interpolation_expansion_coeffs(Δν, k, bwd); println("β = $β")
  α = [1, 0, 0, 0, 0, 0]
  β = [1, 0, 0, 0, 0, 0]

Δν = 1
α = fdiff_interpolation_expansion_coeffs(Δν, k, fwd); println("α = $α")
β = fdiff_interpolation_expansion_coeffs(Δν, k, bwd); println("β = $β")
  α = [1, -1, 1, -1, 1, -1]
  β = [1, -1, 0, 0, 0, 0]
```
"""
function fdiff_interpolation_expansion_coeffs(Δν::T, k=3, notation=bwd) where T<:Real

    o = isforward(notation) ? fwd_interpolation_expansion_coeffs(-Δν, k) :
                              bwd_interpolation_expansion_coeffs(Δν, k)
    return o

end

# ============== fdiff_interpolation_expansion_weights(coeffs) =================

#...............................................................................
function fwd_interpolation_expansion_weights(Δν::T, k=3, ordering=reg) where T<:Real

    α = fdiff_interpolation_expansion_coeffs(Δν, k, fwd)
    o = fdiff_expansion_weights(α, fwd, ordering)

    return o

end
#...............................................................................
function bwd_interpolation_expansion_weights(Δν::T, k=3, ordering=rev) where T<:Real

    β = fdiff_interpolation_expansion_coeffs(Δν, k, bwd)
    o = fdiff_expansion_weights(β, bwd, ordering)

    return o

end#...............................................................................

function fdiff_interpolation_expansion_weights(Δx::T, k=3, notation=bwd, ordering=rev) where T<:Real

    o = isforward(notation) ? fwd_interpolation_expansion_weights(-Δν, k, ordering) :
                              bwd_interpolation_expansion_weights(Δν, k, ordering)
    return o

end


function fdiff_interpolation_expansion_weights(coeffs, notation=bwd, ordering=rev)

    if isforward(notation)

        o = isregular(ordering) ? reg_fwd_expansion_weights(coeffs) :
                                  rev_fwd_expansion_weights(coeffs)
    else

        o = isregular(ordering) ? reg_bwd_expansion_weights(coeffs) :
                                  rev_bwd_expansion_weights(coeffs)
    end

    return o

end

# ======================== fdiff_interpolation(f, x; k=3) ======================
@doc raw"""
    fdiff_interpolation(f::Vector{T}, ν::V; k=3) where {T<:Real, V<:Real}

Finite difference lagrangian interpolation (by default *third* order) at real
position ν (in index units) with respect to the elements of the uniformly
tabulated analytic function `f[1:N]`. The interpolation points lie on a
Lagrange polynomial of degree ``k`` (by default *third* degree) running through
``k+1`` subsequenct points of the tabulated function. Outside the tabulated
range, the output is a continuation of the lagrangian polynomial defined by
the first/last ``k+1`` tabulated points.

Beware that the interpolation becomes inaccurate if the tabulated function
cannot be approximated by a polynomial of degree ``k``.
#### Examples:
```
f = [1,2,3,4,5,6,7]
[fdiff_interpolation(f, ν; k=3) for ν=1:0.5:7]
  [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0]

f = [1,4,9,16,25,36,49]
[fdiff_interpolation(f, ν; k=3) for ν=1:0.5:7]
 [1.0, 2.25, 4.0, 6.25, 9.0, 12.25, 16.0, 20.25, 25.0, 30.25, 36.0, 42.25, 49.0]

f = [ν^3 for ν=-5:2]     # see figure below
[fdiff_interpolation(f, ν; k=3) for ν=-4:0.5:4]
  [-64.0, -42.875, -27.0, -15.625, -8.0, -3.375, -1.0, -0.125, 0.0, 0.125, 1.0,
  3.375, 8.0, 15.625, 27.0, 42.875, 64.0]
```
In the latter case the result is exact because the function is cubic and
the expansion is third order - see Figure below.

![Image](./assets/lagrangian_interpolation.png)
"""
function fdiff_interpolation(f::Vector{T}, ν::V; k=3) where {T<:Real, V<:Real}

    l = length(f)
    k = min(k,l-1)
    k > 0 || error("Error: k ≥ 1 required for lagrangian interpolation")
    n = ν < 1 ? 1 : ν < l-k ? floor(Int,ν) : l-k
    α = fdiff_interpolation_expansion_coeffs(n-ν, k, fwd)
    o = fdiff_expansion(α, f[n:n+k], fwd)

    return o

end

# ======================== fdiff_lagrangian_next(f[; sense=fwd[, k=3]) ======================

#........................................................................................
function _forward_extrapolation(f::Vector{T}; k=3) where T<:Real

    l = length(f)
    k = min(k,l-1)
    k > 0 || error("Error: degree k ≥ 1 required for Lagrange polynomial")
    β = fdiff_interpolation_expansion_coeffs(-1, k, bwd)
    o = fdiff_expansion(β, f[l-k:l], bwd)

    return o

end
#........................................................................................
function _backward_extrapolation(f::Vector{T}; k=3) where T<:Real

    l = length(f)
    k = min(k,l-1)
    k > 0 || error("Error: degree k ≥ 1 required for Lagrange polynomial")
    α = fdiff_interpolation_expansion_coeffs(1, k, fwd)
    o = fdiff_expansion(α, f[1:k+1], fwd)

    return o

end
#........................................................................................
@doc raw"""
    fdiff_lagrangian_next(f::Vector{T}[; sense=fwd[, k=3]) where T<:Real

Finite difference lagrangian extrapolation of the analytic function `f`
(uniformly tabulated in *forward* order). The next value lies on a Lagrange
polynomial of degree ``k`` (by default *third* degree) running through the last
(sense=fwd) or first (sense= bwd) ``k+1`` tabulated points.

Beware that Lagrange extrapolation becomes inaccurate if the tabulated function
cannot be approximated by a polynomial of degree ``k``.
#### Examples:
```
f = [1,4,9,16,25,36,49]; println("f = $f")
o = fdiff_lagrangian_next(f; sense=fwd, k=2); println("next_fwd = $o")
o = fdiff_lagrangian_next(f; sense=bwd, k=2); println("next_bwd = $o")
  f = [1, 4, 9, 16, 25, 36, 49]
  next_fwd = 64
  next_bwd = 0
```
In this example the result is exact because both the function and
the expansion are quadratic - see Figure below.

![Image](./assets/Lagrange_polynomial_extrapolation.png)
"""
function fdiff_lagrangian_next(f::Vector{T}; sense=fwd, k=3) where T<:Real

    o = isforward(sense) ? _forward_extrapolation(f; k) :
                          _backward_extrapolation(f; k)

    return o

end

# ============== fdiff_expansion_coeffs_differentiation(k, x) =================

@doc raw"""
    fdiff_expansion_coeffs_differentiation(Δν::T [, k=3]) where T<:Real

Finite-difference expansion coefficient vector ``β ≡ [β_0(Δν),\ ⋯,\ β_p(Δν)]``
defining ``k^{th}``-order lagrangian *differentiation* of the tabulated
analytic function ``f[n]`` at offset ``Δν`` (with respect to index
position ``n``), which is positive for increasing index and negative for
decreasing index.

```math
\frac{df}{dx}[n+Δν]=\sum_{p=0}^kβ_p(Δν)∇^{p}f[n]
```
#### Example:
```
k = 2; Δν = 0
o = fdiff_expansion_coeffs_differentiation(Δν, k); println(o)
 [0.0, 1.0, -1.5]
```
"""
function fdiff_expansion_coeffs_differentiation(Δν::T, k=3) where T<:Real
# ==============================================================================
#   finite difference expansion coeffs for differentiation
#   in interval -k ≤ x ≤ 0
# ==============================================================================
    a = Base.prepend!([1//i for i=1:k],[0//1])
    Δx == 0 && return a
    b = CamiXon.fdiff_interpolation_expansion_coeffs(Δν, k)

    a,b = Base.promote(a,b)

    return CamiXon.polynom_product_expansion(a, b, k)

end

# ================= fdiff_differentiation(f; k=3) ==============================

@doc raw"""
    fdiff_differentiation(f::Vector{T}; k=3) where T<:Real

``k^{th}``-order lagrangian *differentiation* of the analytic function ``f``,
tabulated in forward order on a uniform grid of ``n`` points, ``f[1:n]``.
#### Example:
```
f = [0.0, 1.0, 4.0, 9.0, 16.0, 25.0]
f′= fdiff_differentiation(f; k=3); println("f′= $(f′)")
  f′= [0.0, 2.0, 4.0, 6.0, 7.999999999999998, 9.999999999999993]
```
For a cubic function the third-order lagrangian differentiation is exact -
see Figure below.

![Image](./assets/lagrangian_differentiation.png)
"""
function fdiff_differentiation(f::Vector{T}; k=3) where T<:Real

    l = length(f)
    k = min(k,l-1)
    k > 1 || error("Error: k ≥ 2 required for lagrangian differentiation")
    m = (l÷(k+1))*(k+1)

    β = [fdiff_expansion_coeffs_differentiation(-x, k) for x=-k:0]
    w = [fdiff_expansion_weights(β[i]) for i ∈ eachindex(β)]

    f′= vec([f[n:n+k] ⋅ w[i] for i ∈ eachindex(w), n=1:k+1:m])

    l > m || return f′

    rest = [f[l-k:l] ⋅ w[1+i] for i=k-l+m+1:k]

    return append!(f′,rest)

end

# ============ create_lagrange_differentiation_matrix(k) =======================

@doc raw"""
    create_lagrange_differentiation_matrix(k::Int)

Lagrange differentiation matrix, ``m[i,j]=s_{k-j}^k(i)``, for ``k^{th}``-order
lagrangian differentiation,
```math
\frac{dy}{dx}[i]= \sum_{j=0}^{k}m[i,j]y[j],
```
#### Example:
```
k = 3
create_lagrange_differentiation_matrix(k)
 4×4 Matrix{Rational{Int64}}:
  -11//6   3//1  -3//2   1//3
   -1//3  -1//2   1//1  -1//6
    1//6  -1//1   1//2   1//3
   -1//3   3//2  -3//1  11//6
```
"""
function create_lagrange_differentiation_matrix(k::Int)

    m = Matrix{Rational{Int}}(undef,k+1,k+1)

    for i=0:k
        coeffs = CamiXon.fdiff_expansion_coeffs_differentiation(k-i,k)
        m[1+i,1:k+1] = fdiff_expansion_weights(coeffs)
    end

    return m

end

# ================ fdiff_expansion_coeffs_array_differentiation(k, m) =========



# =========== trapezoidal_weights(k; rationalize=false, devisor=false) =========

@doc raw"""
    trapezoidal_weights(k::Int [; rationalize=false [, devisor=false]])

Weight coefficient vector ``a=[a_1,⋯\ a_k]`` of trapeziodal rule
optimized for functions of polynomial form,
```math
    ∫_0^n f(x) dx = a_1 (f_0+f_n) + ⋯ + a_k (f_{k-1}+f_{n-k+1})
                                                         + (f_k+⋯+f_{n-k}),
```
where ``k`` is *odd*. The rule is exact for polynonials of degree ``d=0,\ 1,
⋯,\ k-1``. For ``k=1`` the rule reduces to the ordinary trapezoidal rule.
By default the output is in Float64, optionally the output is rational, with or
without specification of the gcd devisor.
#### Example::
```
[trapezoidal_weights(k; rationalize=true, devisor=true) for k=1:2:9]
5-element Vector{Tuple{Int64, Int64, Vector{Int64}}}:
  (1, 2, [1])
  (3, 24, [9, 28, 23])
  (5, 1440, [475, 1902, 1104, 1586, 1413])
  (7, 120960, [36799, 176648, 54851, 177984, 89437, 130936, 119585])
  (9, 7257600, [2082753, 11532470, 261166, 16263486, -1020160, 12489922,
                                                     5095890, 7783754, 7200319])
```
"""
function trapezoidal_weights(k::Int; rationalize=false, devisor=false)
# ==============================================================================
# trapezoidal_weights(k; rationalize=false, devisor=false)
# ==============================================================================
    strWarn = "Warning: k = $(k-1) → $(k) (trapezoidal rule requires odd k)"
    Base.isodd(k) ? true :
                   (k=k+1; println(strWarn))

    l = k - 1
    σ = Base.Matrix{Int}(undef,k,k)

    for i=0:k-1
        σ[i+1,:] = CamiXon.polynom_power([i,-1],l) # corresponds to a0,...ak
        σ[i+1,1] = σ[i+1,1] + i^l                  # correction of coeff a0
    end

    F = CamiXon.faulhaber_polynom(k)
    s = [CamiXon.polynom_power([-k,1],p) for p=0:k] .* F
    s[1][1] = -CamiXon.faulhaber_summation(k-1,l)//1

    c = [Base.sum([s[p+1][i+1] for p=i:k]) for i=0:k][1:end-1]

    σ = Base.inv(Base.transpose(σ))

    o = -σ * c  # solving matrix equation results in trapezoidal_weights

    if rationalize
        a = CamiXon.fdiff_expansion_coeffs_adams_moulton(k)
        D = Base.denominator(Base.gcd(a))          # == Adams-Moulton devisor
        o = devisor ? (k, D, Base.round.(Int, o* D)) :
                      Base.round.(Int, o* D) // D  # convert to Rational{Int}
    end

    return o

end

# ======================== trapezoidal_integration(f, domain; k=5) =============

@doc raw"""
    trapezoidal_integration(f, x1, x2, weights)

Integral of the tabulated function ``f=[f_0,⋯\ f_n]`` over the `domain`
``x1 ≤ x ≤ x2`` using the optimized trapezoidal rule with endpoint correction
by the weights vector `weights`,
```math
    ∫_0^n f(x) dx = a_1 (f_0+f_n) + ⋯ + a_k (f_{k-1}+f_{n-k+1})
                                                         + (f_k+⋯+f_{n-k}).
```
The rule is exact for polynonials of degree ``d=0,\ 1,⋯\ k-1``.
For ``k=1`` the rule reduces to the ordinary trapezoidal rule (weights = [1/2]).
#### Examples::
```
p = 3
c = [1 for i=0:p]
pol = ImmutablePolynomial(c,:z)
Ipol = integrate(pol)
n = 10

x1=0.0
x2=5.0
x = collect(range(x1, x2, n))
f = pol.(x .-2.5)

w3 = trapezoidal_weights(3)
trapezoidal_integration(f, x1, x2, w3)
 15.416666666666673

Ipol(2.5)-Ipol(-2.5)
 15.41666666666666
```
"""
function trapezoidal_integration(f, x1, x2, weights)

    n = Base.length(f)
    k = Base.length(weights)
    s = (x2-x1)/(n-1)
    a = Base.ones(n); a[1:k] = weights; a[end-k+1:end] = Base.reverse(weights)
    o = (f ⋅ a) * s

    return o

end
