function _canonical_partition(n::Int, m::Int)

    o = Base.fill(m,Base.cld(n,m))                              # init partition
    o[Base.cld(n,m)]=((n%m)≠0 ? n%m : m)                        # adjust last element of partition

    return o

end

"""
    canonical_partitions(n; header=false, reverse=true)

The canonical partition in integers of the integer n

header=true : unit patition included in output
#### Examples:
```
canonical_partitions(6; header=true, reverse=false)
6-element Array{Array{Int64,1},1}:
 [6]
 [5, 1]
 [4, 2]
 [3, 3]
 [2, 2, 2]
 [1, 1, 1, 1, 1, 1]

canonical_partitions(6; header=true)
6-element Array{Array{Int64,1},1}:
 [1, 1, 1, 1, 1, 1]
 [2, 2, 2]
 [3, 3]
 [4, 2]
 [5, 1]
 [6]

canonical_partitions(6)
5-element Array{Array{Int64,1},1}:
 [1, 1, 1, 1, 1, 1]
 [2, 2, 2]
 [3, 3]
 [4, 2]
 [5, 1]
```
"""
function canonical_partitions(n::Int, m=0; header=true, reverse=true)

    h = header ? n : n-1

    if m == 0
        if reverse
            o = [_canonical_partition(n,m) for m=1:h]
        else
            o = [_canonical_partition(n,m) for m=h:-1:1]
        end
    elseif 0 < m <= n
        o = _canonical_partition(n,m)
    else
        o = nothing
    end

    return o

end



function _partition_count(n::Int,k::Int)

    (n<0)|(k<0)|(k>n) ? 0 : (k==n)|(k==1) ? 1 : _partition_count(n-k,k) + _partition_count(n-1,k-1)

end

function _partition(a::Array{Int,1}, n::Int, i::Int, cp::Array{Array{Array{Int,1},1},1})

    o = a[1:i-1]
    m = a[i]-1                                           # m: partition value
    ni = n - Base.sum(o)                                 # ni: sub-partition index at partition index i

    Base.append!(o,cp[ni][m])                            # complete partition by appending it to a

    return o

end

function _restricted_partitions(o::Array{Int,1}, n::Int, np::Int, cp::Array{Array{Array{Int,1},1},1})

    oo = [o]

    for p=1:np-1
        i = Base.findlast(x -> x > 1, oo[p])
        Base.append!(oo,[_partition(oo[p],n,i,cp)])
    end

    return oo

end

"""
    integer_partitions(n [,m]; transpose=false, count=false)

default              : The integer partitions of n

count=true           : The number of integer partitions of n

transpose=false/true : for m>0 restricted to partitions with maximum part/length m

definitions:

The integer partition of the positive integer n is a nonincreasing sequence of positive integers p1, p2,... pk whose sum is n.

The elements of the sequence are called the parts of the partition.
#### Examples:
```
integer_partitions(7)
15-element Array{Array{Int64,1},1}:
 [1, 1, 1, 1, 1, 1, 1]
 [2, 2, 2, 1]
 [3, 3, 1]
 [4, 3]
 [5, 2]
 [6, 1]
 [7]
 [2, 2, 1, 1, 1]
 [3, 2, 2]
 [4, 2, 1]
 [5, 1, 1]
 [2, 1, 1, 1, 1, 1]
 [3, 2, 1, 1]
 [4, 1, 1, 1]
 [3, 1, 1, 1, 1]

integer_partitions(7; count=true)
15

integer_partitions(7,4; count=true)
3

integer_partitions(7,4)
3-element Array{Array{Int64,1},1}:
 [4, 3]
 [4, 2, 1]
 [4, 1, 1, 1]

integer_partitions(7,4; transpose=true)
3-element Array{Array{Int64,1},1}:
 [2, 2, 2, 1]
 [3, 2, 1, 1]
 [4, 1, 1, 1]
```
"""
function integer_partitions(n::Int, m=0; transpose=false, count=false)

    cp = [canonical_partitions(m) for m=1:n]
    pc = [_partition_count(n,m)  for m=1:n]
    oo = [ones(Int,n)]

    np = m > 0 ? pc[m] : sum(pc)

    if !count

        if m == 0
            o = [_restricted_partitions(cp[n][p],n,pc[p],cp) for p=2:n]
            for p=1:n-1 append!(oo,o[p]) end
        else
            oo = _restricted_partitions(cp[n][m],n,pc[m],cp)
        end

        if transpose
            for p=1:np
                l = length(oo[p])
                s=max(oo[p][1],l)
                mat = zeros(Int,s,s)
                for j=1:l for i=1:oo[p][j] mat[i,j]=1 end end
                oo[p] = [sum(mat[i,:]) for i=1:oo[p][1]]
            end

        end

    end

    return count ? np : oo

end

# ===================================== log10_characteristic_power(x) ==============================================
"""
    log10_characteristic_power(x)

characteristic power-of-10 of the number x
#### Examples:
```
log10_characteristic_power.([3,30,300])
3-element Vector{Int64}:
 0
 1
 2
```
"""
log10_characteristic_power(x) = Base.round(Int,Base.floor(log10(x)))

