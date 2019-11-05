# How to accept script changes

If your Jenkins build job contains scripts, sometimes new deployments will have this error when you run them the first time:

```
Started by user dummyuser
org.jenkinsci.plugins.scriptsecurity.scripts.UnapprovedUsageException: script not yet approved for use
	at org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval.using(ScriptApproval.java:469)
	at org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition.create(CpsFlowDefinition.java:121)
	at org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition.create(CpsFlowDefinition.java:68)
	at org.jenkinsci.plugins.workflow.job.WorkflowRun.run(WorkflowRun.java:293)
	at hudson.model.ResourceController.execute(ResourceController.java:97)
	at hudson.model.Executor.run(Executor.java:429)
Finished: FAILURE
```

To get around this, go to:

**Jenkins -> Manage Jenkins -> In-process Script Approval**

Scroll down to the scripts that needs to be approved and click on the Approve button as needed.