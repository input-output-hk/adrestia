---
tags: [draft]
tags: [qa]
---

# Issue Tracking

We use the Jira [ADP project](https://input-output.atlassian.net/issues/)
to record development tasks.

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

## *TODO*

- [ ] Move issue tracking info from [[Development-Process]] into this page, and update for Jira.

- [ ] Finalise and paste in new urgent issue handling process document.
