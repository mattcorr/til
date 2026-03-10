# Git command reference

## Summary

Git is a very powerful source control system. There are some useful commands to try and memorise!

## Commands

### Configuration related

Get the location of the config files used for all the settings in git

```text
git config --list --show-origin
```

Set your user info

```text
git config --global user.email "my.sample@email.com"
git config --global user.name "Sample Name"
```

Add a global proxy for your setup

```text
git config --global http.proxy "http://account:password@proxy:port"
```

Add a proxy for a given URL:

```text
git config --global http.fullsitename.proxy "http://account:password@proxy:port"
```

A sample of the above:

```text
git config --global http.https://dev.azure.com.proxy "http://mattcorr:password@10.64.2.217:8080"
```

### Submodule related

Generally speaking, avoid submodules and use nuget packages instead. But if you have to deal with them, when you pull a full repo, it is likely you will need to update all the submodules as well. This can be done with running from the repo root:

```text
git submodule foreach git pull origin master
```

### Undoing commits

Undo a commit to a local branch. Say you accidently push files to your local master instead of pushing to a branch for a PR, use this to undo the change:

```text
git reset --soft HEAD~1
```

This will undo the commit AND leave the changed files still changed so you can push them to the correct branch. But if you want to blow away the changes and revert to the previous commit just use:

```text
git reset --hard HEAD~1
```

But be really sure you want to do it as there is no undo.

