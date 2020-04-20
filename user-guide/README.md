# README

This website is generated using [hugo](https://gohugo.io/). It uses the [book](https://themes.gohugo.io//theme/hugo-book/) theme which provides some
nice constructs on top of raw markdown.

# Getting Started

1. Install [hugo_extended_0.68.0](https://github.com/gohugoio/hugo/releases/tag/v0.68.0).

   :warning: Make sure to pick the **extended** version!!

2. Run `hugo server -t book`

   This spins up a server with live-reloading that compiles and serves the static website on http://localhost:1313/adrestia/user-guide.

# Deploying

The static site can be deployed to gh-pages as follows:

1. Remove any existing `public` folder: 

   ```
   rm -rf public
   ```

2. Compile a production build:

   ```
   hugo -t book
   ```

3. Create a new branch gh-pages: 

   ```
   git checkout -B gh-pages
   ```

4. Force add and commit the `public` folder to the repository: 

   ```
   git add -f public && git commit -m "deploy $(git rev-parse HEAD)"
   ```

5. Filter the branch history

   ```
   cd .. && git filter-branch -f --prune-empty --subdirectory-filter user-guide/public
   ```

6. Add a `.nojekyll` file to prevent default Jekyll builds 

   ```
   touch .nojekyll && git add .nojekyll && git commit --amend -C HEAD
   ```

7. Push everything to github, overriding the existing branch 
    
   ```
   git push origin HEAD -f
   ```

8. Come back to `master`: 

   ```
   git checkout -f master
   ```
