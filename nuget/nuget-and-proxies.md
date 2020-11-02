# Nuget and Proxies

If you need to access the nuget.org from behind a corporate firewall that needs authentication, one might think you need a custom nuget.config file with your proxy server URL and user/password settings.

It appears that even up to nuget 4.1, this is still not the case, the proxy settings need to reside in the default nuget.config location which is at `%APPDATA%\NuGet\NuGet.Config`.

This is covered in details in this [nuget bug](https://github.com/NuGet/Home/issues/747).

So, if you want to get out through the proxy easily, configure your nuget with the following:

```text
nuget.exe config -set http_proxy="http://proxy.server.com:8888"
nuget.exe config -set http_proxy.user=Username
nuget.exe config -set http_proxy.Password=Password
```

Do not store these in a separate config file! Make sure they go to the default!

In other words, **don't do this**:

```text
nuget.exe config -set http_proxy="http://proxy.server.com:8888" -ConfigFile=D:\nuget\nuget.config
```

Then when you run your nuget restore, it should work

