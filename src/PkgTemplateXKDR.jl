module PkgTemplateXKDR

export getPackageTemplate

using PkgTemplates
include("./DocumenterCI.jl")

"""
```julia
getPackageTemplate(; authorList=["xKDR"], packagePath="~/")
```

Return a [`Template`](https://invenia.github.io/PkgTemplates.jl/stable/user/#Template-1) object which will be used to create package templates.

# Arguments 
- `authorList::Vector{String}`: A list of authors of the package. 
- `packagePath::String`: Path where the package template is intended to be set up.

# Return value 
- An object of type [`PkgTemplates.Template`](https://invenia.github.io/PkgTemplates.jl/stable/user/#Template-1).

# Example 
```julia
using PkgTemplateXKDR
template = getPackageTemplate(authorList=["author1", "author2"], packagePath="./")
template("MyPackage.jl")   # sets up the package in the current working directory
```
"""
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
