SELECT 
      OBJECT_NAME(i.object_id) AS table_name,
      i.name AS index_name,
      i.type_desc AS index_type,
      SUM(a.used_pages) * 8 / 1024.0 AS index_size_mb
  FROM 
      sys.indexes AS i
      JOIN sys.partitions AS p ON i.object_id = p.object_id AND i.index_id = p.index_id
      JOIN sys.allocation_units AS a ON p.partition_id = a.container_id
  GROUP BY 
      i.object_id, i.index_id, i.name, i.type_desc
  ORDER BY 
      index_size_mb DESC;
