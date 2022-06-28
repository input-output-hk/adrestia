# Git Branching Scheme

Use these names for your Git branches.

## Topic branches

Use the format `user/issue/topic`.

| Part    | Meaning                               | Example           | Optional                                                  |
|---------|---------------------------------------|-------------------|-----------------------------------------------------------|
| _user_  | Your GitHub username                  | `rvl`             | If branch is a shared effort and _issue_ is provided.     |
| _issue_ | Jira issue key or GitHub issue number | `ADP-123`, `1234` | If _username_ and/or _issue_ are provided. |
| _topic_ | Some description of the branch | `add-foo` | If _issue_ is provided. |

## Release branches

We release from the mainline branch, and therefore don't use release
branches.

This lowers maintenance overheads, but requires that we always keep
`master` in a releaseable state.

### Release preparation branches

According to the Release Checklist, these are of the form
`your-name/bump-release/YYYY-MM-DD`.

## Mainline branch

Mainline branch is `master` - for consistency.
