# SPDX-License-Identifier: MIT

using CamiXon
using CamiDiff
using CamiMath

# using IntervalSets
#using BenchmarkTools
using LinearAlgebra
using Test

@testset "CamiXon.jl" begin  
    @test frac(-5 // 2) == "-⁵/₂"
    @test_throws DomainError castCodata(2016)
    codata = castCodata(2018)
    @test listCodata(codata; msg=false) == "∆νCs = 9192631770 Hz      - ¹³³Cs hyperfine transition frequency\n   c = 299792458 m s⁻¹    - speed of light in vacuum\n   h = 6.62607e-34 J Hz⁻¹ - Planck constant\n   ħ = 1.05457e-34 J s    - Planck constant (reduced)\n   e = 1.60218e-19 C      - elementary charge\n  kB = 1.38065e-23 J K⁻¹  - Boltzmann constant\n  NA = 6.02214e23 mol⁻¹   - Avogadro constant\n Kcd = 683 lm W⁻¹         - Luminous efficacy\n  mₑ = 9.10938e-31 kg     - electron mass\n  mₚ = 1.67262e-27 kg     - proton mass\n  R∞ = 1.09737e7 m⁻¹      - Rydberg constant\n  Ry = 3.28984e15 Hz      - Rydberg frequency\n  Eₕ = 4.35974e-18 J      - Hartree atomic unit\n   α = 0.00729735         - fine-structure constant\n  a0 = 5.29177e-11 m      - Bohr radius\n  μB = 9.27401e-24 J T⁻¹  - Bohr magneton\n  μN = 5.05078e-27 J T⁻¹  - nuclear magneton\n  μ₀ = 1.25664e-6 N A⁻²   - magnetic permitivity of vacuum\n  ε₀ = 8.85419e-12 F m⁻¹  - electric permitivity of vacuum\n  KJ = 4.83598e14 Hz V⁻¹  - Josephson constant\n  RK = 25812.8 Ω          - Von Klitzing constant\n   R = 8.31446 J mol⁻¹K⁻¹ - Molar gas constant\n   u = 1.66054e-27 kg     - unified atomic mass unit\n"
    codata = castCodata(2022)
    @test listCodata(codata; msg=false) == "∆νCs = 9192631770 Hz      - ¹³³Cs hyperfine transition frequency\n   c = 299792458 m s⁻¹    - speed of light in vacuum\n   h = 6.62607e-34 J Hz⁻¹ - Planck constant\n   ħ = 1.05457e-34 J s    - Planck constant (reduced)\n   e = 1.60218e-19 C      - elementary charge\n  kB = 1.38065e-23 J K⁻¹  - Boltzmann constant\n  NA = 6.02214e23 mol⁻¹   - Avogadro constant\n Kcd = 683 lm W⁻¹         - Luminous efficacy\n  mₑ = 9.10938e-31 kg     - electron mass\n  mₚ = 1.67262e-27 kg     - proton mass\n  R∞ = 1.09737e7 m⁻¹      - Rydberg constant\n  Ry = 3.28984e15 Hz      - Rydberg frequency\n  Eₕ = 4.35974e-18 J      - Hartree atomic unit\n   α = 0.00729735         - fine-structure constant\n  a0 = 5.29177e-11 m      - Bohr radius\n  μB = 9.27401e-24 J T⁻¹  - Bohr magneton\n  μN = 5.05078e-27 J T⁻¹  - nuclear magneton\n  μ₀ = 1.25664e-6 N A⁻²   - magnetic permitivity of vacuum\n  ε₀ = 8.85419e-12 F m⁻¹  - electric permitivity of vacuum\n  KJ = 4.83598e14 Hz V⁻¹  - Josephson constant\n  RK = 25812.8 Ω          - Von Klitzing constant\n   R = 8.31446 J mol⁻¹K⁻¹ - Molar gas constant\n   u = 1.66054e-27 kg     - unified atomic mass unit\n"
    @test convertUnit(1, codata; unitIn="Hz", unitOut="J") == Value(6.62607015e-34, "J")
    @test convertUnit(1, codata) == Value(6.579683920499964, "PHz")
    @test strValue(Value(1, "Hz")) == "1 Hz"
    @test castNamedValue(Value(1.602176634e-19, "C"); name="e") == NamedValue(Value(1.602176634e-19, "C"), "e", " ")
    @test calibrationReport(1.1, 1.0, codata; unitIn="Hartree", msg=false) == "\ncalibration report (Float64):\nEcal = 1 Hartree \nE = 1.1000000000000001 Hartree \nabsolute accuracy: ΔE = 0.1 Hartree (657.968 THz)\nrelative accuracy: ΔE/E = 0.0909091\n"
    @test bohrformula(2, 4) == -1 // 8
    @test get(dictAtomicNumbers, "Rb", nothing) == 37
    @test get(dictElements, 37, nothing) == ("rubidium", "Rb", 85.468)
    @test castElement(Z=1, msg=false) == Element("hydrogen", "H", 1.008)
    @test castElement("Rb"; msg=false) == castElement(Z=37, msg=false)
    @test listElement("H") == listElement(1)
    @test listElement(1; fmt=String) == "H, hydrogen, Z=1, weight=1.008"
    @test listElement(1; fmt=Info, msg=false) == "Element: hydrogen\n  symbol: H\n  atomic number: Z = 1\n  atomic weight (relative atomic mass): 1.008"
    @test listElements(1, 3) == listElements(1:3)
    @test listElements(1:2; fmt=String) == ["H, hydrogen, Z=1, weight=1.008", "He, helium, Z=2, weight=4.0026"]
    @test castIsotope(Z=1, A=1, msg=false) == Isotope("¹H", "hydrogen", 1, 1, 0, 0.8783, 1.007825032, 1 // 2, 1, 1.0e100, 2.792847351, 0.0, 99.9855)
    @test castIsotope("Rb"; A=87, msg=false) == castIsotope(Z=37, A=87, msg=false)
    @test_throws DomainError listIsotope(1,3; fmt=1, msg=false)
    @test listIsotope(2, 3; fmt=Latex) == "2 & helium & \$^{3}\$He & 3\\, & 1 & 1.9661 & 3.016029322 & 1/2\$^+\$ & -2.12762531 & 0.0 & 0.0002 \\\\\n"
    @test listIsotope(2, 3; fmt=String) == "³He, helium, Z=2, A=3, N=1, R=1.9661, M=3.016029322, I=1/2⁺, μI=-2.12762531, Q=0.0, RA=0.0002%, (stable)"
    @test listIsotope(1,3; fmt=Info, msg=false) == "Isotope: tritium-3\n  symbol: ³T\n  element: tritium\n  atomic number: Z = 1\n  atomic mass number: A = 3\n  neutron number: N = 2\n  rms nuclear charge radius: R = 1.7591 fm\n  atomic mass: M = 3.016049281 amu\n  nuclear spin: I = 1/2 ħ\n  parity of nuclear state: π = even\n  nuclear magnetic dipole moment: μI = 2.97896246 μN\n  nuclear electric quadrupole moment: Q = 0.0 barn\n  relative abundance: RA = trace\n  lifetime: 12.33 years"
    @test listIsotopes(1,3) == listIsotopes(1:3)
    @test_throws DomainError listAtom(1,3,0; fmt=Latex)
    @test listAtom("H", 3, 0) == listAtom(1, 3, 0)
    @test listAtom(1, 3, 1; fmt=String) == "tritium ion, ³Tᐩ, Z=1, A=3, Q=1, Zc=2"
    @test listAtom(1, 3, 1; fmt=Info, msg=false) == "Atom: tritium ion\n  symbol: ³Tᐩ\n  atomic charge: Z = 1\n  Rydberg charge: Zc = 2"
    @test listAtoms(2:2, 0; fmt=String) == ["helium, neutral atom, ³He, Z=2, A=3, Q=0, Zc=1", "helium, neutral atom, ⁴He, Z=2, A=4, Q=0, Zc=1"]
    @test castAtom("Rb"; A=87, Q=0, msg=false) == castAtom(Z=37, A=87, Q=0, msg=false)
#   ---------------------------------------------------------------------------------
    @test castAtom(Z=1, A=1, Q=0, msg=true) == Atom(1, 1, 0, 1, Element("hydrogen", "H", 1.008), Isotope("¹H", "hydrogen", 1, 1, 0, 0.8783, 1.007825032, 1 // 2, 1, 1.0e100, 2.792847351, 0.0, 99.9855))
    @test castOrbit(n=2, ℓ=0; msg=true) == Orbit("2s", 2, 1, 0, 0)
    @test castSpinorbit(n=1, ℓ=0, msg=true) == Spinorbit("1s↑", Orbit("1s", 1, 0, 0, 0), 1//2)
    @test castTerm(1; ℓ=0, S=1 // 2, L=0, J=1 // 2, msg=true) == Term("1s ²S₁⸝₂", 1, 0, 0, 1 // 2, 0, 1 // 2)

    atom = castAtom(Z=1, A=1, Q=0);
    orbit = castOrbit(n=2, ℓ=0);
    grid = autoGrid(atom, orbit, Float64; Ntot=5000, msg=true);
    castDef(grid, atom, orbit, codata, msg=true);
#   ---------------------------------------------------------------------------------
    @test lc_eltype(([1 // 2, 1 // 3]; (1 // 4, 1 // 1, 1 // 6))) == Rational{Int}
    @test lc_eltype(([1//2, 1//3]; (1//4, big(1)//big(5), 1//6))) == Rational
    @test lc_primitivetype(([1 // 2, 1 // 3]; (1 // 4, 1 // 1, 1 // 6))) == Int64
    @test primitivetype(Rational{UInt16}) == UInt16
    @test conditionalType(47, 46) == BigInt  
    @test typeof(bigconvert([[1 // 1, 1 // 2], [1 // 1, 1 // 2]])) == Vector{Vector{Rational{BigInt}}}
#   ---------------------------------------------------------------------------------------- 
    atom = castAtom(Z=1, A=1, Q=0)
    orbit = castOrbit(n=10, ℓ=6)
    grid = autoGrid(atom, orbit, Float64; Ntot=5000);
    def = castDef(grid, atom, orbit, codata)
    Ecal = convert(grid.T, bohrformula(atom.Z, orbit.n))
    E = 0 
    scr = zeros(grid.T,grid.N)
    def, Z = test_adams_moulton(E, scr, grid, def; test=1, msg=false)
    @test real(Z[1:9]) ≈  [0.0, 5.1428402317309706e-27, 1.8358054664173181e-25, 1.4545109486041696e-24, 6.312941767665052e-24, 1.9727333231630704e-23, 5.008945116783607e-23, 1.1021150943733992e-22, 2.1836812980487107e-22]
    def, Z = test_adams_moulton(E, scr, grid, def; test=2, msg=false)
    @test real(Z[1:9]) ≈ [0.0, 1.316529120127285e-36, 4.699526422219377e-35, 3.7234406147142423e-34, 1.6160664722811144e-33, 5.050051623547137e-33, 1.282252959498499e-32, 3.182655514351617e-32, 8.201804186634829e-32]
    def, Z = test_adams_moulton(E, scr, grid, def; test=3, msg=false)
    @test real(Z[1:9]) ≈ [0.0, 1.316529120127285e-36, 4.699526422219377e-35, 3.7234406147142423e-34, 1.6160664722811144e-33, 5.050051623547137e-33, 1.282252959498499e-32, 3.182655514351617e-32, 8.201804186634829e-32]
    def, Z = test_adams_moulton(E, scr, grid, def; test=4, msg=false)
    @test real(Z[1:9]) ≈ [0.0, 1.316529120127285e-36, 4.699526422219377e-35, 3.7234406147142423e-34, 1.6160664722811144e-33, 5.050051623547137e-33, 1.282252959498499e-32, 3.182655514351617e-32, 8.201804186634829e-32]
    def, Z = test_adams_moulton(E, scr, grid, def; test=5, msg=false)
    @test real(Z[1:9]) ≈ [0.0, 2.303207641828953e-37, 8.221607105497416e-36, 6.513989509686655e-35, 2.8272345759443254e-34, 8.834834955917978e-34, 2.2432430623252777e-33, 5.567910644661615e-33, 1.434868229698988e-32]
#   ----------------------------------------------------------------------------------------
    atom = castAtom(Z=1, A=1, Q=0; msg=false);
    orbit = castOrbit(n=2, ℓ=0; msg=false);
    grid = autoGrid(atom, orbit, Float64; Ntot=5000);
    RH2s_example = [RH2s(atom.Z, grid.r[n]) for n=1:grid.N];
    ZH2s_example = reduce_wavefunction(RH2s_example, grid);
    ZH2s_generic = hydrogenic_reduced_wavefunction(atom, orbit, grid);
    @test ZH2s_example ≈ ZH2s_generic 
    RH2s_generic = restore_wavefunction(ZH2s_generic, atom, orbit, grid);  
    @test RH2s_example ≈ RH2s_generic
#   ---------------------------------------------------------------------------------------- 
    atom = castAtom(Z=1, A=1, Q=0; msg=false);
    orbit = castOrbit(n=10, ℓ=6; msg=false);
    grid = autoGrid(atom, orbit, Float64; Ntot=5000);
    ZH10i_generic = hydrogenic_reduced_wavefunction(atom, orbit, grid);
    E=0;
    scr = zeros(grid.T, grid.N);
    def = castDef(grid, atom, orbit, codata);
    def, adams, init, Z = adams_moulton_nodes(E, scr, grid, def; imax=25, msg=true);
    def, adams, init, Z = adams_moulton_iterate!(Z, init, grid, def, adams; imax=25, ϵ=1e-15, msg=false);
    @test ZH10i_generic ≈ Z 
#   ---------------------------------------------------------------------------------------- 
    atom = castAtom(Z=1, A=1, Q=0; msg=false);
    orbit = castOrbit(n=2, ℓ=1; msg=false);
    grid = autoGrid(atom, orbit, Float64; Ntot=5000);
    RH2p_example = [RH2p(atom.Z, grid.r[n]) for n=1:grid.N];
    ZH2p_example = reduce_wavefunction(RH2p_example, grid);
    ZH2p_generic = hydrogenic_reduced_wavefunction(atom, orbit, grid);
    @test ZH2p_example ≈ ZH2p_generic 
    RH2p_generic = restore_wavefunction(ZH2p_generic, atom, orbit, grid);  
    @test RH2p_example ≈ RH2p_generic 
    E=0;
    scr = zeros(grid.T, grid.N);
    def = castDef(grid, atom, orbit, codata);
    def, adams, init, Z = adams_moulton_nodes(E, scr, grid, def; imax=25, msg=true);
    def, adams, init, Z = adams_moulton_iterate!(Z, init, grid, def, adams; imax=25, ϵ=1e-15, msg=false);
    @test ZH2p_generic ≈ Z
#   ---------------------------------------------------------------------------------------- 
    atom = castAtom(Z=1, A=1, Q=0; msg=false);
    orbit = castOrbit(n=1, ℓ=0; msg=false);
    grid = autoGrid(atom, orbit, Float64; Ntot=5000);
    RH1s_example = [RH1s(atom.Z, grid.r[n]) for n=1:grid.N];
    ZH1s_example = reduce_wavefunction(RH1s_example, grid);
    ZH1s_generic = hydrogenic_reduced_wavefunction(atom, orbit, grid);
    @test ZH1s_example ≈ ZH1s_generic 
    RH1s_generic = restore_wavefunction(ZH1s_generic, atom, orbit, grid);  
    @test RH1s_example ≈ RH1s_generic 
    E=0;
    scr = zeros(grid.T, grid.N);
    def = castDef(grid, atom, orbit, codata);
    def, adams, init, Z = adams_moulton_nodes(E, scr, grid, def; imax=25, msg=true);
    def, adams, init, Z = adams_moulton_iterate!(Z, init, grid, def, adams; imax=5, ϵ=1e-15, msg=false);
    def, adams, init, Z = adams_moulton_iterate!(Z, init, grid, def, adams; imax=25, ϵ=1e-15, msg=false);
    @test ZH1s_generic ≈ Z

 #   println("nu komt het!")
 #   grid, def, adams, init, Z = adams_moulton_precise!(Z, init, grid, def; imax=5, ϵ=1e-20, msg=true);
 #   @test ZH1s_generic ≈ Z
 #   @test grid.name == "exponential"
 #   @test findIndex(0.0042, grid) == 220
 #   @test def.atom.element.name == "hydrogen"
 #   @test CamiDiff.grid_integration(real(ZH1s_generic) .^ 2, grid, 1, grid.N) ≈ 1.0
 #   @test round(Int, UF(0, real(Z), grid)[1]) == 1
 #   grid, def, adams, init, Z = adams_moulton_precise!(Z, init, grid, def; imax=5, ϵ=1e-20, msg=true);
 #   @test ZH1s_generic ≈ Z
#   ---------------------------------------------------------------------------------------- 
    #Z1 = hydrogenic_reduced_wavefunction(1, orbit, grid);
    #P = real(Z)
    #val = UF(0, P, grid)[1];
    #   ----------------------------------------------------------------------------------------    
    f = [-exp(-x^2) for x=-1.0:0.01:1.0];
    f0 = -0.606530659712633;
    @test getNmin(f, 1:201) == 101
    @test getNmax(f, 1:201) == 201
    @test getNcut(f0, f, 1:101) == 30
    @test getNcut(f0, f, 101:201) == 172
    @test_throws DomainError getNcut(1.0, f, 1:201)
    Nlcut = getNcut(f0, f, 1, 101);
    Nucut = getNcut(f0, f, 101, 201);
    @test 0.01*(30.0-101.0+getΔNcut(f0, f, Nlcut, fwd; ϵ = 1e-6, k=7)) ≈ -sqrt(1//2)
    @test 0.01*(172.0-101.0+getΔNcut(f0, f, Nucut, bwd; ϵ = 1.0e-6, k=7)) ≈ sqrt(1//2) 
    ΔNlcut = getΔNcut(f0, f, Nlcut, fwd; ϵ = 1e-6, k=7)
    ΔNucut = getΔNcut(f0, f, Nucut, bwd; ϵ = 1e-6, k=7)
    polynomfwd = lagrange_polynom(f, Nlcut, Nlcut+7, fwd)
    polynombwd = lagrange_polynom(f, Nucut-7, Nucut, bwd)
    @test CamiMath.polynomial(polynomfwd, ΔNlcut) ≈ f0
    @test CamiMath.polynomial(polynombwd, ΔNucut) ≈ f0
    #   ----------------------------------------------------------------------------------------    
  
    @test find_all([:📑, :📌, :📢, :📌, :📞]) == [[1], [2, 4], [3], [5]]
    @test find_all([:📑, :📌, :📢, :📌, :📞]; count=true) == [1, 2, 1, 1]
    @test find_all([:📑, :📌, :📢, :📌, :📞], :📌) == [[2, 4]]
    @test find_all([:📑, :📌, :📢, :📌, :📞], :📌; count=true) == [2]
    @test find_all("aβcβd") == [[1], [2, 4], [3], [5]]
    @test find_all("aβcβd"; count=true) == [1, 2, 1, 1]
    @test find_all("aβcβd", 'β') == [[2, 4]]
    @test find_all("aβcβd", 'β'; count=true) == [2]
    @test find_first([:📑, :📌, :📢, :📌, :📞]) == [1, 2, 3, 5]
    @test find_first([:📑, :📌, :📢, :📌, :📞]; dict=true) == [:📑 => 1, :📌 => 2, :📢 => 3, :📞 => 5]
    @test find_first([:📑, :📌, :📢, :📌, :📞], :📌) == [2]
    @test find_first([:📑, :📌, :📢, :📌, :📞], :📌; dict=true) == [:📌 => 2]
    @test find_first([:📑, :📌, :📢, :📌, :📞]) == find_first([1, 2, 3, 2, 5]) == find_first("aβcβd")
    @test find_last([:📑, :📌, :📢, :📌, :📞]) == [1, 4, 3, 5]
    @test find_last([:📑, :📌, :📢, :📌, :📞]; dict=true) == [:📑 => 1, :📌 => 4, :📢 => 3, :📞 => 5]
    @test find_last([:📑, :📌, :📢, :📌, :📞], :📌) == [4]
    @test find_last([:📑, :📌, :📢, :📌, :📞], :📌; dict=true) == [:📌 => 4]
    @test find_last([:📑, :📌, :📢, :📌, :📞]) == find_last([1, 2, 3, 2, 5]) == find_last("aβcβd")
    @test [fdiff_weight(5, j) for j = 0:5] == [1, -5, 10, -10, 5, -1]
    #@test isforward(fwd) == true
    #@test isregular(reg) == true
    @test a_direct(2, 1, 1, 2, 2) == 2 // 35
    @test b_exchange(1, 1, 1, 2, 2) == 2 // 5
    @test a_direct(6, 3, 2, 3, -1) == -250 // 20449
    @test b_exchange(6, 3, 2, 3, -1) == 1050 // 20449

    grid = CamiDiff.castGrid(3, 6, Float64; r0=1.0, h=1.0, msg=false)
    @test autoRmax(atom, orbit) == 84.0 #63.0
    @test autoNtot(orbit, 2) == 240
    @test autoPrecision(100.0, orbit) == Float64
    @test autoSteps(1, 100, 100) ==  (0.10101010101010101, 0.004540199100968777)
#   ------------------------------------------------------------------------------------------------------------
    @test latent_heat_vaporization("Yb", 763) == 24170.448513975916
    @test latent_heat_vaporization("Li", 623) == 18473.64020109123
    @test latent_heat_vaporization("Li", 400) == 19134.482122780522
    @test_throws DomainError latent_heat_vaporization(1, 100)
    @test svp("Yb", 763) == 2.2859295292626745
    @test svp("Li", 623) == 0.0015230367024569058
    @test svp("Li", 400) == 7.901690229445235e-11
    @test_throws DomainError svp("H", 400)
    @test melting_point("Li") == 453.65
    @test latexIsotopeTable(1:10) == latexIsotopeTable(1,10)
    @test latexIsotopeTable(11:22; continuation=true) == latexIsotopeTable(11,22; continuation=true) 
    @test silvera_goldman_triplet(10) == -7.71843646003074e-6
    @test silvera_goldman_singlet(10) == -8.696045600341206e-6
    @test silvera_goldman_exchange(10) == 9.776091403104656e-7
    grid = CamiDiff.castGrid(3,2000,Float64; h=0.01, r0=1, msg=false);    
    @test silvera_goldman_potential(grid; S=1)[700] == -1.2954953056510744e-6
    @test silvera_goldman_potential(grid; S=0)[700] == -0.00020738292434731114
    @test rotbarrier(grid; ℓ=0)[700] == 0.0
    @test rotbarrier(grid; ℓ=1)[700] == 0.040933194979134294

end
