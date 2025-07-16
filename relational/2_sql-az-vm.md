# SQL Server on Azure Virtual Machines: <br/> Freeing Up Unused Space - Overview 

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com) 
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-07-16

----------

> To maintain SQL Server on Azure VMs, you can:

<details>
<summary><b>Table of Content </b> (Click to expand)</summary>

- [Cleaning Up Unused Data](#cleaning-up-unused-data)
- [Monitoring and Maintenance](#monitoring-and-maintenance)
- [Data Compression](#data-compression)

</details>

## Cleaning Up Unused Data

> Regularly delete or archive obsolete data to free up space.

## Monitoring and Maintenance

> Use built-in monitoring tools and maintenance plans, such as SQL Server Management Studio (SSMS) or Azure Monitor.

## Data Compression

> Apply compression techniques to tables and indexes:

 ```sql
 ALTER TABLE YourTableName REBUILD WITH (DATA_COMPRESSION = PAGE);
 ```

<!-- START BADGE -->
<div align="center">
  <img src="https://img.shields.io/badge/Total%20views-31-limegreen" alt="Total views">
  <p>Refresh Date: 2025-07-16</p>
</div>
<!-- END BADGE -->
