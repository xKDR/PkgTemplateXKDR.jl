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

# Code coverage using [Codecov](https://about.codecov.io/)

This package template also sets up code coverage, but certain steps will have to be done manually. If your first commit fails the code coverage CI, you can simply ignore it. 

1. Ask one of the admins at xKDR to add your repository to [Codecov](https://about.codecov.io/), or if you are an admin you can do this by 
   - visiting [codecov.io](https://about.codecov.io/) and logging in using your GitHub account.
   - Authorizing [Codecov](https://about.codecov.io/) to access xKDR's repositories.
   - Visit the settings page of the repository at https://app.codecov.io/gh/xKDR/XYZ.jl/settings; make sure that the repository is activated at [Codecov](https://about.codecov.io/) (which is true by default for public repositories).
2. The link for the coverage badge is already included in README.md, but the generated token must be added. For this, visit https://app.codecov.io/gh/xKDR/XYZ.jl/settings/badge, and replace `<token>` by the value there in the url in the README.md file.

After this, any new commits will send coverage report to [Codecov](https://about.codecov.io/), and the coverage percentage will be reflected in the badge you just added. 

# Registering packages via [Registrator.jl](https://github.com/JuliaRegistries/Registrator.jl)

Registering new packages in Julia is straightforward; just follow the given steps. 

1. Visit https://juliahub.com/ui/index.html and log in using your Github account. 
2. Click on the link which says "Register Packages".
3. Before registering a package, you will have to follow a few [guidelines](https://github.com/JuliaRegistries/General/blob/master/README.md). One of them pertains to [Automatic merging](https://juliaregistries.github.io/RegistryCI.jl/stable/guidelines/). For `[compat]` section entries, you can use the [Compat Helper](https://github.com/JuliaRegistries/CompatHelper.jl).
4. A form will show up, in which you have to add the URL of the package, the branch to publish (which should be `main`), and the release notes. Clicking on submit will initiate a PR into the Julia registry. 
5. Fix any issues suggested by a registry maintainer or any issues preventing an automatic merge. Then repeat step 4.
6. When your package is registered, [TagBot](https://github.com/JuliaRegistries/TagBot) will automatically create a new release and tag for you. The tag will be a named after the version you've registered. 
7. Once this is done, [Documenter](https://juliadocs.github.io/Documenter.jl/stable/) will create separate folders in the `gh-pages` branch of your repository. There will be folders called `stable`, `dev` and other folders named after different versions of the package which you've registered. `stable` is the most recent version that has been registered, `dev` is the documentation for the most recent commit to the `main` branch, and other folders contain documentation for other registered versions of the package. 
8. Create separate `stable` and `dev` badges in the README, which point to the `stable` and `dev` branches.

```@autodocs
Modules = [PkgTemplateXKDR]
```
