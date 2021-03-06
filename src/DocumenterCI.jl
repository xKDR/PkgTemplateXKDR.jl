# Custom plugin for Documentation workflow
struct DocumenterCI <: PkgTemplates.FilePlugin
    documentation_yml::String

    # Default constructor; don't use this
    DocumenterCI(documentation_yml::AbstractString) = new(documentation_yml)
end

# Construtor with kwargs; use this. Don't use the default value
DocumenterCI(; documentation_yml::AbstractString = "") = DocumenterCI(documentation_yml)

# Specifying source template and destination
PkgTemplates.source(p::DocumenterCI) = p.documentation_yml
PkgTemplates.destination(::DocumenterCI) = "./.github/workflows/documentation.yml"

# view definition
PkgTemplates.view(::DocumenterCI, ::Template, ::AbstractString) = Dict(
    "secrets.GITHUB_TOKEN" => "{{ secrets.GITHUB_TOKEN }}",
    "secrets.DOCUMENTER_KEY" => "{{ secrets.DOCUMENTER_KEY }}"
)