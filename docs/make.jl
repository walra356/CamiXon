using CamiXon

using Documenter

makedocs(;
    modules=[CamiXon],
    authors="= <walra356@planet.nl> and contributors",
    #repo="https://github.com/walra356/CamiXon.jl/blob/{commit}{path}#L{line}",
    sitename="CamiXon.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        size_threshold_warn = 200000,
        size_threshold = 300000,
        canonical="https://walra356.github.io/CamiXon.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)


deploydocs(;
    repo="github.com/walra356/CamiXon.jl",
    devbranch = "main"
)
