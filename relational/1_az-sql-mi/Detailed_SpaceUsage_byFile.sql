WITH CTE AS (
    SELECT 
        file_id,
        name AS file_name,
        type_desc AS file_type,
        physical_name,
        CAST(FILEPROPERTY(name, 'SpaceUsed') AS bigint) * 8 / 1024.0 AS space_used_mb,
        CAST(size AS bigint) * 8 / 1024.0 AS space_allocated_mb,
        CAST(max_size AS bigint) * 8 / 1024.0 AS max_size_mb,
        growth,
        CASE 
            WHEN is_percent_growth = 1 THEN 'Percentage'
            ELSE 'MB'
        END AS growth_type
    FROM sys.database_files
)
SELECT 
    file_id,
    file_name,
    file_type,
    physical_name,
    space_used_mb,
    space_allocated_mb,
    max_size_mb,
    growth,
    growth_type,
    space_used_mb / space_allocated_mb * 100 AS [Occupancy %],
    100 - (space_used_mb / space_allocated_mb * 100) AS [Free %]
FROM CTE
ORDER BY [Occupancy %];
