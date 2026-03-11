---
description: 'Check whether an Active Directory user account is currently locked out.'
---

# Check if an AD account is locked

If you want to quickly see if an account is locked, use this:

```powershell
Get-ADUser <accountname> -Properties * | Select-Object LockedOut
```

!!! note
    The accountname can have wildcards. 

There are other useful parameters on the Properties worth examining.

* **passwordlastset** - when was the password last set?
* **passwordneverexpires** - does the password expire sometime?
