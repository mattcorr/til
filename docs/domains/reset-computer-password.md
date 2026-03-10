# How to reset your computer if it is lost on the domain

## This will fix if you get the error:

> "the trust relationship between this workstation and the primary domain failed"

This can occur when you have snapshots on local VMs, if you go back and forth a bit, the domain controller might be confused about the identity of your VM.

If you get the above error, log into the VM in question with an admin account \(local is fine\) and run the following'

```bash
$creds = Get-Credential
Reset-ComputerMachinePassword -Server <domain controller> -Credentials $creds
```

\_NOTE: You will just need to replace `<domain controller>` with the name of the domain server on your network.

When prompted for a account provide a domain admin account

The `Reset-ComputerMachinePassword` command will do what it says.

Once done, log out then try to log back in with a domain account and it should be accepted.

