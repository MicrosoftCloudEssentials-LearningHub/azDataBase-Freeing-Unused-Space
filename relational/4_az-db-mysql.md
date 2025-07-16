# Azure Database for MySQL: <br/> Freeing Up Unused Space - Overview 

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com) 
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-07-16

----------

> To optimize Azure Database for MySQL, you can:

<details>
<summary><b>Table of Content </b> (Click to expand)</summary>

- [Data Compression](#data-compression)
- [Index Optimization](#index-optimization)
- [Cleaning Up Unused Data](#cleaning-up-unused-data)

</details>

## Data Compression

> Use MySQL's compression features to save space:

 ```sql
 ALTER TABLE YourTableName ROW_FORMAT=COMPRESSED;
 ```

## Index Optimization

> Regularly rebuild or reorganize indexes to keep the database performing well:

```sql
OPTIMIZE TABLE YourTableName;
```

## Cleaning Up Unused Data

> Regularly delete or archive obsolete data to maintain database efficiency.

<!-- START BADGE -->
<div align="center">
  <img src="https://img.shields.io/badge/Total%20views-55-limegreen" alt="Total views">
  <p>Refresh Date: 2025-07-16</p>
</div>
<!-- END BADGE -->
