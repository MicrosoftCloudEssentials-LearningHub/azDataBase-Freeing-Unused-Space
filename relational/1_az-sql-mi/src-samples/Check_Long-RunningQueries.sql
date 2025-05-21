  -- Check for long-running queries
  SELECT 
      session_id, 
      start_time, 
      status, 
      command, 
      wait_type, 
      wait_time, 
      blocking_session_id
  FROM 
      sys.dm_exec_requests
  WHERE 
      status = 'running'
  ORDER BY
