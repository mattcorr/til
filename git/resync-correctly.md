# How to get the latest changes from git before you do a commit

## Issue

If you get this error when syncing \(pushing\) to your remote origin:

```text
git fatal: no upstream configured for branch 'master'
```

This usually means you have missed some commits and need to get them in sync first before you can commit your new changes too.

## Actions

you will need to open git to the folder where the repo is hosted and enter in:

```text
git pull origin master
```

This will pull down any changes you have missed to the master branch _\(You can replace master with the branch you are working on\)_

Then you can merge any diffs and commit to your local git, then a sync to your origin should work.

