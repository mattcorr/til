# Get row count for all tables in database

If you want to get an idea of how many rows of data are in your tables in your database, connect to the database and run this query:

```sql
SELECT t.name, s.row_count from sys.tables t
JOIN sys.dm_db_partition_stats s
ON t.object_id = s.object_id
AND t.type_desc = 'USER_TABLE'
AND t.name not like '%dss%'
AND s.index_id IN (0,1)
```

