# How to apply tags to all resources in your subscription

Tags are a useful way to keep track of who owns what resource in a company wide Azure subscription.

You can enforce the creation of tags via the **Apply tag and its default value** policy you can assign to all or part of your subscription. But this only works for future resource created. What if you already have a lot there?

## Set tags at the resource groups

We can create the tags we need at the resource group level with this:

```text
Get-AzureRmResourceGroup | ForEach-Object { Set-AzureRmResourceGroup -Name $_.ResourceGroupName -Tag @{ Key="value" } }
```

This will set the tag for all resource groups.

## Set tags for the resources within the groups

Then to copy the tags at the resource groups and assign them to the resources within the groups you can run the following:

```text
$groups = Get-AzureRmResourceGroup

foreach ($group in $groups)
{
    $resources = $group | Find-AzureRmResource
    Write-Host "Processing resource group $($group.ResourceGroupName)" -f Cyan

    foreach ($r in $resources)
    {
        $resourcetags = (Get-AzureRmResource -ResourceId $r.ResourceId).Tags

        foreach ($key in $group.Tags.Keys)
        {
            if (($resourcetags) -AND ($resourcetags.ContainsKey($key))) { $resourcetags.Remove($key) }
        }
        $resourcetags += $group.Tags
        Set-AzureRmResource -Tag $resourcetags -ResourceId $r.ResourceId -Force
    }
    Write-Host
}
```

## Further reading

* [Official Microsoft documentation about tagging azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)

