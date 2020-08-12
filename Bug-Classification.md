Bugs are categorized according to two criteria: **severity** and **priority**. Each criteria is declined in three levels: low, medium and high. Each development repository must therefore use appropriate labels to classify defects:

- `BUG`
- `SEVERITY:LOW` 
- `SEVERITY:MEDIUM`
- `SEVERITY:HIGH`
- `PRIORITY:LOW`
- `PRIORITY:MEDIUM`
- `PRIORITY:HIGH`

A `BUG` label should be present on every reported defect, as well as one `SEVERITY:...` and one `PRIORITY:...` depending on its classification. This way, one can easily search for all bugs, or bugs belonging to a certain sub-category.

### Severity

Indicates how is the impact on the system and what the threat is regarding its core functionality. The severity is assessed by the engineering team working on the system.

Severity | Description / Example
--- |     ---
Low | Small defects which does not prevent any crucial functionality to work. Could be a typo in a message, some uninformative error or some bearable performance degradation. 
Medium | Visible impact on a core functionality or some important performance degradation. 
High | A core functionality of the system isn't unresponsive or returning invalid data.


### Priority

Indicates which issues should be addressed first because of their impact for the business. The priority is set by the product team based on business requirements.

Priority | Description / Example
--- | --- 
Low | Would eventually require attention if times allow it.
Medium | A bug that needs to be addressed after ongoing stories and tasks.
High | Require immediate attention. 

--- 

> Resources:
> 
> - https://www.lambdatest.com/blog/bug-severity-vs-priority-in-testing-with-examples/
> - https://www.atlassian.com/incident-management/kpis/severity-levels