var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = CamiXon","category":"page"},{"location":"#CamiXon.jl","page":"Home","title":"CamiXon.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A package for image analysis of backscattered light","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"indices(A::AbstractArray{T,1}, a::T...)  where T\nindices_cnt(A::AbstractArray{T,1}, a::T...)  where T\npartitions_cnt(n::Int,k::Int)\npartitions_cnt(n::Int)\npermutations_cnt(A::AbstractArray{Any,1}; unique = false)","category":"page"},{"location":"#CamiXon.indices-Union{Tuple{T}, Tuple{AbstractArray{T,1},Vararg{T,N} where N}} where T","page":"Home","title":"CamiXon.indices","text":"indices(A::AbstractArray{T,1}, a::T...)  where T\n\nThe index (indices) of selected Array elements (default: all elements)\n\nExamples:\n\nA = collect(\"ahsgh\")\nindices(A,'h')\n1-element Array{Array{Int64,1},1}:\n [2, 5]\n\nindices(A)\n4-element Array{Array{Int64,1},1}:\n [1]\n [2, 5]\n [3]\n [4]\n\nA = [1,2,3,4,2]\nindices(A,2)\n1-element Array{Array{Int64,1},1}:\n [2, 5]\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.indices_cnt-Union{Tuple{T}, Tuple{AbstractArray{T,1},Vararg{T,N} where N}} where T","page":"Home","title":"CamiXon.indices_cnt","text":"indices_cnt(A::AbstractArray{T,1}, a::T...)  where T\n\nThe number of indices of selected Array elements (default: all elements)\n\nExamples:\n\nA = collect(\"ahsgh\")\nindices_cnt(A,'h')\n1-element Array{Array{Int64,1},1}:\n 2\n\nindices_cnt(A)\n4-element Array{Array{Int64,1},1}:\n 1\n 2\n 1\n 1\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.partitions_cnt-Tuple{Int64,Int64}","page":"Home","title":"CamiXon.partitions_cnt","text":"partitions_cnt(n::Int,k::Int)\n\nThe number of integer partitions of n in k parts\n\nExample:\n\npartitions_cnt(5,2)\n 2\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.partitions_cnt-Tuple{Int64}","page":"Home","title":"CamiXon.partitions_cnt","text":"partitions_cnt(n::Int)\n\nThe total number of integer partitions of n\n\nExample:\n\npartitions_cnt(5)\n 7\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.permutations_cnt-Tuple{AbstractArray{Any,1}}","page":"Home","title":"CamiXon.permutations_cnt","text":"permutations_cnt(A::AbstractArray{T,1}; unique = false)  where T\n\nThe number of permutations (option: unique permutations) of the elements of a 1D array\n\nExamples:\n\nA = collect(\"ahsgh\")\npermutations_cnt(A)\n 120\n\npermutations_cnt(A; unique=true)\n 60\n\n\n\n\n\n","category":"method"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
