using {{PKG}}
using Documenter

DocMeta.setdocmeta!({{PKG}}, :DocTestSetup, :(using {{PKG}}); recursive=true)

makedocs(;
    modules=[{{PKG}}],
    authors="xKDR Forum",
    repo="https://github.com/xKDR/{{PKG}}.jl/blob/{commit}{path}#{line}",
    sitename="${{PKG}}.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://xKDR.github.io/{{PKG}}.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/xKDR/{{PKG}}.jl",
    target = "build",
    devbranch="main"
)