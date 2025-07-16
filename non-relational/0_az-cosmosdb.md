# Azure Cosmos DB: <br/> Freeing Up Unused Space - Overview 

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com) 
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-07-16

----------

> A globally distributed, multi-model database service.

<details>
<summary><b>Table of Content </b> (Click to expand)</summary>

- [Partitioning](#partitioning)
- [Index Optimization](#index-optimization)
- [Archiving Old Data](#archiving-old-data)

</details>

## Partitioning

> Use automatic partitioning to manage large datasets. Cosmos DB automatically partitions data based on the partition key you define. Ensure your partition key is chosen to evenly distribute data.

## Index Optimization

> Customize indexing policies to optimize performance. Customize indexing policies using the Azure Portal or SDK. Example:

 ```json
 {
   "indexingMode": "consistent",
   "automatic": true,
   "includedPaths": [
     { "path": "/*" }
   ],
   "excludedPaths": [
     { "path": "/\"_etag\"/?" }
   ]
 }
 ```

## Archiving Old Data

> Move old data to an archive database. Use Azure Data Factory to move old data to an archive storage solution.

<!-- START BADGE -->
<div align="center">
  <img src="https://img.shields.io/badge/Total%20views-31-limegreen" alt="Total views">
  <p>Refresh Date: 2025-07-16</p>
</div>
<!-- END BADGE -->
