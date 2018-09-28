# Git command reference

## Summary
Git is a very powerful source control system.
There are some useful commands to try and memorise!

## Commands

Get the location of the config files used for all the settings in git
```
git config --list --show-origin
```

Set your user info
```git
git config --global user.email "my.sample@email.com"
git config --global user.name "Sample Name"
```

Add a global proxy for your setup
```
git config --global http.proxy "http://account:password@proxy:port"
```

Add a proxy for a given URL:
```
git config --global http.fullsitename.proxy "http://account:password@proxy:port"
```
A sample of the above:
```
git config --global http.https://dev.azure.com.proxy "http://boq%5Caccountname:password@10.64.2.217:8080"
```