# ==================================== log10_mantissa(x) ============================================================
"""
    log10_mantissa(x)

log10 mantissa of the number x
#### Examples:
```
log10_mantissa.([3,30,300])
3-element Vector{Float64}:
 0.47712125471966244
 0.4771212547196624
 0.4771212547196626
```
"""
log10_mantissa(x) = Base.log10(x)-Base.floor(Base.log10(x))

# ==================================== polynom_deriv_coeffs(c,deriv) ============================================================

function _polynom_deriv_multipliers(c,deriv)

    d = Base.OneTo(length(c))

    for i=1:deriv
        c = c .* (d .- i)
    end

    return c

end

@doc raw"""
    polynom_deriv_coeffs(c[,deriv=0])

Coefficient vector defining the derivative `deriv` of the polynomial ``p(c,d)``, of degree ``d``,
defined by the coefficient vector c``=[c_0 +\ \ldots,\ c_d]``.

### Examples:
```
d = 5
c = [1.0 for i=1:d+1]
polynom_deriv_coeffs(c)                # default is direct copy of `c`
 [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
polynom_deriv_coeffs(c,1)              # coefficients of 1st derivative of `polynom(c,x)`
 [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
polynom_deriv_coeffs(c,2)              # coefficients of 2nd derivative of `polynom(c,x)`
 [-0.0, 0.0, 2.0, 6.0, 12.0, 20.0]
polynom_deriv_coeffs(c,5)              # coefficients of 5th derivative of `polynom(c,x)`
 [0.0, -0.0, 0.0, -0.0, 0.0, 120.0]
polynom_deriv_coeffs(c,6)              # coefficients of 6th derivative of `polynom(c,x)`
 [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
```
"""
function polynom_deriv_coeffs(c,deriv=0)

    deriv < 0 && error("Error: negative derivative not defined")
    deriv < length(c) || return Base.zeros(length(c))

    return [_polynom_deriv_multipliers(c, i-1) for i ∈ eachindex(c)][deriv+1]

end

# ==================================== polynom(c,x) ============================================================

@doc raw"""
    polynom(c,x)

Coefficient vector ``c=[c_0 +\ \ldots,\ c_d]`` defining the polynomial of degree ``d``,
```math
p(c,x)=c_0 + c_1*x +\ \cdots,\c_n*x^d.
```
### Examples:
```
d = 5
c = [1.0 for i=1:d+1]
c = polynom_deriv_coeffs(c)          # default is simple
println(c)
 [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
f(x) = polynom(c,x)
println([f(1.0),f(2.0)])             # values of polynomial for x = 1.0 and x = 2.0
 [6.0, 63.0]
```
"""
function polynom(c::Vector{T}, x::T) where T<:Real

    X = ones(T,length(c))

    for i=2:length(c)
        X[i] = X[i-1] * x
    end

    return LinearAlgebra.dot(c, X)

end

# ==================================== polynom_multiplication_coeffs(a, b) ============================================================

@doc raw"""
    polynom_multiplication_coeffs(a::Vector{<:Number}, b::Vector{<:Number})

Coefficient vector ``c=[c_0,\ \ldots,\ c_{n+m}]`` of the polynomial of degree ``m+n``
```math
    p(c,x)=a_0b_0 + (a_0b_1 + b_0a_1)x +\ \cdots\ a_n b_m x^{n+m},
```
given by the product of two polynomials, of degree ``n`` and ``m``, defined by the
coefficient vectors ``a=[a_0,\ \ldots,\ a_n]`` and  ``b=[b_0,\ \ldots,\ b_m]``.
####
```
a = [1,1]
b = [1,- 1]
o = polynomial_multiplication_coeffs(a, b); println(o)
 [1, 0, -1]
```
"""
function polynom_multiplication_coeffs(a::Vector{<:Number}, b::Vector{<:Number})

    n = length(a)
    m = length(b)

    if m ≥ n
        o = [sum(a[1+j-i]*b[1+i] for i=0:j) for j=0:n-1]
        if m≠n append!(o,[sum(a[n-i]*b[1+i+j] for i=0:n-1) for j=1:m-n]) end
        append!(o,[sum(a[n-i]*b[1+i+j+m-n] for i=0:n-1-j) for j=1:n-1])
    else
        o = [sum(b[1+j-i]*a[1+i] for i=0:j) for j=0:m-1]
        if m≠n append!(o,[sum(b[m-i]*a[1+i+j] for i=0:m-1) for j=1:n-m]) end
        append!(o,[sum(b[m-i]*a[1+i+j+n-m] for i=0:m-1-j) for j=1:m-1])
    end

    return o

end

# ==================================== permutations_unique_count(p, i) =======================

@doc raw"""
    permutations_unique_count(p::Array{Array{Int64,1},1}, i::Int)

Number of unique permutations of the subarray ``p[i]``.
#### Example:
```
p = [[1,2,3],[2,3,1,4,3]]
permutations_unique_count(p,2)
 60
```
"""
function permutations_unique_count(p::Array{Array{Int64,1},1}, i::Int)

    o = factorial(length(p[i]))
    d = Dict([(n,count(x->x==n,p[i])) for n ∈ unique(p[i])])

    for j ∈ eachindex(unique(p[i]))
        o = o ÷ factorial(d[unique(p[i])[j]])
    end

    return o

end
