# Azure SQL Managed Instance: <br/> Freeing Up Unused Space - Overview 

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com) 
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-05-21

----------

For Azure SQL Managed Instance, consider these strategies:

> - DBCC SHRINKFILE: Shrinks a specific database file by moving data pages and reducing the file size. <br/>
> - DBCC SHRINKFILE (TRUNCATEONLY): Releases unused space at the end of a specific file without moving data pages.
> - DBCC SHRINKDATABASE: Shrinks all data and log files in a database by moving data pages and reducing the overall size. <br/>

<details>
<summary><b> List of References </b> (Click to expand)</summary>

- [Microsoft Learn - Maintaining indexes optimally to improve performance and reduce resource utilization](https://learn.microsoft.com/en-us/sql/relational-databases/indexes/reorganize-and-rebuild-indexes?view=sql-server-ver16)
    
</details>

<details>
<summary><b> Table of Content </b> (Click to expand)</summary>

- [Gather more detailed information](#gather-more-detailed-information)
  - [Detailed Space Usage by File](#detailed-space-usage-by-file)
  - [Space Usage by Table](#space-usage-by-table)
  - [Space Usage by Index](#space-usage-by-index)
  - [Database Size and Space Usage](#database-size-and-space-usage)
  - [Filegroup Space Usage](#filegroup-space-usage)
- [Shrink the Database File](#shrink-the-database-file)
- [Monitor the Shrink Operation](#monitor-the-shrink-operation)
- [Check for Active Transactions](#check-for-active-transactions)
- [Check for Long-Running Queries](#check-for-long-running-queries)
- [Shrinking the Database](#shrinking-the-database)
- [Archiving Old Data](#archiving-old-data)
- [Removing Unused Indexes](#removing-unused-indexes)
- [Using Filegroups](#using-filegroups)
- [Fragmentation](#fragmentation)
  - [Measuring Fragmentation](#measuring-fragmentation)
  - [How to resolve it](#how-to-resolve-it)
  - [Automating Maintenance in Azure SQL Managed Instance](#automating-maintenance-in-azure-sql-managed-instance)
    
</details>

## Gather more detailed information

> Gather more detailed information about the current used and allocated space in your database

### Detailed Space Usage by File

> This query provides detailed information about each file, including the file name, type, growth settings, and more. Click [here view a Detailed Space Usage by File sample script](./src-samples/DetailedSpaceUsage_byFile.sql)

| **Category**       | **Recommendation**                                                                                                                                                                                                 |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **LOG Files**      | - **Free Space**: Maintain at least 25-30% free space in your log files. This ensures there is enough room for transaction logs to grow and prevents the database from running out of space during peak operations.<br>- **Monitoring**: Use the `sys.dm_db_log_space_usage`. Regularly check the percentage of log space used to avoid unexpected issues.<br>- **Maintenance**: Regularly back up your transaction logs to truncate inactive portions and free up space. |
| **ROWS (Data Files)** | - **Free Space**: Aim to keep around 20-25% free space in your data files. This allows for growth and helps avoid performance issues related to frequent auto-growth events.<br>- **Auto-Growth Settings**: Configure auto-growth settings appropriately to avoid frequent small growths. Setting a fixed size for growth (e.g., 500 MB or 1 GB) is often better than a percentage-based growth.<br>- **Monitoring**: Use the `sys.database_files` view to monitor the size and free space of your data files. |
| **FILESTREAM Data** | - **Free Space**: Ensure there is sufficient free space on the disk where the FILESTREAM data is stored. A good rule of thumb is to keep at least 20% free space.<br>- **Disk Monitoring**: Regularly monitor the disk space and set up alerts to notify you when free space falls below a certain threshold.<br>- **Maintenance**: Regularly clean up old or unused FILESTREAM data to free up space. |

<div align="center">
  <img width="1100" alt="image" src="https://github.com/user-attachments/assets/b6ca6507-668c-427c-b01a-6a66e7e0fedd" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

### Space Usage by Table

> This query provides information about space usage at the table level, including the number of rows, reserved space, data space, index space, and unused space. Will iterate through all tables in your database and execute sp_spaceused for each one. Click [here view a Space Usage by Table sample script](./src-samples/SpaceUsage_byTable.sql)

| **Aspect**            | **Recommendation**|
|-----------------------|---------------------------------------------------|
| **Free Space**        | Maintain around 20-25% free space in your data files to accommodate table growth.|
| **Index Maintenance** | Regularly rebuild or reorganize indexes to optimize performance and reclaim space. Fragmented indexes can lead to inefficient space usage.|
| **Partitioning**      | Consider partitioning large tables to improve manageability and performance. This can also help in efficiently managing space.|
| **Archiving**         | Implement an archiving strategy for old or infrequently accessed data. This can free up space and improve performance for active data.|
| **Compression**       | Use data compression techniques to reduce the size of tables and indexes. SQL Server supports row and page compression, which can significantly reduce space usage.|

<div align="center">
  <img width="1100" alt="image" src="https://github.com/user-attachments/assets/401323a7-7ffc-4d6f-aade-96991793b677" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

### Space Usage by Index

> This query provides detailed information about space usage by indexes, including the index name, type, and space used. Click [here view a Space Usage by Index sample script](./src-samples/SpaceUsage_byIndex.sql)

<div align="center">
  <img width="1100" alt="image" src="https://github.com/user-attachments/assets/9e73aa43-59a8-412a-b8e1-757478050b8c" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

### Database Size and Space Usage

> This query provides an overview of the database size and space usage, including the total size, used space, and free space.  Click [here view a Database Size and Space Usage sample script](./src-samples/DatabaseSize_SpaceUsage.sql)

<div align="center">
  <img width="1100" alt="image" src="https://github.com/user-attachments/assets/bd6cbfa5-aec0-48d6-a8dc-440023bca0d0" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

### Filegroup Space Usage

> This query provides information about space usage by filegroups, including the filegroup name, total size, used space, and free space. Click [here view a Filegroup Space Usage sample script](./src-samples/Filegroup_SpaceUsage.sql)

<div align="center">
  <img width="1100" alt="image" src="https://github.com/user-attachments/assets/a7dce4f9-f32e-4b7e-bd92-d4709bd0ed7b" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

## Shrink the Database File

> [!TIP]
> Shrink files in parallel by opening multiple database sessions and running the `DBCC SHRINKFILE` command on each session with a different `file_id` value.

> Shrink the database file to reclaim unused space

| **Command**                      | **Description**                                                                 | **Syntax**                                                                                   | **Example**                                                                                   |
|----------------------------------|---------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| **DBCC SHRINKFILE**              | DBCC SHRINKFILE is used to shrink the size of a specific database file. This command attempts to move data pages from the end of the file to unoccupied space closer to the beginning of the file, thereby reducing the file size.            | `DBCC SHRINKFILE (file_id, target_size_in_MB);`                                              | `DBCC SHRINKFILE (1, 100);` -- Shrinks the file with ID 1 to 100 MB                       |
| **DBCC SHRINKFILE (TRUNCATEONLY)** | DBCC SHRINKFILE (TRUNCATEONLY) is a specific option for DBCC SHRINKFILE that releases all free space at the end of the file to the operating system without moving any data pages. This command is useful when you want to quickly release unused space without the overhead of moving data. | `DBCC SHRINKFILE (file_id, TRUNCATEONLY);`                                                   | `DBCC SHRINKFILE (1, TRUNCATEONLY);` -- Releases unused space at the end of the file with ID 1 |

```sql
-- Shrink the database file (replace 1 with your file_id)
DBCC SHRINKFILE (1);
```

  <img width="550" alt="image" src="https://github.com/user-attachments/assets/96c7be25-ade3-4851-a2cd-8735273c4c6f">

> If you specify a target size that is just enough to hold all the data pages, the result can be a file with no free space.

**Before Shrink:**

| $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{green}\text{Free Space}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{green}\text{Free Space}}$$ | $${\color{green}\text{Free Space}}$$ |

- **After Shrink with TRUNCATEONLY:** When you use DBCC SHRINKFILE with the TRUNCATEONLY option `DBCC SHRINKFILE (file_id, TRUNCATEONLY)`, it releases the unused space at the end of the file without moving any data pages. This means that the data pages remain in their original locations, and only the free space at the end of the file is released.

  | $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{green}\text{Free Space}}$$ | $${\color{red}\text{Data Page}}$$ |

  > If you don't move the pages, the space within the file might not be optimized because the data pages could be scattered throughout the file, leaving gaps of unused space in between. This can lead to fragmentation, where the data is not stored contiguously, potentially affecting performance. In this case, the free space at the end is released, but the data pages remain scattered, which might not be optimal for performance.

- After `DBCC SHRINKFILE (file_id, target_size_in_MB)`: In this case, the data pages are moved to fill the gaps, and the file is shrunk to the target size, eliminating free space.

    > The `target_percent_free_space`: parameter `defines the desired final size of the file after the shrink operation`. It indicates the final size in megabytes. For instance, setting target_size_in_MB to 2000 will reduce the file to 2000 MB. 

    | $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ |

> [!IMPORTANT]
>
> - After each shrink operation, monitor the file size and fragmentation. <br/>
> - Repeat the shrinking process in increments until you reach your desired target size.

## Monitor the Shrink Operation

> While the shrink operation is running, you can monitor for any blocking operations that might be affecting the process. Click [here view a Monitor the Shrink Operation sample script](./src-samples/DatabaseSize_SpaceUsage.sql)

<img width="350" alt="image" src="https://github.com/user-attachments/assets/0d724ca6-8ac1-478b-820d-7ae124af8937" />

## Check for Active Transactions

> Ensure there are no active transactions that might be preventing the shrink operation from completing.

 ```sql
 -- Check for active transactions
  DBCC OPENTRAN;
 ```

 <img width="350" alt="image" src="https://github.com/user-attachments/assets/5c64c734-4999-40a2-8333-40090e88e37b">

## Check for Long-Running Queries

> Identify any long-running queries that might be affecting the performance. Click [here view a Check for Long-Running Queries sample script](./src-samples/Check_Long-RunningQueries.sql)

<div align="center">
  <img width="1100" alt="image" src="https://github.com/user-attachments/assets/da27cedb-e113-4127-85c4-1ab10b9b09e6" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

## Shrinking the Database

> Reclaim unused space with. Shrink the entire database to leave `target_percent_free_space`% free space.

| **Command**                      | **Description**                                                                 | **Syntax**                                                                                   | **Example**                                                                                   |
|----------------------------------|---------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| **DBCC SHRINKDATABASE**          | DBCC SHRINKDATABASE is used to shrink the size of all data and log files in a database. This command attempts to move data pages from the end of the files to unoccupied space closer to the beginning of the files, thereby reducing the overall size of the database. `target_percent_free_space: The desired percentage of free space to remain in the database after the shrink operation.`  | `DBCC SHRINKDATABASE (database_name, target_percent_free_space);`                             | `DBCC SHRINKDATABASE (YourDatabaseName, 10);` -- Shrinks the database to leave 10% free space |

 ```sql
 DBCC SHRINKDATABASE (YourDatabaseName, 10);
 ```
 
  **Before Shrink:**
  
  | $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{green}\text{Free Space}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{green}\text{Free Space}}$$ | $${\color{green}\text{Free Space}}$$ |
  
  After `DBCC SHRINKDATABASE (database_name, target_percent_free_space)`: The data pages are moved to reduce fragmentation, and the file is shrunk to maintain a small percentage of free space.
  
  | $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{red}\text{Data Page}}$$ | $${\color{green}\text{Free Space}}$$ |

 <img width="550" alt="image" src="https://github.com/user-attachments/assets/f906adcd-732e-4efa-849c-90d8fed2e9d3">

 To check for blocking operations:

 ```sql
 SELECT blocking_session_id, wait_type, wait_time, wait_resource
 FROM sys.dm_exec_requests
 WHERE blocking_session_id <> 0;
 ```

## Archiving Old Data

> Move old data to an archive database using SQL Server's built-in tools or third-party solutions.

## Removing Unused Indexes

> Identify and remove indexes that are not being used.

 ```sql
 SELECT * FROM sys.dm_db_index_usage_stats WHERE user_seeks = 0 AND user_scans = 0 AND user_lookups = 0;
 ```

<img width="550" alt="image" src="https://github.com/user-attachments/assets/8e9dfe79-c4a7-40c8-9ae8-7210c35eb6f1">

## Using Filegroups

> Distribute objects across multiple filegroups to improve performance and manageability:

 ```sql
 CREATE TABLE YourTableName (...) ON [PrimaryFileGroup];
 ```

## Fragmentation 

> `Fragmentation` in Azure SQL Managed Instance, like in other SQL Server environments, refers to the `condition where the logical order of data pages in an index does not match the physical order on the disk`. This can lead to inefficient data retrieval and increased I/O operations. Fragmentation is generally categorized into two types: **internal fragmentation** and **external fragmentation**.

| Type of Fragmentation | Definition | Cause | Impact | Example |
|-----------------------|------------|-------|--------|---------|
| **Internal Fragmentation** | Unused space within index pages. | Typically caused by page splits, where a page is only partially filled after an insert or update operation. | Leads to wasted space and can reduce the efficiency of data storage. | A page split occurs when a new row is inserted into a full page, causing SQL Server to split the page into two, each partially filled. |
| **External Fragmentation** | Logical order of pages does not match the physical order on the disk. | Caused by frequent inserts, updates, and deletes that result in pages being out of order. | Causes the disk head to move more frequently, slowing down data access and increasing I/O operations. | When rows are inserted or updated, they may be placed in different physical locations, causing the logical sequence of pages to be disrupted. |

### Measuring Fragmentation

> Azure SQL Managed Instance provides the `sys.dm_db_index_physical_stats` dynamic management function to measure fragmentation. This function returns information about the physical storage of indexes, including the average fragmentation percentage.

Key Metrics:

- **avg_fragmentation_in_percent**: Indicates the percentage of logical fragmentation in the index. Higher values suggest more fragmentation.
- **page_count**: The number of pages in the index. Larger indexes with high fragmentation can significantly impact performance.

### How to resolve it 

1. **Rebuild Indexes**:
   - **Command**: `ALTER INDEX [IndexName] ON [SchemaName].[TableName] REBUILD;`
   - **Effect**: Drops and re-creates the index, removing fragmentation and compacting the pages.
2. **Reorganize Indexes**:
   - **Command**: `ALTER INDEX [IndexName] ON [SchemaName].[TableName] REORGANIZE;`
   - **Effect**: Defragments the leaf level of the index pages without dropping the index.
3. **Set Fill Factor**:
   - **Definition**: The fill factor setting determines how much space to leave free on each page during index creation or rebuild.
   - **Impact**: A lower fill factor can reduce fragmentation but may increase the number of pages.

### Automating Maintenance in Azure SQL Managed Instance

1. **Analyze Fragmentation**:  Use the following query to get detailed fragmentation information. Click [here view a Automating Maintenance in Azure SQL Managed Instance sample script](./src-samples/Analyze_Fragmentation.sql)

    <div align="center">
      <img width="1100" alt="image" src="https://github.com/user-attachments/assets/78a0afbb-c110-4a66-8ebd-0c79ef30485f" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
    </div>

2. **Rebuild or Reorganize Indexes**:

   - **Rebuild Indexes**: Drops and re-creates the index, removing fragmentation and compacting the pages.

     ```sql
     ALTER INDEX [IndexName] ON [SchemaName].[TableName] REBUILD;
     ```

     > E.g `ALTER INDEX [PK__People__3214EC27785B7549] ON [dbo].[People] REBUILD;`

    | Before Rebuilt index | After REBUILD| 
    | --- | --- |
    | <img width="550" alt="image" src="https://github.com/user-attachments/assets/78a0afbb-c110-4a66-8ebd-0c79ef30485f" /> | <img width="550" alt="image" src="https://github.com/user-attachments/assets/500f677b-5a2b-4616-a23b-01c0c6d86860" /> | 

   - **Reorganize Indexes**: Defragments the leaf level of the index pages without dropping the index.

    > E.g `ALTER INDEX [PK__RandomDa__3214EC2723C2100E] ON [dbo].[RandomData] REORGANIZE;`

     ```sql
     ALTER INDEX [IndexName] ON [SchemaName].[TableName] REORGANIZE;
     ```

    | Before Reorganize index | After REORGANIZE| 
    | --- | --- |
    | <img width="550" alt="image" src="https://github.com/user-attachments/assets/06baace1-33eb-4b7b-b7a6-28e4afe9e232" />  | <img width="650" alt="image" src="https://github.com/user-attachments/assets/64ce01bb-adb3-4f4a-81dc-4a93b9579023" /> | 

<!-- START BADGE -->
<div align="center">
  <img src="https://img.shields.io/badge/Total%20views-55-limegreen" alt="Total views">
  <p>Refresh Date: 2025-07-16</p>
</div>
<!-- END BADGE -->
