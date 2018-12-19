--Demo module 2 
--ensure file path is correct
index_raw = LOAD '~/Sonali_Data/Git Data/Hadoop_bigdata/Documents/Ch5_pig-latin-getting-started/2-pig-latin-getting-started-m2-exercise-files/demos/NDX-100.csv' USING PigStorage(',') AS ( date, open, high, low, close, volume, adj_close);

index_values = FOREACH index_raw GENERATE (date, high, low, volume);

filtered_high = FILTER index_raw BY high > 4440;

results_10 = LIMIT filtered_high 10;

--grouped_results  = GROUP filtered_high BY high;

DUMP results_10;

