index_raw = LOAD '/user/hue/NDX-100.csv' USING PigStorage(',') AS 
(date, open, high, low, close, volume, adj_close);

index_values = FOREACH index_raw GENERATE date, high, low;

DUMP index_values;