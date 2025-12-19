-- KPI #1 — Completion Rate
-- A visit is complete if it reaches 'confirm'
SELECT x.Variation,
       COUNT(DISTINCT e.visit_id) AS total_visits,
       COUNT(DISTINCT CASE WHEN e.process_step = 'confirm' THEN e.visit_id END) 
         AS completed_visits,
       ROUND(
         COUNT(DISTINCT CASE WHEN e.process_step = 'confirm' THEN e.visit_id END)
         / COUNT(DISTINCT e.visit_id), 3
       ) AS completion_rate
FROM web e
JOIN exp x
    ON e.client_id = x.client_id
GROUP BY x.Variation;

-- KPI #2 — Time Spent on Each Step
-- Sort events by time, take time difference to next step.
WITH sorted AS (
  SELECT
      x.Variation,
      e.visit_id,
      e.process_step,
      e.date_time,
      LEAD(e.date_time) OVER (PARTITION BY e.visit_id ORDER BY e.date_time) AS next_time
  FROM web e
  JOIN exp x
      ON e.client_id = x.client_id
),
dur AS (
  SELECT
      Variation,
      process_step,
      TIMESTAMPDIFF(SECOND, date_time, next_time) AS duration_seconds
  FROM sorted
  WHERE next_time IS NOT NULL
)
SELECT
    Variation,
    process_step,
    ROUND(AVG(duration_seconds), 1) AS avg_time_seconds
FROM dur
GROUP BY Variation, process_step
ORDER BY process_step, Variation;

-- KPI #3 — Error Rate
WITH ordered AS (
  SELECT
      x.Variation,
      e.visit_id,
      e.date_time,
      CASE e.process_step
          WHEN 'start' THEN 1
          WHEN 'details' THEN 2
          WHEN 'payment' THEN 3
          WHEN 'confirm' THEN 4
      END AS step_order
  FROM web e
  JOIN exp x
      ON e.client_id = x.client_id
),
flag AS (
  SELECT
      Variation,
      visit_id,
      CASE WHEN step_order < LAG(step_order) OVER (PARTITION BY visit_id ORDER BY date_time)
           THEN 1 ELSE 0 END AS error_flag
  FROM ordered
)
SELECT
    Variation,
    ROUND(SUM(error_flag) * 1.0 / COUNT(DISTINCT visit_id), 3) AS error_rate
FROM flag
GROUP BY Variation;


-- Create summary tables in SQL

-- Completion rate summary
CREATE TABLE completion_rate_summary AS
SELECT Variation,
       ROUND(COUNT(CASE WHEN process_step='confirm' THEN visit_id END) * 1.0
             / COUNT(DISTINCT visit_id), 3) AS completion_rate
FROM web e
JOIN exp x ON e.client_id = x.client_id
GROUP BY Variation;

-- Avg time per step summary
CREATE TABLE avg_time_per_step_summary AS
WITH sorted AS (
  SELECT x.Variation, e.visit_id, e.process_step, e.date_time,
         LEAD(e.date_time) OVER (PARTITION BY e.visit_id ORDER BY e.date_time) AS next_time
  FROM web e
  JOIN exp x ON e.client_id = x.client_id
)
SELECT Variation, process_step, ROUND(AVG(TIMESTAMPDIFF(SECOND, date_time, next_time)),1) AS avg_time_seconds
FROM sorted
WHERE next_time IS NOT NULL
GROUP BY Variation, process_step;

-- Error rate summary
CREATE TABLE error_rate_summary AS
WITH ordered AS (
  SELECT x.Variation, e.visit_id, e.date_time,
         CASE e.process_step
           WHEN 'start' THEN 1
           WHEN 'details' THEN 2
           WHEN 'payment' THEN 3
           WHEN 'confirm' THEN 4
         END AS step_order
  FROM web e
  JOIN exp x ON e.client_id = x.client_id
),
flag AS (
  SELECT Variation, visit_id,
         CASE WHEN step_order < LAG(step_order) OVER (PARTITION BY visit_id ORDER BY date_time)
              THEN 1 ELSE 0 END AS error_flag
  FROM ordered
)
SELECT Variation, ROUND(SUM(error_flag)*1.0/COUNT(DISTINCT visit_id),3) AS error_rate
FROM flag
GROUP BY Variation;

SHOW TABLES;

DESCRIBE demo;
DESCRIBE exp;
DESCRIBE web;

SHOW COLUMNS FROM demo;

CREATE TABLE navigation AS
SELECT 
    w.client_id,
    e.Variation,
    w.visit_id,
    w.process_step,
    w.date_time
FROM web w
LEFT JOIN exp e
USING(client_id);

-- KPI 1 — Completion Rate
-- reached final step = 'confirm'
SELECT 
    Variation,
    COUNT(DISTINCT client_id) AS total_clients,
    COUNT(DISTINCT CASE WHEN process_step = 'confirm' THEN client_id END) AS completed_clients,
    COUNT(DISTINCT CASE WHEN process_step = 'confirm' THEN client_id END) * 1.0 /
    COUNT(DISTINCT client_id) AS completion_rate
FROM navigation
GROUP BY Variation;

-- KPI 2 — Time Spent per Step
-- We calculate time difference between steps for each client + visit.
SELECT
    Variation,
    process_step,
    AVG(time_to_next) AS avg_seconds
FROM (
    SELECT
        client_id,
        Variation,
        process_step,
        TIMESTAMPDIFF(SECOND, date_time,
            LEAD(date_time) OVER (
                PARTITION BY client_id, visit_id
                ORDER BY date_time
            )
        ) AS time_to_next
    FROM navigation
) t
WHERE time_to_next IS NOT NULL
GROUP BY Variation, process_step;

-- KPI 3 — Error Rate
-- moving from later → earlier step
-- order = initial → step_1 → step_2 → step_3 → confirm
-- We detect decreasing sequence.
SELECT
    Variation,
    COUNT(*) AS total_errors,
    COUNT(*) * 1.0 / COUNT(DISTINCT client_id) AS error_rate
FROM (
    SELECT 
        client_id,
        Variation,
        process_step,
        LAG(process_step) OVER (
            PARTITION BY client_id, visit_id
            ORDER BY date_time
        ) AS prev_step
    FROM navigation
) t
WHERE 
    prev_step IS NOT NULL
    AND process_step < prev_step
GROUP BY Variation;








