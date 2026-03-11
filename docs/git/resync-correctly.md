---
description: 'Resynchronise a branch with the latest remote changes before pushing.'
---

# How to get the latest changes from git before you do a commit

## Issue

If you get this error when syncing \(pushing\) to your remote origin:

```text
git fatal: no upstream configured for branch 'main'
```

This usually means you’ve missed some commits and need to sync them first before you can commit your new changes as well.

## Actions

You will need to open git to the folder where the repo is hosted and enter in:

```console
git pull origin main
```

This will pull down any changes you have missed to the main branch _\(You can replace main with the branch you are working on\)_

Then you can merge any diffs and commit to your local git, then a sync to your origin should work.
