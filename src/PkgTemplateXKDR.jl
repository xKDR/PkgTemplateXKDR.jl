module PkgTemplateXKDR

export getPackageTemplate

using PkgTemplates
include("./DocumenterCI.jl")

function getPackageTemplate(; authorList::Vector{String}=["xKDR"], packagePath::String="~/")
    assets_path_len = length(pathof(PkgTemplateXKDR))
    assets_path = pathof(PkgTemplateXKDR)[1:(assets_path_len - length("PkgTemplateXKDR.jl"))]

    return Template(;
        user="xKDR",
        authors=authorList,
        host="github.com",
        julia=v"1.0.0",
        dir=packagePath,
        plugins=[
            Tests(;
                project=true
            ),
            License(;
                name="MIT", 
                destination="LICENSE"
            ),
            Git(;
                ignore=[
                    "*.jl.*.cov",
                    "*.jl.cov",
                    "*.jl.mem",
                    "/Manifest.toml",
                    "/docs/Manifest.toml",
                    "/docs/build/",
                    "/test/Manifest.toml"
                ],
                ssh=true,
            ),
            Readme(;
                file=joinpath(assets_path, "readme", "README.md"),
                destination="README.md"
            ),
            GitHubActions(;                         # For adding CI
                file=joinpath(assets_path, "ci", "ci.yml"),
                destination="ci.yml",
                linux=false,
                x64=false,
                coverage=false,
                extra_versions=[]
            ),
            Documenter{GitHubActions}(;             # For adding Documentation
                make_jl=joinpath(assets_path, "docs", "make.jl"),
                index_md=joinpath(assets_path, "docs", "src", "index.md"),
                assets=String[]
            ),
            DocumenterCI(;
                documentation_yml=joinpath(assets_path, "ci", "documentation.yml")
            )
        ]
    )
end

end
