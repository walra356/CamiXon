var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = CamiXon","category":"page"},{"location":"#CamiXon.jl","page":"Home","title":"CamiXon.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A package for image analysis of backscattered light","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"indices(A::AbstractArray{T,N}, a::T...)  where {T,N}\nindices_cnt(A::AbstractArray{T,N}, a::T...)  where {T,N}\npartitions_cnt(n::Int,k::Int)\npartitions_cnt(n::Int)\npermutation_cnt(A::AbstractArray{T,N}; unique = false)  where {T,N}","category":"page"},{"location":"#CamiXon.indices-Union{Tuple{N}, Tuple{T}, Tuple{AbstractArray{T,N},Vararg{T,N} where N}} where N where T","page":"Home","title":"CamiXon.indices","text":"function indices(A::AbstractArray{T,N}, a::T...)  where {T,N}\n\nFind the index (indices) of selected Array elements (default: all elements).\n\nExamples:\n\nA = collect(\"ahsgh\")\nindices(A,'h')\n1-element Array{Array{Int64,1},1}:\n [2, 5]\n\nindices(A)\n4-element Array{Array{Int64,1},1}:\n [1]\n [2, 5]\n [3]\n [4]\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.indices_cnt-Union{Tuple{N}, Tuple{T}, Tuple{AbstractArray{T,N},Vararg{T,N} where N}} where N where T","page":"Home","title":"CamiXon.indices_cnt","text":"indices_cnt(A::AbstractArray{T,N}, a::T...)  where {T,N}\n\nCount the number of indices of selected Array elements (default: all elements).\n\nExamples:\n\nA = collect(\"ahsgh\")\nindices_cnt(A,'h')\n1-element Array{Array{Int64,1},1}:\n 2\n\nindices_cnt(A)\n4-element Array{Array{Int64,1},1}:\n 1\n 2\n 1\n 1\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.partitions_cnt-Tuple{Int64,Int64}","page":"Home","title":"CamiXon.partitions_cnt","text":"partitions_cnt(n::Int,k::Int)\nthe number of partitions of n in k parts\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.partitions_cnt-Tuple{Int64}","page":"Home","title":"CamiXon.partitions_cnt","text":"partitions_cnt(n::Int)\nthe total number of partitions of n\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.permutation_cnt-Union{Tuple{AbstractArray{T,N}}, Tuple{N}, Tuple{T}} where N where T","page":"Home","title":"CamiXon.permutation_cnt","text":"permutation_cnt(A::AbstractArray{T,N}; unique = false)  where {T,N}\n\nCount the number of permutations (option: unique permutations).\n\nExamples:\n\nA = collect(\"ahsgh\")\npermutation_cnt(A)\n 120\n\npermutation_cnt(A; unique=true)\n 60\n\n\n\n\n\n","category":"method"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
