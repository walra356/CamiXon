module CamiXon

export find_all
export find_first
export find_last
export canonical_partitions
export integer_partitions
export permutations_cnt


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

function _restricted_partitions(o::Array{Int,1}, n::Int, np::Int, ll::Array{Array{Int,1},1}, cp::Array{Array{Array{Int,1},1},1})
    
    oo = [o]
               
    for p=1:np-1
        i = Base.findlast(oo[p].>ll[length(oo[p])])
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
    
    ll = [ones(Int,l) for l=1:n]     
    cp = [canonical_partitions(m) for m=1:n] 
    oo = [ll[n]]
    pc = [_partition_count(n,m)  for m=1:n]
    
    np = m > 0 ? pc[m] : sum(pc)
    
    if !count
        
        if m == 0
            o = [_restricted_partitions(cp[n][p],n,pc[p],ll,cp) for p=2:n]
            for p=1:n-1 append!(oo,o[p]) end
        else
            oo = _restricted_partitions(cp[n][m],n,pc[m],ll,cp)
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


"""
    permutations_cnt(A::AbstractArray{T,1}; unique = false)  where T

The number of permutations (option: unique permutations) of the elements of a 1D array

#### Examples:
```
A = collect("ahsgh")
permutations_cnt(A)
 120

permutations_cnt(A; unique=true)
 60
```
"""
function permutations_cnt(A::AbstractArray{T,1}; unique = false)  where T
    if unique
        o = factorial(length(A))
        c = indices_cnt(A)
        for i in eachindex(c) o = o ÷ c[i] end
        return o
    else
        return factorial(length(A)) # default
    end
end

end

