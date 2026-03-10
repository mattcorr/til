# How to select custom attributes on an object

Normally, when you use Select-Object, you are restricted to the properties of the object on the pipeline.
i.e.
```powershell
objects | Select-Object Id, Name, Age, Address
```

But if you want to display a child object's property or do a simple calculation on a field ,can that be done on a `Select-Object`?

You can with:

```powershell
$objects | Select-Object Id, Name, @{N='Name', E={$_.SubObject.SubProperty}}, Age, Address
```
NOTE: **N** is a short form of Name and **E** is a short form of Expression.

You can do field manipulation too, like:

```powershell
$objects | Select-Object Id, Name, @{N='Age in Months', E={$_.Age * 12}}, Age, Address
```

