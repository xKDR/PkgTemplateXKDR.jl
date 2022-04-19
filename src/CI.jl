# Custom plugin for Documentation workflow
struct CI <: PkgTemplates.FilePlugin
    ci_yml::String

    # Default constructor; don't use this
    CI(ci_yml::AbstractString) = new(ci_yml)
end

# Construtor with kwargs; use this. Don't use the default value
CI(; ci_yml::AbstractString = "") = CI(ci_yml)

# Specifying source template and destination
PkgTemplates.source(p::CI) = p.ci_yml
PkgTemplates.destination(::CI) = "./.github/workflows/ci.yml"

# view definition
PkgTemplates.view(::CI, ::Template, pkg::AbstractString) = Dict(
    "PKG" => pkg
)