# How to move commited changes to a different branch

## Issue
You are working away on a repo and commit your changes, you then push to origin for a PR and realise you were locally committing to master.
How do I undo this and commit my changes to a different branch so I can create a PR?

## Actions

From the command line:
```
git reset HEAD~1
```
NOTE: the 1 indicates how many commits you want to undo. You can view the list of commits in your git client or by `git log` so you can see how many you want to undo. ie if its three commits then run `git reset HEAD~3`

The make a new branch with:
```
git checkout -b branchname
```
Then commit your code again (on the correct branch) via Visual Studio Code or Fork.

WARNING: This will mean if you undo multiple commits, they will then be batched up into one commit. 
