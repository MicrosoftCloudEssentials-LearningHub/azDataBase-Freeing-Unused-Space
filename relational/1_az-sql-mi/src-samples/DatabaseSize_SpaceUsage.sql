WITH SpaceInfo AS (
    SELECT 
        file_id,
        type_desc,
        name AS file_name,
        physical_name,
        size * 8 / 1024 AS size_mb,
        FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024 AS space_used_mb
    FROM 
        sys.database_files
)
SELECT 
    db_name.database_name,
    SUM(size_mb) AS total_size_mb,
    SUM(space_used_mb) AS used_space_mb,
    SUM(size_mb) - SUM(space_used_mb) AS free_space_mb
FROM 
    SpaceInfo,
    (SELECT DB_NAME() AS database_name) AS db_name
GROUP BY 
    db_name.database_name;
