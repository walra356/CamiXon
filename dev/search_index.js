var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = CamiXon","category":"page"},{"location":"#CamiXon.jl","page":"Home","title":"CamiXon.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A package for image analysis of backscattered light","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Table-of-contents","page":"Home","title":"Table of contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#FITS","page":"Home","title":"FITS","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"FITS stands for 'Flexible Image Transport System'. This is an open standard origionally developed for the astronomy community to store telescope images together with tables of spectral information. Over the years it has developed into a scientific standard - http://fits.gsfc.nasa.gov/iaufwg.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Within CamiXion only the basic FITS functionality is implemented for users not requiring celestal coordinates. The user can create, read and extend .fits files as well as create, edit and delete user-defined metainformation.","category":"page"},{"location":"","page":"Home","title":"Home","text":"A FITS file consists of a sequence of one or more header-data-units (HDUs), each containing a data block preceeded by header records of metainformation.","category":"page"},{"location":"","page":"Home","title":"Home","text":"By the command f = fits_read(filnam) we asign a collection of FITS_HDU objects from the file filnam to the variable f.","category":"page"},{"location":"","page":"Home","title":"Home","text":"FITS_HDU\nFITS_header\nFITS_data\nFITS_table\nparse_FITS_TABLE(FITS_HDU)\nFITS_name\ncast_FITS_name(filename::String)\nfits_info(hdu::FITS_HDU)\nfits_create(filename::String, data=[]; protect=true)\nfits_read(filename::String)\nfits_extend(filename::String, data_extend, hdutype=\"IMAGE\")\nfits_copy(filenameA::String, filenameB::String=\" \"; protect=true)\nfits_add_key(filename::String, hduindex::Int, key::String, val::Real, com::String)\nfits_delete_key(filename::String, hduindex::Int, key::String)\nfits_edit_key(filename::String, hduindex::Int, key::String, val::Real, com::String)\nfits_rename_key(filename::String, hduindex::Int, keyold::String, keynew::String)","category":"page"},{"location":"#CamiXon.FITS_HDU","page":"Home","title":"CamiXon.FITS_HDU","text":"FITS_HDU\n\nObject to hold a single \"Header-Data Unit\" (HDU).\n\nThe fields are\n\n.filename::String: name of the corresponding FITS file\n.hduindex::Int: identifier (a file may contain more than one HDU)\n.header::T, where T=FITS_header: the header object\n.dataobject::V, where V=FITS_data: the data object\n\n\n\n\n\n","category":"type"},{"location":"#CamiXon.FITS_header","page":"Home","title":"CamiXon.FITS_header","text":"FITS_header\n\nObject to hold the header information of a FITS_HDU.\n\nThe fields are:\n\n.hduindex::Int: identifier (a file may contain more than one HDU)\n.records::Array{String,1}:  the header formated as an array of strings of 80 ASCII characters\n.keys::Array{String,1}: keys[i] - key corresponding to records[i] (record of index i)\n.values::Array{Any,1}: value[i] - corresponding to records[i]\n.comments: comments[i] - comment corresponding to records[i]\n.dict::Dict{String,Any}: Dictionary key[i] => value[i]\n.maps::Dict{String,Int}: Dictionary key[i] => i\n\n\n\n\n\n","category":"type"},{"location":"#CamiXon.FITS_data","page":"Home","title":"CamiXon.FITS_data","text":"FITS_data\n\nObject to hold the data of the FITS_HDU of given hduindex and hdutype.\n\nThe fields are:\n\n.hduindex::Int: identifier (a file may contain more than one HDU)\n.hdutype::String: accepted types are 'PRIMARY', 'IMAGE' and 'TABLE'\n.data::Any: in the from appropriate for the hdutype\n\n\n\n\n\n","category":"type"},{"location":"#CamiXon.FITS_table","page":"Home","title":"CamiXon.FITS_table","text":"FITS_table\n\nObject to hold the data of a TABLE HDU (a FITS_HDU for ASCII tables). It contains the data in the form of records (rows) of ASCII strings.\n\nThe fields are:\n\n.hduindex::Int: identifier (a file may contain more than one HDU)\n.rows::Array{String,1}: the table formated as an array of rows of ASCII strings\n\n\n\n\n\n","category":"type"},{"location":"#CamiXon.parse_FITS_TABLE-Tuple{Any}","page":"Home","title":"CamiXon.parse_FITS_TABLE","text":"parse_FITS_TABLE(FITS_HDU)\n\nParse FITS_TABLE into a Vector of its columns for further processing by the user.\n\nExample:\n\n\nf = fits_create(\"minimal.fits\";protect=false)\nfits_info(f[1])\n\n File: minimal.fits\n HDU: 1\n DataType: Any\n Datasize: (0,)\n\n Metainformation:\n SIMPLE  =                    T / file does conform to FITS standard\n NAXIS   =                    0 / number of data axes\n EXTEND  =                    T / FITS dataset may contain extensions\n COMMENT    Basic FITS file     / http://fits.gsfc.nasa.gov/iaufwg\n END\n\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.FITS_name","page":"Home","title":"CamiXon.FITS_name","text":"FITS_name\n\nFITS object to decompose the names of .fits files.\n\nThe fields are:\n\n.name::String: for filename 'p#.fits' this is 'p#.fits'\n.prefix::String: for filename 'p#.fits' this is 'p'\n.numerator::String: for filename 'p#.fits' this is '#', a serial number (e.g., '3') or a range (e.g., '3-7')\n.extension::String:  for filename 'p#.fits' this is '.fits'.\n\n\n\n\n\n","category":"type"},{"location":"#CamiXon.cast_FITS_name-Tuple{String}","page":"Home","title":"CamiXon.cast_FITS_name","text":"cast_FITS_name(filename::String)\n\nDecompose the FITS filename 'filnam.fits' into its name, prefix, numerator and extension.\n\nExamples:\n\nstrExample = \"T23.01.fits\"\nf = analyze_FITS_name(strExample)\nFITS_name(\"T23.01\", \"T23.\", \"01\", \".fits\")\n\nf.name, f.prefix, f.numerator, f.extension\n(\"T23.01\", \"T23.\", \"01\", \".fits\")\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_info-Tuple{FITS_HDU}","page":"Home","title":"CamiXon.fits_info","text":"fits_info(hdu)\n\nPrint metafinformation of given FITS_HDU\n\nExample:\n\nstrExample = \"minimal.fits\"\nfits_create(strExample)\n\nf = fits_read(strExample)\np = fits_info(f[1])\nprintln(p)\n\n  File: minimal.fits\n  HDU: 1\n  DataType: Any\n  Datasize: (0,)\n\n  Metainformation:\n  SIMPLE  =                    T / file does conform to FITS standard\n  NAXIS   =                    0 / number of data axes\n  EXTEND  =                    T / FITS dataset may contain extensions\n  COMMENT    Basic FITS file     / http://fits.gsfc.nasa.gov/iaufwg\n  END\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_create","page":"Home","title":"CamiXon.fits_create","text":"fits_create(filename [, data [; protect=true]])\n\nCreate FITS file of given filename [, optional data block [, default overwrite protection]] and return Array of HDUs. Key:\n\nprotect::Bool: overwrite protection\n\nExamples:\n\nstrExample = \"minimal.fits\"\nfits_create(strExample;protect=false)\n\nf = fits_read(strExample)\na = f[1].dataobject.data\nb = f[1].header.keys\nprintln(a);println(b)\n  Any[]\n  [\"SIMPLE\", \"NAXIS\", \"EXTEND\", \"COMMENT\", \"END\"]\n\nstrExample = \"example.fits\"\ndata = [0x0000043e, 0x0000040c, 0x0000041f]\nfits_create(strExample, data; protect=false)\n\nf = fits_read(strExample)\na = f[1].dataobject.data\nb = f[1].header.keys\nprintln(a);println(b)\n  UInt32[0x0000043e, 0x0000040c, 0x0000041f]\n  [\"SIMPLE\", \"BITPIX\", \"NAXIS\", \"NAXIS1\", \"BZERO\", \"BSCALE\", \"EXTEND\", \"COMMENT\", \"END\"]\n\n\n\n\n\n","category":"function"},{"location":"#CamiXon.fits_read-Tuple{String}","page":"Home","title":"CamiXon.fits_read","text":"fits_read(filename)\n\nRead FITS file and return Array of FITS_HDUs\n\nExample:\n\nstrExample = \"minimal.fits\"\nfits_create(strExample;protect=false)\n\nf = fits_read(strExample)\nf[1].dataobject.data\n  Any[]\n\nrm(strExample); f = nothing\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_extend","page":"Home","title":"CamiXon.fits_extend","text":"fits_extend(filename, data_extend, hdutype=\"IMAGE\")\n\nExtend the FITS file of given filename with the data of hdutype from data_extend  and return Array of HDUs.\n\nExamples:\n\nstrExample = \"test_example.fits\"\ndata = [0x0000043e, 0x0000040c, 0x0000041f]\nfits_create(strExample, data, protect=false)\n\nf = fits_read(strExample)\na = Float16[1.01E-6,2.0E-6,3.0E-6,4.0E-6,5.0E-6]\nb = [0x0000043e, 0x0000040c, 0x0000041f, 0x0000042e, 0x0000042f]\nc = [1.23,2.12,3.,4.,5.]\nd = ['a','b','c','d','e']\ne = [\"a\",\"bb\",\"ccc\",\"dddd\",\"ABCeeaeeEEEEEEEEEEEE\"]\ndata = [a,b,c,d,e]\nfits_extend(strExample, data, \"TABLE\")\n\nf = fits_read(strExample)\nf[2].dataobject.data\n  5-element Vector{String}:\n   \"1.0e-6 1086 1.23 a a                    \"\n   \"2.0e-6 1036 2.12 b bb                   \"\n   \"3.0e-6 1055 3.0  c ccc                  \"\n   \"4.0e-6 1070 4.0  d dddd                 \"\n   \"5.0e-6 1071 5.0  e ABCeeaeeEEEEEEEEEEEE \"\n\nrm(strExample); f = data = a = b = c = d = e = nothing\n\n\n\n\n\n","category":"function"},{"location":"#CamiXon.fits_copy","page":"Home","title":"CamiXon.fits_copy","text":"fits_copy(filenameA [, filenameB=\"\" [; protect=true]])\n\nCopy \"filenameA\" to \"filenameB\" (with mandatory \".fits\" extension) Key:\n\nprotect::Bool: overwrite protection\n\nExamples:\n\nfits_copy(\"T01.fits\")\n  'T01.fits' was saved as 'T01 - Copy.fits'\n\nfits_copy(\"T01.fits\", \"T01a.fits\")\n  filename (T01a.fits) in use (overwrite protected)\n\nfits_copy(\"T01.fits\", \"T01a.fits\"; protect=false)\n  'T01.fits' was saved as 'T01a.fits'\n\n\n\n\n\n","category":"function"},{"location":"#CamiXon.fits_add_key-Tuple{String, Int64, String, Real, String}","page":"Home","title":"CamiXon.fits_add_key","text":"fits_add_key(filename, hduindex, key, value, comment)\n\nAdd a header record of given 'key, value and comment' to 'HDU[hduindex]' of file with name 'filename'\n\nExample:\n\nstrExample=\"minimal.fits\"\nfits_create(strExample;protect=false)\nfits_add_key(strExample, 1, \"EXTEND2\", true, \"FITS dataset may contain extension\")\n\nf = fits_read(strExample)\np = fits_info(f[1])\nprintln(p)\n\n  File: minimal.fits\n  HDU: 1\n  DataType: Any\n  Datasize: (0,)\n\n  Metainformation:\n  SIMPLE  =                    T / file does conform to FITS standard\n  NAXIS   =                    0 / number of data axes\n  EXTEND  =                    T / FITS dataset may contain extensions\n  COMMENT    Basic FITS file     / http://fits.gsfc.nasa.gov/iaufwg\n  EXTEND2 =                    T / FITS dataset may contain extension\n  END\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_delete_key-Tuple{String, Int64, String}","page":"Home","title":"CamiXon.fits_delete_key","text":"fits_delete_key(filename, hduindex, key)\n\nDelete a header record of given key, value and comment to FITS_HDU[hduindex] of file with name  'filename'\n\nExamples:\n\nstrExample=\"minimal.fits\"\nfits_create(strExample;protect=false)\nfits_add_key(strExample, 1, \"EXTEND2\", true, \"comment to record 5\")\n\nf = fits_read(strExample)\ni = get(f[1].header.maps,\"EXTEND2\",0)\n  5\n\nfits_delete_key(strExample, 1, \"EXTEND2\")\n\nf = fits_read(strExample)\ni = get(f[1].header.maps,\"EXTEND2\",0)\n  0\n\nfits_delete_key(filnam, 1, \"NAXIS\")\n 'NAXIS': cannot be deleted (key protected under FITS standard)\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_edit_key-Tuple{String, Int64, String, Real, String}","page":"Home","title":"CamiXon.fits_edit_key","text":"fits_edit_key(filename, hduindex, key, value, comment)\n\nEdit a header record of given 'key, value and comment' to 'HDU[hduindex]' of file with name 'filename'\n\nExample:\n\n    strExample=\"minimal.fits\"\n    fits_create(strExample;protect=false)\n    fits_add_key(strExample, 1, \"EXTEND2\", true, \"FITS dataset may contain extension\")\n    fits_edit_key(strExample, 1, \"EXTEND2\", false, \"comment has changed\")\n\n    f = fits_read(strExample)\n    i = get(f[1].header.maps,\"EXTEND2\",0)\n    f[1].header.records[i]\n      \"EXTEND2 =                    F / comment has changed                            \"\n\n    rm(strExample)\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.fits_rename_key-Tuple{String, Int64, String, String}","page":"Home","title":"CamiXon.fits_rename_key","text":"fits_rename_key(filename, hduindex, keyold, keynew)\n\nRename the key of a header record of file with name 'filename'\n\nExample:\n\nstrExample=\"minimal.fits\"\nfits_create(strExample;protect=false)\nfits_add_key(strExample, 1, \"EXTEND2\", true, \"comment to record 5\")\n\nf = fits_read(strExample)\ni = get(f[1].header.maps,\"EXTEND2\",0)\n  5\n\nfits_rename_key(strExample, 1,\"EXTEND2\", \"EXTEND3\")\n\nf = fits_read(strExample)\ni = get(f[1].header.maps,\"EXTEND3\",0)\n  5\n\nrm(strExample)\n\n\n\n\n\n","category":"method"},{"location":"#FORTRAN","page":"Home","title":"FORTRAN","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"FORTRAN_format\ncast_FORTRAN_format(str::String)\ncast_FORTRAN_datatype(str::String)","category":"page"},{"location":"#CamiXon.FORTRAN_format","page":"Home","title":"CamiXon.FORTRAN_format","text":"FORTRAN_format\n\nObject to hold a FORTRAN format specifier decomposed into its fields. Accepted datatype specifiers are:  Aw,  Iw,  Fw.d,  Ew.d,  Dw.d.  Accepted output formating specifiers are: Aw,  Iw.m,  Bw.m,  Ow.m,  Zw.m,  Fw.d,  Ew.dEe,  ENw.d,  ESw.d,  Gw.dEe,  Dw.dEe. Notation: 'w' - width, 'm' (optional) - minimum number of digits, 'd' - number of digits to right of decimal,  'e' - number of digits in exponent; 'N'/'S' (optional) - switch for engineering/scientific formating of the 'E' type.\n\nThe fields are:\n\nType::String: primary FORTRAN datatype\nTypeChar::Char: primary FORTRAN datatype character\nEngSci::Union{Char,Nothing}: secundary datatype character (N for engineering, S for scientific)\nwidth::Int: width of numeric field\nnmin::Int: minimum number of digits displayed\nndec::Int: number of digits to right of decimal\nnexp::Int: number of digits in exponent\n\n\n\n\n\n","category":"type"},{"location":"#CamiXon.cast_FORTRAN_format-Tuple{String}","page":"Home","title":"CamiXon.cast_FORTRAN_format","text":"cast_FORTRAN_format(format::String)\n\nDecompose the format specifier 'format' into its fields and cast this into the FORTRAN_format object. Allowed format specifiers are of the types: Aw, Iw.m, Bw.m, Ow.m, Zw.m, Fw.d, Ew.dEe, ENw.d, ESw.d, Gw.dEe, Dw.dEe, with: 'w' - width, 'm' (optional) - minimum number of digits, 'd' - number of digits to right of decimal,  'e' - number of digits in exponent; 'N'/'S' (optional) - switch for engineering/scientific formating of the 'E' type.\n\nExamples:\n\nf = cast_FORTRAN_format(\"I10\")\nFORTRAN_format(\"Iw\", 'I', nothing, 10, 0, 0, 0)\n\nf = cast_FORTRAN_format(\"I10.12\")\nFORTRAN_format(\"Iw.m\", 'I', nothing, 10, 12, 0, 0)\n\nf = cast_FORTRAN_format(\"E10.5E3\")\nFORTRAN_format(\"Ew.dEe\", 'E', nothing, 10, 0, 5, 3)\n\nt.Type, t.TypeChar, t.EngSci, t.width, t.nmin, t.ndec, t.nexp\n(\"Ew.dEe\", 'E', nothing, 10, 0, 5, 3)\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.cast_FORTRAN_datatype-Tuple{String}","page":"Home","title":"CamiXon.cast_FORTRAN_datatype","text":"cast_FORTRAN_datatype(format::String)\n\nDecompose the format specifier 'format' into its fields and cast this into the FORTRAN_format object. Allowed format specifiers are of the types: Aw, Iw, Fw.d, Ew.d, Dw.d,  where: 'w' - width, 'd' - number of digits to right of decimal point.\n\nExamples:\n\nf = cast_FORTRAN_datatype(\"I10\")\nFORTRAN_format(\"Iw\", 'I', nothing, 10, 0, 0, 0)\n\nf = cast_FORTRAN_datatypet(\"F10.4\")\nFORTRAN_format(\"Fw.d\", 'F', nothing, 10, 0, 4, 0)\n\nf = cast_FORTRAN_datatype(\"E10.5\")\nFORTRAN_format(\"Ew.d\", 'E', nothing, 10, 0, 5, 0)\n\nt.Type, t.TypeChar, t.EngSci, t.width, t.nmin, t.ndec, t.nexp\n(\"Ew.d\", 'E', nothing, 10, 0, 5, 0)\n\n\n\n\n\n","category":"method"},{"location":"#Search-algorithms","page":"Home","title":"Search algorithms","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"find_all(A::Union{String,AbstractArray{T,1}}, a::T...; count=false)  where T\nfind_first(A::Union{String,AbstractArray{T,1}}, a::T...; dict=false)  where T\nfind_last(A::Union{String,AbstractArray{T,1}}, a::T...; dict=false)  where T","category":"page"},{"location":"#CamiXon.find_all-Union{Tuple{T}, Tuple{Union{AbstractVector{T}, String}, Vararg{T, N} where N}} where T","page":"Home","title":"CamiXon.find_all","text":"find_all(A [,a...]; count=false)\n\nA: string/array of elements of the same type\n\ndefault   : Array containing the index (indices) of selected elements of A (default: all elements)\n\ncount=true: The number of indices found for selected elements of A (default: all elements)\n\nExamples:\n\nA = [:📑,:📌,:📢,:📌,:📞]\nB = [1,2,3,2,5]\nstr = \"aβcβd\";\nfind_all(A) == find_all(B) == find_all(str)\ntrue\n\nfind_all(A,:📌)\n1-element Array{Array{Int64,1},1}:\n [2, 4]\n\nfind_all(str)\n4-element Array{Array{Int64,1},1}:\n [1]\n [2, 4]\n [3]\n [5]\n\nfind_all(A; count=true)\n4-element Array{Int64,1}:\n 1\n 2\n 1\n 1\n\nstr = \"📑📌📢📌📞\"\nfind_all(str,'📌')\n1-element Array{Array{Int64,1},1}:\n [2, 4]\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.find_first-Union{Tuple{T}, Tuple{Union{AbstractVector{T}, String}, Vararg{T, N} where N}} where T","page":"Home","title":"CamiXon.find_first","text":"find_first(A [,a...]; dict=false)\n\nThe first index of selected Array element\n\nA: string/array of elements of the same type\n\ndefault  : Array containing the first index (indices) of selected elements of A (default: all elements)\n\ndict=true: Dict for the first index (indices) of selected elements of A (default: all elements)\n\nExamples:\n\nA = [:📑,:📌,:📢,:📌,:📞]\nB = [1,2,3,2,5]\nstr = \"aβcβd\";\n\nfind_first(A) == find_first(B) == find_first(str)\ntrue\n\nfind_first(A,:📌)\n1-element Array{Array{Int64,1},1}:\n 2\n\nfind_last(A,:📌; dict=true)\n1-element Array{Pair{Symbol,Int64},1}:\n :📌 => 2\n\nfind_last(A; dict=true)\n4-element Array{Pair{Symbol,Int64},1}:\n :📑 => 1\n :📌 => 2\n :📢 => 3\n :📞 => 5\n\nfind_first(str)\n4-element Array{Int64,1}:\n 1\n 2\n 3\n 5\n\n\n\n\n\n","category":"method"},{"location":"#CamiXon.find_last-Union{Tuple{T}, Tuple{Union{AbstractVector{T}, String}, Vararg{T, N} where N}} where T","page":"Home","title":"CamiXon.find_last","text":"find_last(A [,a...]; dict=false)\n\nThe last index of selected Array element\n\nA: string/array of elements of the same type\n\ndefault  : Array containing the lasst index (indices) of selected elements of A (default: all elements)\n\ndict=true: Dict for the lasst index (indices) of selected elements of A (default: all elements)\n\nExamples:\n\nA = [:📑,:📌,:📢,:📌,:📞]\nB = [1,2,3,2,5]\nstr = \"aβcβd\";\nfind_last(A) == find_first(B) == find_first(str)\ntrue\n\nfind_last(A,:📌)\n1-element Array{Array{Int64,1},1}:\n 4\n\nfind_last(A,:📌; dict=true)\n1-element Array{Pair{Symbol,Int64},1}:\n :📌 => 4\n\nfind_last(A; dict=true)\n4-element Array{Pair{Symbol,Int64},1}:\n :📑 => 1\n :📌 => 4\n :📢 => 3\n :📞 => 5\n\nfind_last(str)\n4-element Array{Int64,1}:\n 1\n 4\n 3\n 5\n\n\n\n\n\n","category":"method"},{"location":"#Math","page":"Home","title":"Math","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"canonical_partitions(n::Int, m=0; header=true, reverse=true)\ninteger_partitions(n::Int, m=0; transpose=false, count=false)","category":"page"},{"location":"#CamiXon.canonical_partitions","page":"Home","title":"CamiXon.canonical_partitions","text":"canonical_partitions(n; header=false, reverse=true)\n\nThe canonical partition in integers of the integer n\n\nheader=true : unit patition included in output\n\nExamples:\n\ncanonical_partitions(6; header=true, reverse=false)\n6-element Array{Array{Int64,1},1}:\n [6]\n [5, 1]\n [4, 2]\n [3, 3]\n [2, 2, 2]\n [1, 1, 1, 1, 1, 1]\n\ncanonical_partitions(6; header=true)\n6-element Array{Array{Int64,1},1}:\n [1, 1, 1, 1, 1, 1]\n [2, 2, 2]\n [3, 3]\n [4, 2]\n [5, 1]\n [6]\n\ncanonical_partitions(6)\n5-element Array{Array{Int64,1},1}:\n [1, 1, 1, 1, 1, 1]\n [2, 2, 2]\n [3, 3]\n [4, 2]\n [5, 1]\n\n\n\n\n\n","category":"function"},{"location":"#CamiXon.integer_partitions","page":"Home","title":"CamiXon.integer_partitions","text":"integer_partitions(n [,m]; transpose=false, count=false)\n\ndefault              : The integer partitions of n\n\ncount=true           : The number of integer partitions of n\n\ntranspose=false/true : for m>0 restricted to partitions with maximum part/length m\n\ndefinitions:\n\nThe integer partition of the positive integer n is a nonincreasing sequence of positive integers p1, p2,... pk whose sum is n.\n\nThe elements of the sequence are called the parts of the partition.\n\nExamples:\n\ninteger_partitions(7)\n15-element Array{Array{Int64,1},1}:\n [1, 1, 1, 1, 1, 1, 1]\n [2, 2, 2, 1]\n [3, 3, 1]\n [4, 3]\n [5, 2]\n [6, 1]\n [7]\n [2, 2, 1, 1, 1]\n [3, 2, 2]\n [4, 2, 1]\n [5, 1, 1]\n [2, 1, 1, 1, 1, 1]\n [3, 2, 1, 1]\n [4, 1, 1, 1]\n [3, 1, 1, 1, 1]\n\ninteger_partitions(7; count=true)\n15\n\ninteger_partitions(7,4; count=true)\n3\n\ninteger_partitions(7,4)\n3-element Array{Array{Int64,1},1}:\n [4, 3]\n [4, 2, 1]\n [4, 1, 1, 1]\n\ninteger_partitions(7,4; transpose=true)\n3-element Array{Array{Int64,1},1}:\n [2, 2, 2, 1]\n [3, 2, 1, 1]\n [4, 1, 1, 1]\n\n\n\n\n\n","category":"function"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"}]
}
