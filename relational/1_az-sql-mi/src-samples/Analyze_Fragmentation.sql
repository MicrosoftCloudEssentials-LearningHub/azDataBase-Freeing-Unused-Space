SELECT 
    S.name AS 'Schema', 
    T.name AS 'Table', 
    I.name AS 'Index', 
    I.type_desc AS 'Index Type',
    DDIPS.index_type_desc AS 'Index Level',
    DDIPS.alloc_unit_type_desc AS 'Allocation Unit Type',
    DDIPS.avg_fragmentation_in_percent AS 'Fragmentation (%)', 
    DDIPS.page_count AS 'Page Count',
    (DDIPS.page_count * 8 / 1024) AS 'Index Size (MB)'
FROM 
    sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'DETAILED') AS DDIPS
INNER JOIN 
    sys.tables T ON T.object_id = DDIPS.object_id 
INNER JOIN 
    sys.schemas S ON T.schema_id = S.schema_id 
INNER JOIN 
    sys.indexes I ON I.object_id = DDIPS.object_id
WHERE 
    DDIPS.index_id > 0
ORDER BY 
    DDIPS.avg_fragmentation_in_percent DESC;
