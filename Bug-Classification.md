Our software defects are tracked with Jira issues. Here is [the list of unresolved bugs](https://jira.iohk.io/issues?jql=project%3DADP%20and%20type%20%3D%20Bug%20and%20resolution%20%3D%20Unresolved%20ORDER%20BY%20priority%20DESC%2C%20created) in the Adrestia project.

We classify bugs by two criteria, which are related but not exactly
the same thing.

### 1. Severity

Indicates the impact on users and how much functionality is affected. The severity is assessed by the engineering and QA team working on the system.

The Jira issue `Severity / Probability Score` field show how bad the defect is.

Severity | Description / Example
--- |     ---
None | 
1 | 
2 | Small defects that do not prevent any crucial functionality from working. Could be a typo in a message, some uninformative error or some bearable performance degradation. 
3 | Visible impact on a core function or significant performance degradation.
4 | A core function of the system isn't responsive or is returning invalid data.
5 |


### 2. Priority

Priority defines which issues should be addressed first.

The priority value is set by the product team based on business
requirements, the severity of the defect, estimated time to fix it,
and other factors such as impact on the user experience.

High severity defects will tend to have a higher priority, but this is
not necessarily always the case.

Priority | Description / Example
--- | --- 
Lowest |
Low | Would eventually require attention if time allows it.
Medium | A bug that needs to be addressed after ongoing stories and tasks.
High | Requires immediate attention.
Highest |

--- 

> Resources:
> 
> - https://www.lambdatest.com/blog/bug-severity-vs-priority-in-testing-with-examples/
> - https://www.atlassian.com/incident-management/kpis/severity-levels
