# Jira

We use the [**ADP** project](https://input-output.atlassian.net/browse/ADP) on
[IOHK Jira](https://input-output.atlassian.net/issues/).

The Jira server used to be self-hosted by our IT department, it's now
hosted on the Atlassian Cloud.

Make sure that you don't accidentally use the old URL which is `jira.iohk.io`.

Run through the [[Jira#orientation-checklist|Orientation Checklist]] to make sure
that you know enough of the basics to use Jira effectively.

## Board

Here is a link to the [Adrestia Sprint Board][board].

[board]: https://input-output.atlassian.net/jira/software/c/projects/ADP/boards/231
[dashboard]: https://input-output.atlassian.net/jira/dashboards/10143
[backlog]: https://input-output.atlassian.net/jira/software/c/projects/ADP/boards/231/backlog?issueLimit=1000

## Account setup

Authentication to jira is done through SSO with your
[`@iohk.io` Google Account](https://accounts.google.com).

## No anonymous access to Jira

Be aware that there is no anonymous access to IOHK Jira, so the
general public will not be aware of the contents of tickets, nor can
they open Jira tickets.

This is good in one sense because the information in bug trackers is
raw and unfiltered, and sometimes doesn't provide a complete picture
of the issue. But on the other hand, the community can't see
information about bugs that might affect them, or planned features.

With this in mind, please provide enough extra information in your
GitHub pull requests and commit messages so that the issue can be
understood, without referring to Jira.

## go-jira

Developers are strongly recommended to use the
[go-jira](https://github.com/go-jira/jira) CLI for querying Jira. It
is faster to use than the web interface for searching, and can be
scripted to fit our needs.

## Advanced Search Syntax

Use [advanced search](https://input-output.atlassian.net/issues/?jql=project%20%3D%20adp%20AND%20text%20~%20%22HELLO%22%20ORDER%20BY%20created%20DESC) if necessary.

There is [some documentation][advanced-search-docs] about the syntax.

[advanced-search-docs]: https://docs.atlassian.com/jira/jsw-docs-0815/Advanced+searching

## Jira Markup Syntax

Jira uses its own unique [markup syntax][syntax] for comments and text fields.

Use the little buttons beneath the text field to switch between visual and text mode.

The main things you will want are:

### Headings

```jira
h3. My heading
```

### Code

Surround inline code with `{{` and `}}`, e.g. `{{monospaced}}`.

Or make blocks with:

```jira
{code:haskell|title=Main.hs|borderStyle=solid}
module Main where

main :: IO ()
main = putStrLn "Hello, Haskell!"
{code}
```

### Links

Link to URLs with `[Atlassian|http://atlassian.com]` and ping users with
`[~username]`.

[syntax]: https://jira.atlassian.com/secure/WikiRendererHelpAction.jspa?section=all

## Pandoc

Pandoc has a [file format filter][pandoc] for Jira markup.

```shell-session
$ pandoc --from=commonmark_x --to=jira [--output=FILE] [FILES]
```

[pandoc]: https://pandoc.org/MANUAL.html#general-options

## Orientation Checklist

1. Ensure that you can log in to your [IOHK Jira account](https://input-output.atlassian.net).
2. Orient youself with the following views:
     - [Adrestia Dashboard][dashboard]
     - [ADP Backlog][backlog]
     - [ADP Active Sprint][board]
3. Make sure you can do the following things in Jira:
   - **Backlog view**

       1. Switch sprint
       2. View all Versions, toggle Versions.
       3. View all Epics, toggle Epics
       4. Toggle Quick Filters, remove all filters.

   - **Swimlanes**
   
       1. Change sprint view
       2. See your assigned tasks

   - **Issues list**
   
       1. Run an advanced search.

   - **Edit issue**
   
       1. Edit in both text markup and visual mode.
       2. Assign yourself to tickets, set co-pilot, transition state, add estimate.
       3. Create issue links from Task tickets to User Story tickets.
