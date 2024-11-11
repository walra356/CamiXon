module CamiXon

import CamiMath

fwd = CamiMath.fwd
bwd = CamiMath.bwd
reg = CamiMath.reg
rev = CamiMath.rev

using Printf
using Dates           # used in fits_private_sector
#using IntervalSets
#using LaTeXStrings
using LinearAlgebra

export sup
export sub
export frac
export strRational

#export fwd
#export bwd
#export reg
#export rev
#export isforward
#export isregular
export Object
export Info
export Latex

export primitivetype
export lc_primitivetype
export lc_eltype
export conditionalType
export bigconvert
export find_all
export find_first
export find_last

export convertUnit
export Value
export strValue
export NamedValue
export castNamedValue
export Codata
export castCodata
export listCodata
export calibrationReport

export dictAntoineCoefficients
export dictAtomicNumbers
export dictBigConversion
export dictElements
export dictIsotopes
export dictMeltingPoints

export bohrformula
export Element
export listElement
export listElements
export castElement
export Isotope
export listIsotope
export listIsotopes
export castIsotope
export latexIsotopeTable
export Atom
export listAtom
export listAtoms
export castAtom
export Orbit
export castOrbit
export Spinorbit
export castSpinorbit
export Term
export createTerm
export a_direct
export b_exchange
export UF
export UG

export svp
export latent_heat_vaporization
export melting_point

export fdiff_weight
export fdiff_expansion_weights
export fdiff_expansion
export fwd_diff_expansion_weights
export fdiff_interpolation_expansion_coeffs
export fdiff_interpolation
export fdiff_differentiation_expansion_coeffs
export fdiff_differentiation
export create_lagrange_differentiation_matrix
export fdiff_adams_moulton_expansion_coeff
export fdiff_adams_moulton_expansion_coeffs
export create_adams_moulton_weights
export fdiff_adams_bashford_expansion_coeff
export fdiff_adams_bashford_expansion_coeffs
export create_adams_bashford_weights
export trapezoidal_epw
export trapezoidal_integration

export Init
export castInit
export init!

export matG
export matσ 
export matMinv
export OUTSCH!
export OUTSCH_WKB!
export OUTSCH_WJ!
export Adams
export castAdams
export updateAdams!
export INSCH!
export INSCH_WKB!
export INSCH_WJ!
export adams_moulton_outward!
export adams_moulton_inward!
export adams_moulton_normalized!
export adams_moulton_patch
export adams_moulton_solve!
export adams_moulton_solve_refine!
export adams_moulton_nodes
export adams_moulton_iterate!
export adams_moulton_precise!
export adams_moulton_report

export demo_hydrogen
export hydrogenic_reduced_wavefunction
export RH1s
export RH2s
export RH2p
export silvera_goldman_triplet
export silvera_goldman_singlet
export silvera_goldman_exchange
export silvera_goldman_potential
export rotbarrier
export restore_wavefunction
export reduce_wavefunction

export Grid
export gridname
export gridfunction
export castGrid
export findIndex
export autoRmax
export autoNtot
export autoPrecision
export autoSteps
export autoGrid
export grid_differentiation # kanweg --------------------------------------
export grid_differentiation1 # new --------------------------------------
export grid_integration


export getNmin
export getNmax
export getNcut
export getΔNcut

export getΔNuctp

export Pos
export castPos
export updatePos!
export Def
export castDef
export initE

#export plot_matrices
#export plot!
export step125
export select125
export edges
export steps
export stepcenters
export stepedges
#export centerticks
#export edgeticks
#export centers
#export edges

include("singleton.jl")
include("julia.jl")
include("codata.jl")
include("dicts.jl")
include("strings.jl")
include("latex.jl")
include("finite_differences.jl")
include("finite_difference_adams.jl")
include("element.jl")
include("isotope.jl")
include("atom.jl")
include("orbit.jl")
include("thermal-properties.jl")
include("grid.jl")
include("grid_autoset.jl")
include("pos.jl")
include("def.jl")
include("init.jl")
include("hydrogen.jl")
include("adams.jl")
include("outsch.jl")
include("insch.jl")
include("Coulomb_Integrals.jl")
include("adams-moulton.jl")
include("plot_public_sector.jl")

end
