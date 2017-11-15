# TFS or VSTS Build unable to start.

## Issue
If you have a well defined build process, and yet your build is failing in the Initalize Job step with error messages like:
Errors like this are really puzzling as builds that worked in the past are now no longer working.

```
2017-11-15T11:31:09.4021313Z ##[section]Starting: Initialize Job
2017-11-15T11:31:09.4177514Z ##[debug]Primary repository: Client.Product.FabricApp. repository type: TfsGit
2017-11-15T11:31:09.4177514Z Prepare build directory.
2017-11-15T11:31:09.4490007Z ##[error]Object reference not set to an instance of an object.
2017-11-15T11:31:09.4490007Z ##[debug]System.NullReferenceException: Object reference not set to an instance of an object.
   at Microsoft.VisualStudio.Services.Agent.Worker.Build.TrackingManager.Create(IExecutionContext executionContext, ServiceEndpoint endpoint, String hashKey, String file, Boolean overrideBuildDirectory)
   at Microsoft.VisualStudio.Services.Agent.Worker.Build.BuildDirectoryManager.PrepareDirectory(IExecutionContext executionContext, ServiceEndpoint endpoint, ISourceProvider sourceProvider)
   at Microsoft.VisualStudio.Services.Agent.Worker.Build.BuildJobExtension.InitializeJobExtension(IExecutionContext executionContext)
   at Microsoft.VisualStudio.Services.Agent.Worker.JobExtension.<InitializeJob>d__9.MoveNext()
2017-11-15T11:31:09.4490007Z ##[section]Finishing: Initialize Job
```

## Solution
**This means your working folder on the Build Agent is corrupted. The best option is to delete the work folder.
(this normally is C:\agent\\_work)**
