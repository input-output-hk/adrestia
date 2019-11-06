# Wallet Backend Retrospective

<p align="right">2019/11/06</p>

## What Went Well?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+3         | 0            | Haskell training with Edsko. It was useful to learn more about laziness and performance.
+3         | 0            | The team meeting in France. It was great to get to know each other better.
+3         | 0            | Despite the numerous obstacles, the team has been able to make good progress over the past months and continues to.
+2         | 0            | Daedalus has integrated with our API without running into any particular issue. So the quality of our testing and documentation seems to pay off.
+1         | 0            | There's now a centralized place for product requirements and a referent for product decision.


## What could be improved?

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+4         | 0            | It's unclear which parts of Jörmungandr are complete.
+3         | 0            | Jörmungandr documentation is not great. Support on Slack seems terse.
+2         | 0            | Devops agreed to help with the windows port but then changed their mind without telling us. It's much more work doing this at a late stage than earlier.
+2         | 0            | We kinda lost control of many things regarding the CI setup which is all Nix again. This makes is fairly difficult for developers to be autonomous regarding CI issues.
+2         | 0            | The late integration, ever changing scope and lack of transparency on issue completeness forces the team to work crazy hours to meet their goal.
+2         | 0            | Too many project-relevant conversations are happening in DMs, rather than channels, slack threads are not being used consistently, asynchronous communication methods are used too much compared to synchronous communication methods.
+2         | 0            | Next team meetup should make sure to include everyone!
+1         | 0            | Reliability of the CI system.
+1         | 0            | Some of our tests have been a bit flaky, causing spurious CI failures.
+1         | 0            | Some test suites don't load/run in ghci/ghcid due to hard-wired file locations (such as the `block0.bin` file). This makes it slower to iterate. Examples: `cardano-wallet-jormungandr:test:unit` `cardano-wallet-jormungandr:test:integration`
+1         | -1           | Some integration tests could be turned into unit tests or even property tests.
+1         | -1           | Integration with Daedalus is happening at the last minute, which is risky.
+1         | -1           | The stateless REST API of Jörmungandr pushes a lot of complexity onto our network layer.
0          | 0            | Use a better retrospective system that more clearly indicates relative importance.
0          | -3           | The issue trackers we have to use keep changing. Now there is Jira which is basically the same YouTrack. Both of these are more powerful than GitHub.

#### Actions

- Go through the current list of integration tests, identify those which can be transformed and open a ticket in the wallet laboratory about it.
- Try to stick with the same terminology as Jörmungandr where we can to reduce cognitive load and discrepency
- Link more to the rust code from our own code, especially the binary serializer/deserializer 
- Consider a Nix training in the next meetup? 
- Ask for more documentation and diagrams explaining how the DevOps framework works. As developers, we do not understand the scope and the capabilities of what the DevOps team is doing
- Make sure we start slack discussions with a clear topic in bold and then, have the rest of the discussion in a thread
- Be more disciplined on slack and stick with the topic being discussed 
- Do not hesitate to fire a short synchronous call if the slack conversation is going nowhere
- Have a look at the market and see if any better retrospective tool exists. Prior to doing this, identify what features we are lacking / demanding 

## Ideas

:thumbsup: | :thumbsdown: | Topic
---        | ---          | ---
+4         | 0            | If you have a brilliant idea to share, immediately add it to the cardano-wallet laboratory
+3         | 0            | Hold the next wallet team meetup in Japan.
+1         | 0            | Encourage team members to turn on cameras during meetings so we can see one another.
+1         | 0            | Review the English in our API descriptions and error messages (for correctness and fluency).
+1         | 0            | Permit any non-wallet-team IOHK staff push commits to branches and open PRs in our repo. Remember that there is master branch protection in GitHub. However -- require that the work of external contributors is reviewed by more than a couple team members.
+1         | 0            | Retrospective need to be held a bit more often, last one was 2 months ago :s
0          | 0            | Create and operate a wallet backend stake pool for the TestNet!

- Make the cardano-wallet-laboratory public and encourage community to contribute 
- Add a proper CONTRUBITION.md to our Github explaining our process
