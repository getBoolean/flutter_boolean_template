![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/icn9uo2knig43ifys7in.png)

It's common for Flutter apps to include a web demo for the `main` branch hosted on Github Pages, but this can also be done for every branch in your repo. This allows any branch to be previewed and makes reviewing Pull Requests much more convenient with a live preview available. I previously used a slightly different version of this for a Godot 3 team project and all the team members really appreciated the web previews when doing code review.

This involves three workflow files: deploying the Flutter Web app, generating an index file, and cleaning up deleted branches.

* Live Demo: [getboolean.github.io/flutter_boolean_template](https://getboolean.github.io/flutter_boolean_template)

## Prerequisites

This GitHub Pages setup requires the Flutter `#/HashUrlStrategy` URL strategy, so ensure it is not disabled for your web builds deployed to GitHub Pages. If it is disabled, the Navigator 2.0 subroutes will prevent GitHub Pages from resolving the correct app when refreshed. (You might want to use a `--dart-define` environment variable for this)

## Workflow 1 - Deploy Flutter Web Branch Previews

This workflow file can be added to your `.github/workflows` directory, or integrated into your existing CI workflow. It will build Flutter for Web and deploy it to `gh-pages` under the branch name folder.

```yaml
name: Deploy Branch Previews

# Can also be restricted by branches if you choose.
on:
  push:
    branches:
      - '**'
      - '!gh-pages'

# Write permissions need to be enabled for the workflow to write to GitHub Pages.
permissions:
  contents: write

jobs:
  deploy_web:
    name: Deploy Flutter Web to GitHub Pages
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3
      - name: Install and set Flutter version
        uses: subosito/flutter-action@v2
        with:
          channel: "stable"
          flutter-version: "any"
          cache: true
          cache-key: "flutter-:os:-:channel:-:version:-:arch:-:hash:"
          cache-path: "${{ runner.tool_cache }}/flutter/:channel:-:version:-:arch:"
      - name: Get branch name
        id: branch-name
        uses: tj-actions/branch-names@v8
      - name: Build Web
        run: |
          flutter pub get
          flutter build web --release --web-renderer=canvaskit --base-href="/${{ github.event.repository.name }}/${{ steps.branch-name.outputs.current_branch }}/"
      - name: Deploy to GitHub Pages 🚀
        uses: JamesIves/github-pages-deploy-action@releases/v4
        with:
          branch: gh-pages # The branch the action should deploy to.
          folder: build/web # The folder the action should deploy.
          target-folder: "${{ steps.branch-name.outputs.current_branch }}"
```

Finally, enable read and write permissions for GitHub Actions and enable GitHub Pages for your repository, see the below images for the settings. Your app should now be viewable at URL `gh_pages_url/` + `branch_name`.

(We aren't done yet, we still need to clean up deleted branches and create an index file to link to each branch preview.)

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/k5zd8ga3axhrb5txz70b.png)

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/2ve8aiv937gv97npgqwe.png)

## Workflow 2 - Generating the Index File

This workflow file should be added to your `.github/workflows` directory. It will create a `README.md` file in the `gh-pages` branch that links to each branch preview deployed to GitHub Pages.
This workflow *must* be pushed to the `gh-pages` branch, otherwise it will not run.

*The generated index file is pretty barebones, but it gets the job done*

```yaml
name: gh_pages_readme

on:
  push:
    branches:
      - "gh-pages"

jobs:
  gh_pages_readme:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
          ref: gh-pages
      - name: Delete README.md
        run: rm -f README.md
        # get list of branches and generate links to each branch's subfolder in the README.md file
      - name: Generate README.md
        run: |
          echo "## Flutter Branch Web Previews" >> README.md
          echo "" >> README.md
          git branch -r | grep -v '\->' | grep -v 'origin/gh-pages' | while read remote; do
            if [ -d "${remote#origin/}" ]; then
              echo "- [${remote#origin/}](./${remote#origin/}/)" >> README.md
            fi
          done
      - name: Commit and push if changed
        run: |
          git config --global user.name 'GitHub Actions'
          git config --global user.email github-actions@github.com
          git add README.md
          git diff-index --quiet HEAD || git commit -m 'Update README.md'
          git push
```

## Workflow 3 - Deleted Branch Cleanup

Finally, we need to clean up deleted branches from gh-pages, otherwise the repository size will grow indefinitely.
This workflow will run on branch deletions and remove the associated folder from gh-pages.

```yaml
name: gh-pages-cleanup
on: delete

jobs:
  cleanup:
    name: Cleanup gh-pages
    runs-on: ubuntu-latest
    if: github.event.ref_type == 'branch'
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          lfs: true
          ref: gh-pages
      - name: Get branch name
        id: branch-name
        uses: tj-actions/branch-names@v8
      - name: Remove deleted branch from gh-pages
        if: steps.branch-name.outputs.is_default == 'true'
        run: |
          git config user.name "Github Actions"
          git config user.email github-actions@github.com

          BASE_REF=$(printf "%q" "${{ github.event.ref }}")
          BASE_REF=${BASE_REF/refs\/heads\/}

          echo "Deleting folder: $BASE_REF"
          git rm -rf $BASE_REF
          git commit -m "Remove deleted branch $BASE_REF"
          git push
```
