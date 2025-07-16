# Azure Database for PostgreSQL: <br/> Freeing Up Unused Space - Overview 

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com) 
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-07-16

----------

> To maintain SQL Server on Azure VMs, you can:

<details>
<summary><b>Table of Content </b> (Click to expand)</summary>

- [Partitioning Tables](#partitioning-tables)
- [Index Optimization](#index-optimization)
- [Archiving Old Data](#archiving-old-data)

</details>

## Partitioning Tables

> Use PostgreSQL's native partitioning features to manage large tables:

 ```sql
 CREATE TABLE measurement_y2023m01 PARTITION OF measurement FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');
 ```

## Index Optimization

> Regularly rebuild or reorganize indexes to maintain performance:

 ```sql
 REINDEX TABLE YourTableName;
 ```

## Archiving Old Data

> Move old data to an archive database using PostgreSQL's built-in tools or third-party solutions.

<!-- START BADGE -->
<div align="center">
  <img src="https://img.shields.io/badge/Total%20views-31-limegreen" alt="Total views">
  <p>Refresh Date: 2025-07-16</p>
</div>
<!-- END BADGE -->
