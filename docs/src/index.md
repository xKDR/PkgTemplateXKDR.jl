```@meta
CurrentModule = PkgTemplateXKDR
```

# PkgTemplateXKDR

Documentation for [PkgTemplateXKDR](https://github.com/xKDR/PkgTemplateXKDR.jl).

```@index
```

This package is used to create package templates at xKDR which sets up a Git repository for packages, continuous integration for tests and documentation building using [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/). 

# A primer on creating a package template

Suppose your package is called `XYZ.jl`. Here are the steps you should follow to set up the package template.

1. Create an empty git repository by the same name as the package, i.e `XYZ.jl`. The GitHub URL of your package should be `github.com/xKDR/XYZ.jl`.

2. Install `PkgTemplateXKDR`. 

        pkg> add "https://github.com/xKDR/PkgTemplateXKDR.jl.git"

3. Generate a [`Template`](https://invenia.github.io/PkgTemplates.jl/stable/user/#PkgTemplates.Template) object via the `PkgTemplateXKR.getPackageTemplate()` function. Pass in the names of the authors as a list (by default this list will be `["xKDR"]`), and the path where you want to put the package (by default this path will be your home directory).

        julia> using PkgTemplateXKDR
        julia> template = getPackageTemplate(authorList = ["someone", "someone-else"], packagePath = "~")

4. Call the template with your package name. 

        julia> template("XYZ.jl")

These steps will set up a Git repository at `packagePath/XYZ`, from where you can then push the code upstream.

**Note:** By default, the tests in the `test` folder will have their own dependencies in `test/Project.toml`. [If a version of Julia less than 1.2 is used, these dependencies must be added in the main `Project.toml`](https://pkgdocs.julialang.org/v1/creating-packages/#Test-specific-dependencies-in-Julia-1.0-and-1.1).

# Generating secret keys

To set up building documentation using [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/), you will also need to generate keys and put it in your repository. Follow these steps (again, we assume that the name of your package is `XYZ.jl`). 

1. First add the `DocumenterTools` package. 

        pkg> add DocumenterTools

2. Generate public and private keys. 

        julia> using DocumenterTools
        julia> DocumenterTools.genkeys(user="xKDR", repo="XYZ.jl")

3. Add the public key at https://github.com/xKDR/XYZ.jl/settings/keys with read/write access with title `documenter`. Check the "Allow write access" option.

4. Add a secure variable named `DOCUMENTER_KEY` at https://github.com/xKDR/XYZ.jl/settings/secrets. Set the value of `DOCUMENTER_KEY` to the generated private key. **Make sure not to set it to be printed in the build log**.

After this, any commit or pull request to the `main` branch will build the fresh documentation in the `gh-pages` branch of your repository. You can configure [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/) to further manage your documentation builds. 

```@autodocs
Modules = [PkgTemplateXKDR]
```
