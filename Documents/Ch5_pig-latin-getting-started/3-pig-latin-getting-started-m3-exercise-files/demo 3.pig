index_raw = LOAD '/user/hue/NDX-100.csv' USING PigStorage(',') AS 
(date: datetime, open: int, high: int, low: int, close:int, volume:int, adj_close: int);

index_final = FOREACH index_raw GENERATE ToString(date, 'yyyyMMdd') AS date, high, low;

weather_raw = LOAD '/user/hue/weather.csv' USING PigStorage(',') AS 
(id:chararray, name:chararray, date:datetime, day_high:int, day_low:int);

weather_final = FOREACH weather_raw GENERATE ToString(date, 'yyyyMMdd') AS date, day_high, day_low;

final = JOIN index_final BY date, weather_final BY date;

--DUMP final

STORE final INTO 'compared_results' USING PigStorage(',');