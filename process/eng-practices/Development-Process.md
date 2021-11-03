---
order: 1
---

# Development Process

## Coding

- The code is collectively owned, everyone is knowledgeable about every part of the code
- The code is peer-reviewed
- Code is following an agreed [[Coding-Standards|standard and style]]
- Code is integrated and tested daily to the main branch (`master`) through PR
- The main branch should be _releasable_ at any time and not contain broken features
- No unplanned optimizations, features or unneeded abstractions are implemented
- We favor simple unbloated code and use refactoring techniques to add features
- We test chunks of codes as we submit and integrate them, maintaining a high code coverage at all time


## QA

- All code should be covered by tests (either unit, integration or manual).
- We favor automated tests over manual testing.
- Issues are closed by QA, once convinced by developers that the added code works and is covered
    - Developers are expected to point relevant automated or manual test procedures to QA
    - Developers may also point to documentation or, code details that ensure reliability of the code
- When a bug is found, regression tests are created to illustrate the failure, prior to fixing it
- Tests are ran daily in a integration environment.
- Critical parts of the code have benchmarks to identify potential bottlenecks.
- Code and more importantly public interfaces are well-documented and digestible.

## Bugs

See [[Issue-Tracking#bug-tracking]].
