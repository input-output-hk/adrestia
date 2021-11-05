---
tags:
  - needs/writing
  - needs/review
---

# Communication conventions

Staying in touch is difficult when working remotely within a global
organaisation.

We tend to suffer from the problems of not enough communication _and_ too much
communication, both at the same time! The actual issue is low quality of
communication, and the use of inappropriate mediums of communication.

## Goals

1. When a team member needs help they are able to ask and get a reply reasonably soon.
2. Team members must be able to work on their tasks without being bothered by irrelevant messages.
3. Team members don't feel alone with their work - they can see who else "around" at the moment.
4. Popup notifications, red dots, etc, are only shown for truly important messages.
5. Team members control how and when they are notified of messages.
6. Team members have a shared medium to discuss frankly the topics which matter - privately and without intrusion or judgement.
7. People from other teams have a way of contacting the team and escalating urgent issues.

## Solution

We will use a private Matrix server for team chats, in place of the
`#adrestia-secret-fort` slack channel, which will be archived.

Team members are asked to review messages from Slack once per day. They may
choose to use Slack more frequently, but this is up to them.
  
### Matrix

The Matrix server is [adrestia.iohkdev.io](https://matrix.adrestia.iohkdev.io/).

You can use any Matrix client to connect, or the
[Element Web](https://element.adrestia.iohkdev.io/) client.

#### Authentication

Any user with an active [iohk.io Google Account](https://accounts.google.com)
can log in.

Some people have username/password accounts. These were created manually with
the Matrix Synapse user admin API.

Example usernames:
 - IOHK Google account: [@rodney.lorrimar:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/user/@rodney.lorrimar:adrestia.iohkdev.io)
 - Username/password account: [@rvl:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/user/@rvl:adrestia.iohkdev.io)

#### Rooms

- [\#dev:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/room/#dev:adrestia.iohkdev.io) (invite only) - Development discussion
- [\#testing:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/room/#testing:adrestia.iohkdev.io) - Used for experimenting with Matrix chat.

#### When to be online

Team members are very much encouraged to be online with Matrix while they are at
work on their computer, and offline otherwise.

#### Concentration time

Sometimes complete silence is necessary for your task. In that case you can
switch off Matrix as well. But most times it shouldn't be bothersome because of
the small number of users, and the notification controls which matrix clients
provide.

#### When to ping

Use the ping `@username:adrestia.iohkdev.io` in a channel to get someone's
attention.

This usually results in a more prominent notification, depending on their client
settings.

### When to use calls

Often it's easier to explain something or talk a problem through by video or
audio calls. If you're finding it difficult to understand or explain something
by text chat, then start up a call, and save yourself some time.

### When to write a document

Write a [[Documentation|document]] if the information or question that you are
trying to convey is too big or complex for a chat room.

If something has been discussed that will probably be useful in future, you can
help everyone by transferring it into a [[Documentation|document]]. It's quite
difficult to find information by searching chat room archives.

If a design decision has been reached, record it as a document in the project
source code repository.

If a process or practices decision has been reached, record it in the
[[index|Adrestia docs]] repository.

### When to use pair programming

See [[Mob-Development]].

## Future Goals

- It would be really good if there were a "standing" video call session always
  running which team members can easily join and leave at any time. Matrix
  "widgets" might be suitable for this purpose.
