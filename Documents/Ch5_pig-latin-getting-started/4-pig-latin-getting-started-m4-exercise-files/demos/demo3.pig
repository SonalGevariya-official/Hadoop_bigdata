REGISTER piggybank.jar

weather_raw = LOAD '/user/hue/weather.csv' USING PigStorage(',') AS
(id: chararray, name:chararray, date:datetime, day_high:int, day_low:int);

weather_results = FOREACH weather_raw GENERATE org.apache.pig.piggybank.evaluation.string.LENGTH(name);

DUMP weather_results;