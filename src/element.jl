# ======================== Element(name, symbol, weight) =======================

"""
    Element(name, symbol, weight)

Type with fields:
* `  .name`:  name of element (`::String`)
* `.symbol`:  symbol of element  (`::String`)
* `.weight`:  relative atomic mass - atomic weight (`::Float64`)

The type `Element` is best created with the function [`castElement`](@ref).
"""
struct Element           # elemental properties
    name::String         # ionic charge (a.u.)
    symbol::String       # nuclear mass (amu)
    weight::Union{Float64, Nothing}      # relative atomic mass (atomic weight)
end
# ================================ End =========================================

# =========== castElement(name, symbol, weight) ================================

#...............................................................................
function _stdElement(Z::Int)

    dict = dictElements
    element = (Z) ∈ keys(dict) ? castElement(;Z, msg=false) : return nothing

    return element

end
#...............................................................................
function _strElement(Z::Int)

    dict = dictElements
    element = (Z) ∈ keys(dict) ? castElement(;Z, msg=false) : return nothing

    str = element.symbol
    str *= ", " * element.name
    str *= ", Z=$Z"
    str *= ", weight=" * repr(element.weight)

    return str

end
#...............................................................................
function _infoElement(Z::Int)

    dict = dictElements
    element = (Z) ∈ keys(dict) ? castElement(; Z, msg=false) : return nothing

    str = "Element: " * element.name
    str *= "\n    symbol: " * element.symbol
    str *= "\n    element: " * element.name
    str *= "\n    atomic number: Z = $Z"
    str *= "\n    atomic weight (relative atomic mass): " * repr(element.weight)

    return println(str)

end
#...............................................................................
"""
    listElement(Z::Int; format=Object)

Properties of element with atomic number `Z`.

Output options: `Object` (default), `String`, `Info`.
#### Example:
```
listElement(1; format=Info)
Element: hydrogen
    symbol: H
    element: tritium
    atomic number: Z = 1
    atomic weight (relative atomic mass): 1.008
```
"""
function listElement(Z::Int; format=Object)

    format === Object && return _stdElement(Z, A, Q)
    format === String && return _strElement(Z)
    format === Info && return _infoElement(Z)

    return error("Error: invalid output type")

end
#...............................................................................
"""
#### Example
```
listElements(1,3) == listElements(1:3)
  true

listElements(1:3; format=Info)
  Element: hydrogen
    symbol: H
    name: hydrogen
    atomic number: Z = 1
    atomic weight (relative atomic mass): 1.008
  Element: helium
    symbol: He
    name: helium
    atomic number: Z = 2
    atomic weight (relative atomic mass): 4.0026
  Element: lithium
    symbol: Li
    name: lithium
    atomic number: Z = 3
    atomic weight (relative atomic mass): 6.94
```
"""
function listElements(Z1::Int, Z2::Int; format=Object)

    o = []

    for Z=Z1:Z2
        next = listElement(Z; format)
        isnothing(next) ? false : push!(o, next)
    end

    return o

end
function listElements(itrZ; format=Object)

    return listElements(itrZ.start,itrZ.stop; format)

end
# ------------------------------------------------------------------------------
"""
    castElement(;Z=1, msg=true)

Create Atom with fields
* `  .name`:  name of element
* `.symbol`:  symbol of element
* `.weight`:  relative atomic mass (atomic weight)
#### Example:
```
castElement(;Z=1, msg=true)
  Element created: hydrogen
    symbol: H
    atomic number (Z): 1
    atomic weight (relative atomic mass): 1.008 amu

  Element("hydrogen", "H", 1.008)
```
"""
function castElement(;Z=1, msg=true)

    element = Z ∈ keys(dictElements) ? get(dictElements, Z, nothing) :
              error("Error: element Z = $Z not present in `dictElements`")

    (name, symbol, weight) = element

    msg && println("Element created: " * listElement(Z; format=String) )

    return Element(name, symbol, weight)

end
# ================================ End =========================================
