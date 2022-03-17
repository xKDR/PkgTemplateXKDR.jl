using PkgTemplateXKDR
using Documenter

DocMeta.setdocmeta!(PkgTemplateXKDR, :DocTestSetup, :(using PkgTemplateXKDR); recursive=true)

makedocs(;
    modules=[PkgTemplateXKDR],
    authors="xKDR Forum",
    repo="https://github.com/xKDR/PkgTemplateXKDR.jl/blob/{commit}{path}#{line}",
    sitename="$PkgTemplateXKDR.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://xKDR.github.io/PkgTemplateXKDR.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/xKDR/PkgTemplateXKDR.jl",
    target = "build",
    devbranch="main"
)
