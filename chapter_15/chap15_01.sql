-- Scored once on arrival, so dashboards read a column instead of calling a model. 
-- Version 2.1 is pinned because an unversioned call can fall back to the legacy 1.0 interface. 

SELECT 
  ticket_id, 
  created_at, 
  ai_classify( 
    body, 
    '["billing", "outage", "feature_request"]', 
    MAP('version', '2.1') 
  ):response[0].value::STRING AS category, 
  ai_summarize(body, 40) AS short_summary 
FROM STREAM(retail.silver.support_tickets); 
