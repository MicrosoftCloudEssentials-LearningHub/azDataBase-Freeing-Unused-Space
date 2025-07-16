# Azure SQL Database: <br/> Freeing Up Unused Space - Overview 

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com) 
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-07-16

----------

> To optimize your Azure SQL Database, you can use several strategies: 

<details>
<summary><b>Table of Content </b> (Click to expand)</summary>

- [Shrinking the Database](#shrinking-the-database)
- [Data Compression](#data-compression)
- [Index Optimization](#index-optimization)
- [Partitioning Tables](#partitioning-tables)

</details>

## Shrinking the Database

>This helps reclaim unused space. Use the command:

   ```sql
   DBCC SHRINKDATABASE (YourDatabaseName, 10);
   ```

   To check for blocking operations that might prevent the shrinking process from completing:

   ```sql
   SELECT blocking_session_id, wait_type, wait_time, wait_resource
   FROM sys.dm_exec_requests
   WHERE blocking_session_id <> 0;
   ```

## Data Compression

> Apply `PAGE` or `ROW` compression to reduce storage costs and improve performance. For example:

   ```sql
   ALTER TABLE YourTableName REBUILD WITH (DATA_COMPRESSION = PAGE);
   ```

## Index Optimization

> Regularly rebuild or reorganize indexes to maintain query performance:

   ```sql
   ALTER INDEX ALL ON YourTableName REBUILD;
   ```

## Partitioning Tables

> Split large tables into partitions to improve manageability and performance:

   ```sql
   CREATE PARTITION FUNCTION MyPartitionFunction (datetime) AS RANGE LEFT FOR VALUES ('2023-01-01', '2024-01-01');
   ```

<!-- START BADGE -->
<div align="center">
  <img src="https://img.shields.io/badge/Total%20views-31-limegreen" alt="Total views">
  <p>Refresh Date: 2025-07-16</p>
</div>
<!-- END BADGE -->
