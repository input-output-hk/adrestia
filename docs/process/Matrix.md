# Matrix Team Chat

Our team's homeserver is [adrestia.iohkdev.io](https://matrix.adrestia.iohkdev.io/).

## Web client

You can log in immediately with your web browser, without installing any client software by visiting:

:::{.m-8}
[element.adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/){class="py-4 px-8 bg-indigo-200 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-300 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:ring-opacity-75"}
:::

## Authentication

Any user with an active [iohk.io Google Account](https://accounts.google.com)
can log in.

Some people have username/password accounts. These were created manually with
the Matrix Synapse user admin API.

Example usernames:
 - IOHK Google account: [@rodney.lorrimar:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/user/@rodney.lorrimar:adrestia.iohkdev.io)
 - Username/password account: [@rvl:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/user/@rvl:adrestia.iohkdev.io)

### Other homeservers

If you have a user on another Matrix homeserver (e.g. [matrix.org][]), then you
can ask to be invited into rooms on our homeserver.

However you may wish to keep your personal accounts separate from IOHK.

### MFA

Sadly, neither U2F nor TOTP are supported by Matrix and Element yet.

But if you use your Google account to log in then you will get MFA through Google.

### Changing your password

Unless using your Google account to log in, you will have a password.

1. When changing your password, **export your E2E room keys** when prompted!
2. It will need a temporary password to encrypt the file. It's probably easiest
   just to use your new password for this purpose.
3. After changing your password, import your E2E room keys again.
4. Delete the `element-keys.txt` file from your downloads directory when
   finished.

## Rooms and Spaces

Once you are logged in, ask someone to invite you to the Adrestia _space_ (it's a private space).

Within this space we have multiple rooms available:

- [\#team:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/room/#team:adrestia.iohkdev.io) (invite only) - Adrestia team and special guests.
- [\#testing:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/room/#testing:adrestia.iohkdev.io) - Used for experimenting with Matrix chat.
- [\#dev:adrestia.iohkdev.io](https://element.adrestia.iohkdev.io/#/room/#dev:adrestia.iohkdev.io) (invite only) - Development discussion.

## End-to-end Encryption

This is a way to send messages via a Matrix homeserver, without the server
operator being able to read the messages.

### Security Key

The _Security Key_ (also called "Recovery Key") is an encryption key stored
locally by Matrix clients, used for creating session keys, storing end-to-end
encryption keys, and so on.

It is formatted as 12 quartets of alphanumeric characters, e.g.
```
EsTD cdDd eEff 0011 2233 4455 6677 8899 aabb ccdd eeff gg1F
```

### Cross-signing

Cross-signing is where you verify your other login sessions. For example, you
may have login sessions on multiple computers, each with their own session key.

If you cross-sign all your sessions, then other clients can consider all of your
logins to be verified, just by verifying one of your logins.

And, importantly, you will be able to read your encrypted history on other logins.

To enable it, choose _Set up encryption_ in your Element settings.

### "Unable to decrypt" errors

Not quite sure why this happens. Possible causes:

1. The sender doesn't know you exist, because when they sent the the message
   their server hadn't yet seen you were in the room.

2. Lack of cross-signing ("verification" of other user's sessions).

### How to send direct messages which _aren't_ E2E encrypted

Under Element at least, direct messages to other users default to being E2E
encrypted, and you can't change it.

In case you need it, a workaround is:
1. Create a new private room with encryption disabled.
2. Invite the other user to this room.
3. Run the command `/coverttodm` in this room.

## Other clients

You can use any Matrix client to connect to this homeserver.
[Here is a list](https://matrix.org/clients/).
Apparently it's even possible to use Matrix from [[Emacs]].

## Homeserver Software

Our homeserver is running [Matrix Synapse](https://github.com/matrix-org/synapse) under [NixOS 21.05](https://nixos.org/).

## Logging

All messages are logged and stored in the server's PostgreSQL database, which is
backed up with encryption.

Keep in mind that unless you enable end-to-end encryption in your room, message
content will be stored as plaintext in the PostgreSQL `event_json` table.

## Room Settings

Some recommendations for settings.

### Space

Adrestia.

### Private/Public

Private channels are invitation only.

### Encryption

- Use E2E encryption for your direct messages.
- Use E2E encryption for special rooms.
- Until we resolve the (un)usability issues with E2E encryption, don't enable it on our commonly used rooms.

### History

TBD

### Publish names

TBD

## Federation

Federation [works](https://federationtester.matrix.org/api/report?server_name=adrestia.iohkdev.io)
on this homeserver, as long as the room had the "Enable guest access" Security &
Privacy advanced setting enabled when it was created.

Note: once the "Enable guest access" option has been disabled once, it will
never be possible to invite users from other homeservers, no matter what the
setting is changed to.

## Message Search

Search works in the Element client. Click the little magnifying glass button in
the upper-right corner.

### Encrypted messages

I found this nugget:

> Element can't securely cache encrypted messages locally while running in a web
> browser. Use Element Desktop for encrypted messages to appear in search
> results.

## Glossary

- Matrix: a messaging protocol, the project which develops the messaging protocol, and the organisation which runs the Matrix project.
- Homeserver: a HTTP server running Matrix server software. The Matrix protocol is _federated_, which means that users on one homeserver can join chat rooms on another homeserver. The homeserver handles authentication of its users, and hosts rooms.
- [matrix.org][]: This domain name functions both as the Matrix project web site, and also as the domain name for a large public Matrix homeserver.
- [Synapse][]: The reference implementation of a Matrix homeserver. There is also a new homeserver under development called "[Dendrite][]."
- [Element][]: a Matrix client implemented with web technologies such as [React](https://reactjs.org). It can deployed on any HTTP server - in this form it is called [_Element Web_][element-web]. Or it can be installed as an Electron app on the desktop or mobile devices.
- Riot: This is what the Element client used to be called before they renamed it.

## "Missing" Features

The following things would be nice to have in Matrix, but currently aren't implemented:

- Message threads
- Custom emoji
- U2F

## References

1. [The Matrix Web Site][matrix.org]
2. [Element Blog: E2E Encryption by Default & Cross-signing is here](https://element.io/blog/e2e-encryption-by-default-cross-signing-is-here/)
3. [Matrix Implementers Guide: E2EE](https://matrix.org/docs/guides/implementing-more-advanced-e-2-ee-features-such-as-cross-signing)
4. [Matrix and E2E Encryption (or: how not to lose your messages)](https://gerstner.it/2021/02/matrix-and-e2e-encryption-or-how-not-to-lose-your-messages/)

[matrix.org]: https://matrix.org
[synapse]: https://github.com/matrix-org/synapse
[dendrite]: https://github.com/matrix-org/dendrite
[element]: https://element.io/
[element-web]: https://app.element.io
