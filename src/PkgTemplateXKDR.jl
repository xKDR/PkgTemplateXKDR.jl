module PkgTemplateXKDR

export getPackageTemplate

using PkgTemplates
include("./DocumenterCI.jl")

function getPackageTemplate(; authorList::Vector{String}=["xKDR"], packagePath::String="~/")
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
                file="./readme/README.md",
                destination="README.md"
            ),
            GitHubActions(;                         # For adding CI
                file="./ci/ci.yml",
                destination="ci.yml",
                linux=false,
                x64=false,
                coverage=false,
                extra_versions=[]
            ),
            Documenter{GitHubActions}(;             # For adding Documentation
                make_jl="./docs/make.jl",
                index_md="./docs/src/index.md",
                assets=String[]
            ),
            DocumenterCI(;
                documentation_yml="./ci/documentation.yml"
            )
        ]
    )
end

end
