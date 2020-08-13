Bugs are categorized according to two criteria: **severity** and **priority**. Each criterion is separated into three levels: low, medium and high. Each development repository should use the following labels to classify defects:

- `BUG`
- `SEVERITY:LOW` 
- `SEVERITY:MEDIUM`
- `SEVERITY:HIGH`
- `PRIORITY:LOW`
- `PRIORITY:MEDIUM`
- `PRIORITY:HIGH`

A `BUG` label should be present on every reported defect, as well as one `SEVERITY:...` and one `PRIORITY:...` depending on its classification. This way, one can easily search for all bugs, or bugs belonging to a certain sub-category.

### Severity

##### Definition

Indicates the impact on the system and how severely its core functionality is affected. The severity is assessed by the engineering team working on the system.

##### Role

Inform the team and external partners about the severity of a defect to help drive decisions such as setting priorities or delaying a release.

##### Levels

Severity | Description / Example
--- |     ---
Low | Small defects which do not prevent any crucial functionality from working. Could be a typo in a message, some uninformative error or some bearable performance degradation. 
Medium | Visible impact on a core function or significant performance degradation.
High | A core function of the system isn't responsive or is returning invalid data.

### Priority

##### Definition

Indicates which issues should be addressed first because of their impact on the business. The priority is set by the product team based on business requirements. High severity defects will most likely tend to have a higher priority but some low severity issue may have an important impact on the user experience and have therefore a high priority. 

##### Role

Organizing issue resolution in a way that is meaningful for the business. 

##### Levels

Priority | Description / Example
--- | --- 
Low | Would eventually require attention if time allows it.
Medium | A bug that needs to be addressed after ongoing stories and tasks.
High | Requires immediate attention.

--- 

> Resources:
> 
> - https://www.lambdatest.com/blog/bug-severity-vs-priority-in-testing-with-examples/
> - https://www.atlassian.com/incident-management/kpis/severity-levels