- Create a temporary table to store the results
  CREATE TABLE #SpaceUsed (
      TableName NVARCHAR(256),
      [Rows] INT,
      Reserved VARCHAR(50),
      Data VARCHAR(50),
      IndexSize VARCHAR(50),
      Unused VARCHAR(50),
      [Free %] FLOAT
  );
  
  DECLARE @TableName NVARCHAR(256);
  
  DECLARE TableCursor CURSOR FOR
  SELECT QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name)
  FROM sys.tables;
  
  OPEN TableCursor;
  FETCH NEXT FROM TableCursor INTO @TableName;
  
  WHILE @@FETCH_STATUS = 0
  BEGIN
      INSERT INTO #SpaceUsed (TableName, [Rows], Reserved, Data, IndexSize, Unused)
      EXEC sp_spaceused @TableName;
  
      FETCH NEXT FROM TableCursor INTO @TableName;
  END;
  
  CLOSE TableCursor;
  DEALLOCATE TableCursor;
  
  -- Use a CTE to calculate the Free %
  WITH CTE AS (
      SELECT 
          TableName,
          [Rows],
          CAST(REPLACE(Reserved, ' KB', '') AS FLOAT) AS ReservedKB,
          CAST(REPLACE(Data, ' KB', '') AS FLOAT) AS DataKB,
          CAST(REPLACE(IndexSize, ' KB', '') AS FLOAT) AS IndexSizeKB,
          CAST(REPLACE(Unused, ' KB', '') AS FLOAT) AS UnusedKB
      FROM #SpaceUsed
  )
  UPDATE #SpaceUsed
  SET [Free %] = 
      CASE 
          WHEN ReservedKB = 0 THEN 0
          ELSE (UnusedKB / ReservedKB) * 100
      END
  FROM CTE
  WHERE #SpaceUsed.TableName = CTE.TableName;
  
  -- Select the results from the temporary table
  SELECT * FROM #SpaceUsed
  ORDER BY TableName;
  
  -- Drop the temporary table
  DROP TABLE #SpaceUsed;
