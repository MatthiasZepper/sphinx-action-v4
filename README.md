# Sphinx Build Action modification

This is a derivative of a Github action built by [@ammaraskar](https://github.com/ammaraskar) and originally published at [ammaraskar/sphinx-action](https://github.com/ammaraskar/sphinx-action). Because the original action is [unfortunately outdated](https://github.com/ammaraskar/sphinx-action/pull/21), has unresolved issues with [LaTeX builds](https://github.com/ammaraskar/sphinx-action/issues/32) and seems to be somewhat unmaintained in general, I forked a patched version by [ferdnyc](https://github.com/ammaraskar/sphinx-action/pull/39) and did some minor tweaks to make it run with our project. 

The action looks for Sphinx documentation folders in your
project. It builds the documentation using Sphinx and any errors in the build
process are bubbled up as Github status checks.

An updated Github action derived from  . It uses customisations from @ferdnyc in combinations with own tweaks. 

The main purposes of this action are:

* Run a CI test to ensure your documentation still builds. 

* Allow contributors to get build errors on simple doc changes inline on Github
  without having to install Sphinx and build locally.
  
![Example Screenshot](https://i.imgur.com/Gk2W32O.png)

## How to use

Create a workflow for the action, for example:

```yaml
name: "Pull Request Docs Check"
on: 
- pull_request

jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: matthiaszepper/sphinx-action@latest
      with:
        docs-folder: "docs/"
```

* If you have any Python dependencies that your project needs (themes, 
build tools, etc) then place them in a requirements.txt file inside your docs
folder.

* If you have multiple sphinx documentation folders, please use multiple
  `uses` blocks.

## Great Actions to Pair With

Some really good actions that work well with this one are
[`actions/upload-artifact`](https://github.com/actions/upload-artifact)
and [`ad-m/github-push-action`](https://github.com/ad-m/github-push-action).

You can use these to make built HTML and PDFs available as artifacts:

```yaml
    - uses: actions/upload-artifact@v1
      with:
        name: DocumentationHTML
        path: docs/_build/html/
```

## Advanced Usage

If you wish to customize the command used to build the docs (defaults to
`make html`), you can provide a `build-command` in the `with` block. For
example, to invoke sphinx-build directly you can use:

```yaml
    - uses: matthiaszepper/sphinx-action@latest
      with:
        docs-folder: "docs/"
        build-command: "sphinx-build -b html . _build"
```

If there's system level dependencies that need to be installed for your
build, you can use the `pre-build-command` argument like so:

```yaml
    - uses:  matthiaszepper/sphinx-action@pdflatex
      with:
        docs-folder: "docs/"
        build-command: "make latexpdf"
```
