var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = CamiXon","category":"page"},{"location":"#CamiXon.jl","page":"Home","title":"CamiXon.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A package for image analysis of backscattered light","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Table-of-contents","page":"Home","title":"Table of contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#File-manipulation","page":"Home","title":"File manipulation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"decompose_filnam(str::String)\nfits_combine(filnamFirst::String, filnamLast::String; info=false)\nfits_copy(filnam, filnamOut=\"\"; protect=true)\nfits_info(filnam::String; info=false)\nfits_key_create(filnam::String, key::String, value, comment::String)\nfits_key_delete(filnam::String, key::String)\nfits_key_edit(filnam::String, key::String, value, comment::String)\nfits_key_info(filnam::String, key::String)\nfits_key_rename(filnam::String, key::String, keynew::String)","category":"page"},{"location":"#CamiXon.decompose_filnam-Tuple{String}","page":"Home","title":"CamiXon.decompose_filnam","text":"decompose_filnam(str)\n\nDecompose filename into its name (and, if present, extension, prefix and numerator).\n\nExamples:\n\nstrExample = \"T23.01.fits\"\n\ndict = decompose_filnam(strExample)\nDict{String,String} with 4 entries:\n  \"Extension\" => \".fits\"\n  \"Numerator\" => \"01\"\n  \"Prefix\"    => \"T23.\"\n  \"Name\"      => \"T23.01\"\n\nget(dict,\"Numerator\",\"Numerator: Key absent\")\n\"01\"\n\nget(dict,\"Wild\",\"Key absent\")\n\"Key absent\"\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_combine-Tuple{String,String}","page":"Home","title":"CamiXon.fits_combine","text":"fits_combine(str1, str2 [; info=false])\n\nCombine a series of .fits files into a single .fits file.\n\nExample:\n\nfits_combine(\"T01.fits\", \"T22.fits\"; info=false)\nT01-T22.FITS: file was created (for more information set info=true)\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_copy","page":"Home","title":"CamiXon.fits_copy","text":"fits_copy(filnam [, filnam2=\"\" [; protect=true]])\n\nCopy \"filnam.fits\" to \"filnam2.fits\"\n\nExamples:\n\nfits_copy(\"T01.fits\")\nT01.fits was saved as T01 - Copy.fits\n\nfits_copy(\"T01.fits\", \"T01a.fits\")\n\"T01a.fits: filname in use (overwrite protected)\"\n\nfits_copy(\"T01.fits\", \"T01a.fits\"; protect=false)\nT01.fits was saved as T01a.fits\n\n\n\n\n\n","category":"function"},{"location":"#CamiXon.fits_info-Tuple{String}","page":"Home","title":"CamiXon.fits_info","text":"fits_info(filnam [; info=false])\n\nMetainformation of 'filnam.fits'\n\nExample:\n\nfits_info(\"T01.fits\"; info=false)\nT01.fits: file was found (for more information set info=true)\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_key_create-Tuple{String,String,Any,String}","page":"Home","title":"CamiXon.fits_key_create","text":"fits_key_create(filnam, key, value, comment)\n\ncreate FITS key record\n\nExample:\n\nfilnam = \"T01.fits\"\nfits_key_create(filnam,\"Test\",3,\"this is a test\")\n(\"TEST\", 3, \"this is a test\")\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_key_delete-Tuple{String,String}","page":"Home","title":"CamiXon.fits_key_delete","text":"fits_key_delete(filnam, key)\n\nedit FITS key record\n\nExample:\n\nfilnam = \"T01.fits\"\nfits_key_info(filnam,\"test\")\n\"key 'TEST' not in use\"\n\nfits_key_create(filnam,\"Test\",3,\"this is a test\")\n(\"TEST\", 3, \"this is a test\")\n\nfits_key_delete(filnam,\"test\")\n\"TEST: key succesfully deleted\"\n\nfits_key_info(filnam,\"test1\")\n\"key 'TEST' not in use\"\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_key_edit-Tuple{String,String,Any,String}","page":"Home","title":"CamiXon.fits_key_edit","text":"fits_key_edit(filnam, key, value, comment)\n\nedit FITS key record\n\nExample:\n\nfilnam = \"T01.fits\"\nfits_key_edit(filnam, \"USERTXT1\", 3, \"my text\")\n(\"USERTXT1\", 3, \"my text\")\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_key_info-Tuple{String,String}","page":"Home","title":"CamiXon.fits_key_info","text":"fits_key_info(filnam::String, key::String)\n\nshow FITS key record\n\nExample:\n\nfilnam = \"T01.fits\"\nfits_key_info(filnam,\"NAXIS1\")\n(\"NAXIS1\", 512, \"length of data axis 1\")\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_key_rename-Tuple{String,String,String}","page":"Home","title":"CamiXon.fits_key_rename","text":"fits_key_rename(filnam, key, keynew)\n\nrename FITS key\n\nExamples:\n\nfilnam = \"T01.fits\"\nfits_key_info(filnam,\"test1\")\n\"key 'TEST1' not in use\"\n\nfits_key_create(filnam,\"Test\",3,\"this is a test\")\n(\"TEST\", 3, \"this is a test\")\n\nfits_key_rename(filnam,\"test\",\"test1\")\n(\"TEST1\", 3, \"this is a test\")\n\nfits_key_info(filnam,\"test1\")\n(\"TEST1\", 3, \"this is a test\")\n\n\n\n\n\n","category":"method"},{"location":"#Search-algorithms","page":"Home","title":"Search algorithms","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"find_all(A::Union{String,AbstractArray{T,1}}, a::T...; count=false)  where T\nfind_first(A::Union{String,AbstractArray{T,1}}, a::T...; dict=false)  where T\nfind_last(A::Union{String,AbstractArray{T,1}}, a::T...; dict=false)  where T","category":"page"},{"location":"#CamiXon.find_all-Union{Tuple{T}, Tuple{Union{AbstractArray{T,1}, String},Vararg{T,N} where N}} where T","page":"Home","title":"CamiXon.find_all","text":"find_all(A [,a...]; count=false)\n\nA: string/array of elements of the same type\n\ndefault   : Array containing the index (indices) of selected elements of A (default: all elements)\n\ncount=true: The number of indices found for selected elements of A (default: all elements)\n\nExamples:\n\nA = [:📑,:📌,:📢,:📌,:📞]\nB = [1,2,3,2,5]\nstr = \"aβcβd\";\nfind_all(A) == find_all(B) == find_all(str)\ntrue\n\nfind_all(A,:📌)\n1-element Array{Array{Int64,1},1}:\n [2, 4]\n\nfind_all(str)\n4-element Array{Array{Int64,1},1}:\n [1]\n [2, 4]\n [3]\n [5]\n\nfind_all(A; count=true)\n4-element Array{Int64,1}:\n 1\n 2\n 1\n 1\n\nstr = \"📑📌📢📌📞\"\nfind_all(str,'📌')\n1-element Array{Array{Int64,1},1}:\n [2, 4]\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.find_first-Union{Tuple{T}, Tuple{Union{AbstractArray{T,1}, String},Vararg{T,N} where N}} where T","page":"Home","title":"CamiXon.find_first","text":"find_first(A [,a...]; dict=false)\n\nThe first index of selected Array element\n\nA: string/array of elements of the same type\n\ndefault  : Array containing the first index (indices) of selected elements of A (default: all elements)\n\ndict=true: Dict for the first index (indices) of selected elements of A (default: all elements)\n\nExamples:\n\nA = [:📑,:📌,:📢,:📌,:📞]\nB = [1,2,3,2,5]\nstr = \"aβcβd\";\n\nfind_first(A) == find_first(B) == find_first(str)\ntrue\n\nfind_first(A,:📌)\n1-element Array{Array{Int64,1},1}:\n 2\n\nfind_last(A,:📌; dict=true)\n1-element Array{Pair{Symbol,Int64},1}:\n :📌 => 2\n\nfind_last(A; dict=true)\n4-element Array{Pair{Symbol,Int64},1}:\n :📑 => 1\n :📌 => 2\n :📢 => 3\n :📞 => 5\n\nfind_first(str)\n4-element Array{Int64,1}:\n 1\n 2\n 3\n 5\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.find_last-Union{Tuple{T}, Tuple{Union{AbstractArray{T,1}, String},Vararg{T,N} where N}} where T","page":"Home","title":"CamiXon.find_last","text":"find_last(A [,a...]; dict=false)\n\nThe last index of selected Array element\n\nA: string/array of elements of the same type\n\ndefault  : Array containing the lasst index (indices) of selected elements of A (default: all elements)\n\ndict=true: Dict for the lasst index (indices) of selected elements of A (default: all elements)\n\nExamples:\n\nA = [:📑,:📌,:📢,:📌,:📞]\nB = [1,2,3,2,5]\nstr = \"aβcβd\";\nfind_last(A) == find_first(B) == find_first(str)\ntrue\n\nfind_last(A,:📌)\n1-element Array{Array{Int64,1},1}:\n 4\n\nfind_last(A,:📌; dict=true)\n1-element Array{Pair{Symbol,Int64},1}:\n :📌 => 4\n\nfind_last(A; dict=true)\n4-element Array{Pair{Symbol,Int64},1}:\n :📑 => 1\n :📌 => 4\n :📢 => 3\n :📞 => 5\n\nfind_last(str)\n4-element Array{Int64,1}:\n 1\n 4\n 3\n 5\n\n\n\n\n\n","category":"method"},{"location":"#Math","page":"Home","title":"Math","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"canonical_partitions(n::Int, m=0; header=true, reverse=true)\ninteger_partitions(n::Int, m=0; transpose=false, count=false)","category":"page"},{"location":"#CamiXon.canonical_partitions","page":"Home","title":"CamiXon.canonical_partitions","text":"canonical_partitions(n; header=false, reverse=true)\n\nThe canonical partition in integers of the integer n\n\nheader=true : unit patition included in output\n\nExamples:\n\ncanonical_partitions(6; header=true, reverse=false)\n6-element Array{Array{Int64,1},1}:\n [6]\n [5, 1]\n [4, 2]\n [3, 3]\n [2, 2, 2]\n [1, 1, 1, 1, 1, 1]\n\ncanonical_partitions(6; header=true)\n6-element Array{Array{Int64,1},1}:\n [1, 1, 1, 1, 1, 1]\n [2, 2, 2]\n [3, 3]\n [4, 2]\n [5, 1]\n [6]\n\ncanonical_partitions(6)\n5-element Array{Array{Int64,1},1}:\n [1, 1, 1, 1, 1, 1]\n [2, 2, 2]\n [3, 3]\n [4, 2]\n [5, 1]\n\n\n\n\n\n","category":"function"},{"location":"#CamiXon.integer_partitions","page":"Home","title":"CamiXon.integer_partitions","text":"integer_partitions(n [,m]; transpose=false, count=false)\n\ndefault              : The integer partitions of n\n\ncount=true           : The number of integer partitions of n\n\ntranspose=false/true : for m>0 restricted to partitions with maximum part/length m\n\ndefinitions:\n\nThe integer partition of the positive integer n is a nonincreasing sequence of positive integers p1, p2,... pk whose sum is n.\n\nThe elements of the sequence are called the parts of the partition.\n\nExamples:\n\ninteger_partitions(7)\n15-element Array{Array{Int64,1},1}:\n [1, 1, 1, 1, 1, 1, 1]\n [2, 2, 2, 1]\n [3, 3, 1]\n [4, 3]\n [5, 2]\n [6, 1]\n [7]\n [2, 2, 1, 1, 1]\n [3, 2, 2]\n [4, 2, 1]\n [5, 1, 1]\n [2, 1, 1, 1, 1, 1]\n [3, 2, 1, 1]\n [4, 1, 1, 1]\n [3, 1, 1, 1, 1]\n\ninteger_partitions(7; count=true)\n15\n\ninteger_partitions(7,4; count=true)\n3\n\ninteger_partitions(7,4)\n3-element Array{Array{Int64,1},1}:\n [4, 3]\n [4, 2, 1]\n [4, 1, 1, 1]\n\ninteger_partitions(7,4; transpose=true)\n3-element Array{Array{Int64,1},1}:\n [2, 2, 2, 1]\n [3, 2, 1, 1]\n [4, 1, 1, 1]\n\n\n\n\n\n","category":"function"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
