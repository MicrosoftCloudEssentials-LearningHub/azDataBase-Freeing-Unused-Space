-- Calculate the total size, used space, and free space for each filegroup
SELECT 
    fg.name AS filegroup_name,
    SUM(df.size * 8 / 1024.0) AS total_size_mb,
    SUM(df.size * 8 / 1024.0) - SUM(a.total_pages * 8 / 1024.0) AS free_space_mb,
    SUM(a.total_pages * 8 / 1024.0) AS used_space_mb
FROM 
    sys.filegroups AS fg
JOIN 
    sys.database_files AS df ON fg.data_space_id = df.data_space_id
JOIN 
    sys.allocation_units AS a ON df.data_space_id = a.data_space_id
GROUP BY 
    fg.name
ORDER BY 
    total_size_mb DESC;
