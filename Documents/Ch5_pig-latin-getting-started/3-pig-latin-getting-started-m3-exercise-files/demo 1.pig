index_raw = LOAD '/user/hue/NDX-100.csv' USING PigStorage(',') AS 
(date, open, high, low, close, volume, adj_close);

index_values = FOREACH index_raw GENERATE date, high, low, volume;

filtered_high = FILTER index_values BY high > 4440;

grouped_results = GROUP filtered_high BY high;

STORE grouped_results INTO 'grouped_results';
-----

index_raw = LOAD '/user/hue/NDX-100.csv' USING PigStorage(',') AS 
(date, open, high, low, close, volume, adj_close);

index_values = FOREACH index_raw GENERATE date, high, low, volume;

STORE index_values INTO 'index-values' USING PigStorage(':');

----

index_raw = LOAD '/user/hue/NDX-100.csv' USING PigStorage(',') AS 
(date, open, high, low, close, volume, adj_close);

index_values = FOREACH index_raw GENERATE date, high, low, volume;

STORE index_values INTO 'index-values' USING PigStorage('\t');