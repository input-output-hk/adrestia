# Introduction

This article documents the process that we used to create the
`cardano-coin-selection` repository.

# Contents

* [Overview](#overview)
* [Background](#background)
* [Process](#process)
  * [Step 1: Clone Source Repository](#step-1-clone-source-repository)
  * [Step 2: Remove Irrelevant Files](#step-2-remove-irrelevant-files)
  * [Step 3: Identify Content Ancestors](#step-3-identify-content-ancestors)
  * [Step 4: Filter Commit History](#step-4-filter-commit-history)
  * [Step 5: Verify Commit History](#step-5-verify-commit-history)

# Overview

The `cardano-coin-selection` repository was created by taking a clone of the
pre-existing `cardano-wallet` repository and *filtering out* a *relevant
subset* of the version control history.

This article provides a record of the steps we used to perform this operation.

# Background

Filtering the version control history of a repository is non-trivial.

One issue is that files in a repository are often renamed several times over
the course of their history, and other files are composed of content from
multiple ancestor files.

Assuming that we'd like to generate a *new* repository from a *subset* of the
files in some source repository, we have to find a way to retain the history of
not just the subset of files that we're interested in, but *also* the histories
of all files that served as *content ancestors* for that subset of files.

If we just naively filter for commits that affect the subset of files we're
interested in, we run the risk of losing those commits that affect older
versions of files that existed at different paths.

In general, we'd like to keep commits for both:

 * all files of interest; and
 * all ancestors of files that are of interest.

## Example

For example, suppose that the module `Cardano.Wallet.Primitive.Types` includes
content from files that once existed at the following paths:

 * `lib/core/src/Cardano/Wallet/Types.hs`
 * `lib/core/src/Cardano/Wallet/Primitive/Types.hs`
 * `src/Cardano/Wallet/Primitive.hs`
 * `src/Cardano/Wallet/Primitive/Types.hs`

We'd ideally like to keep commits relating to all of those paths.

# Process

Here is a record of the steps we used to create the `cardano-coin-selection`
repository.

## Step 1: Clone Source Repository

We start with a fresh clone of the source repository (in our case, the
`cardano-wallet` repository).

## Step 2: Remove Irrelevant Files

In this step, we identify the files that we want to keep, and remove all files
that are irrelevant.

To achieve this, we make a *single commit* to the `master` branch that removes
all unwanted files from the repository. The result of applying this commit
should be precisely the set of files we want to keep.

Note that in the case of Haskell modules, we need to be somewhat careful, and
avoid deleting any modules that define functions imported by the modules we
want to keep. To avoid deleting too much, we need to determine the *transitive
closure* of module dependencies required by the modules that we're interested
in.

A safe way to achieve this is to *iteratively* remove files that we're not
interested in, while confirming that it is still possible to build the
remaining subset, repeating the process until all unwanted files are deleted.

### Example

Suppose that we want to keep file `src/ImportantModule.hs`, but that it imports
functions defined in the following modules:

 * `src/Wibble.hs`
 * `src/Wobble.hs`

Furthermore, suppose that `src/Wibble.hs` imports functions from the following
modules:

 * `src/Foo.hs`
 * `src/Bar.hs`

If we wish to keep `src/ImportantModule.hs`, we should therefore also keep:

 * `src/Wibble.hs`
 * `src/Wobble.hs`
 * `src/Foo.hs`
 * `src/Bar.hs`

## Step 3: Identify Content Ancestors

In this step, we identify the historic ancestors of all files that we want to
keep.

We generate a list of path names for *all current files*, as well as path names
for *all historical ancestor files*, using the following script:

`find-paths.sh`:
```sh
for x in $(git ls-tree -r master --name-only)
do
    git log --follow --name-status -- $x \
        | egrep R[0-9]+ \
        | awk '{print $2; print $3}' \
        | sort -u
done
```

Run the script from the root of the repository, as follows:
```sh
find-paths.sh | sort -u > files-to-keep
```

## Step 4: Filter Commit History

In this step, we *filter* the version control history, removing all commits
that are unrelated to the list of files identified in the previous step.

Run the following command, using the `git-filter-repo` tool:

```sh
git filter-repo --paths-from-file files-to-keep
```

## Step 5: Verify Commit History

In this step, we verify that we have retained all relevant parts of the
history.

Re-run the `find-paths` script from the root of the repository, as follows:
```sh
find-paths.sh | sort -u > files-kept
```

The content of `files-kept` should be **identical** to `files-to-keep`.
