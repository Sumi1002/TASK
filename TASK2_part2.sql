
SELECT
  ct.instrument_id,
  ct.event_timestamp,
  tv1.gamma AS gamma_5s,
  tv2.gamma AS gamma_1m,
  tv3.gamma AS gamma_30m,
  tv4.gamma AS gamma_60m,
  tv1.vega AS vega_5s,
  tv2.vega AS vega_1m,
  tv3.vega AS vega_30m,
  tv4.vega AS vega_60m,
  tv1.theta AS theta_5s,
  tv2.theta AS theta_1m,
  tv3.theta AS theta_30m,
  tv4.theta AS theta_60m
FROM closest_times ct

LEFT JOIN trade_values tv1
ON ct.instrument_id = tv1.instrument_id
AND ct.closest_5_sec = tv1.when_timestamp

LEFT JOIN trade_values tv2
ON ct.instrument_id = tv2.instrument_id
AND ct.closest_1_minute = tv2.when_timestamp

LEFT JOIN trade_values tv3
ON ct.instrument_id = tv3.instrument_id
AND ct.closest_30_minute = tv3.when_timestamp

LEFT JOIN trade_values tv4
ON ct.instrument_id = tv4.instrument_id
AND ct.closest_60_minute = tv4.when_timestamp

LIMIT 100