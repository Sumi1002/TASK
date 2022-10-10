DROP TABLE IF EXISTS closest_times;

CREATE TABLE closest_times AS 
SELECT 
  a.instrument_id,
  a.event_timestamp,
  MAX(
    CASE 
	  WHEN 
  		EXTRACT(
	  		EPOCH FROM (
		  		event_timestamp + interval '5 second' - when_timestamp
	 		 )) >= 0 
	  THEN when_timestamp
	END) AS closest_5_sec,
  MAX(
    CASE 
	  WHEN 
  		EXTRACT(
	  		EPOCH FROM (
		  		event_timestamp + interval '1 minute' - when_timestamp
	 		 )) >= 0 
	  THEN when_timestamp
	END) AS closest_1_minute,
  MAX(
    CASE 
	  WHEN 
  		EXTRACT(
	  		EPOCH FROM (
		  		event_timestamp + interval '30 minute' - when_timestamp
	 		 )) >= 0 
	  THEN when_timestamp
	END) AS closest_30_minute,
  MAX(
    CASE 
	  WHEN 
  		EXTRACT(
	  		EPOCH FROM (
		  		event_timestamp + interval '60 minute' - when_timestamp
	 		 )) >= 0 
	  THEN when_timestamp
	END) AS closest_60_minute
FROM trades a 

INNER JOIN trade_values b 
ON a.instrument_id = b.instrument_id
AND b.when_timestamp > a.event_timestamp
AND b.when_timestamp <= a.event_timestamp + interval '60 minute'

GROUP BY 
  a.instrument_id,
  a.event_timestamp