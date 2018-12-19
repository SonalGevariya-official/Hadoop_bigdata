
############################ 1 #######################################

airport_data = load 'airports_mod.dat' using PigStorage(',')
as
(
airport_id: int,
airport_name: chararray,
airport_city: chararray,
airport_country: chararray,
airport_letter_code3: chararray,
bank: chararray,
airport_icao: chararray,
latitude: double,
lontitude: double,
altitude: double,
timezone: double,
dst: chararray,
tz: chararray
);

india_airport = filter airport_data by airport_country matches 'India'; 

india_airport_list = foreach india_airport generate airport_name, airport_country;

india_airport_distinct_list = distinct india_airport_list;

sorted_list = order india_airport_distinct_list by airport_name desc;

dump india_airport_distinct_list;

store india_airport_distinct_list into 'output' using PigStorage('\t','-schema');

############################ 2 #######################################


airlines_data = load 'Final_airlines' using PigStorage(',')
as
(
airline_id: int,
airline_name: chararray,
airline_alias_name: chararray,
airline_iata: chararray,
airline_icao: chararray,
callsign: chararray,
airline_country: chararray,
active_status: chararray
);


dump airlines_data;

############################ 3 #######################################

route_data = load 'routes.dat' using PigStorage(',')
as
(
airline_code: chararray,
airline_id: int,
source_airport_code: chararray,
source_airport_id: int,
dest_airport_code: chararray,
dest_airport_id: int,
codeshare_status: chararray,
stops: int,
equipment: chararray
);

dump route_data;


################### 1 & 3 #####################################
 

2)

airline_routs = JOIN airlines_data BY airline_id, route_data BY airline_id ;

zero_stops = filter airline_routs by stops == 0 ; 

zero_stop_airline = foreach zero_stops generate airline_name;

zero_stop_airport_distinct_list = distinct zero_stop_airline;

dump zero_stop_airport_distinct_list;

store zero_stop_airport_distinct_list into 'output2' using PigStorage('\t','-schema');

##################################################################

3)
available_codeshare = filter airline_routs by codeshare_status is not null; 

codeshare_airline = foreach available_codeshare generate airline_name;

codeshare_airline_distinct_list = distinct codeshare_airline;

dump codeshare_airline_distinct_list;

store codeshare_airline_distinct_list into 'output3' using PigStorage('\t','-schema');

###################################################################

4)

airport_by_country = group airport_data by airport_country ;

dump airport_by_country;

total_airport_by_country = foreach airport_by_country generate COUNT(airport_data.airport_country) as total_airport, airport_data.airport_country;

dump total_airport_by_country;
  
sorted_airport_by_country = order total_airport_by_country by total_airport desc;

max_airport_by_country = LIMIT sorted_airport_by_country 1;

dump max_airport_by_country;

store max_airport_by_country into 'output4' using PigStorage('\t','-schema');

##################################################################

5)

united_states_airlines = filter airlines_data by airline_country matches 'United States' AND active_status matches 'Y'; 

united_states_airlines_list = foreach united_states_airlines generate airline_name, airline_country, active_status;

united_states_airlines_distinct_list = distinct united_states_airlines_list;


dump united_states_airlines_distinct_list;

store united_states_airlines_distinct_list into 'output5' using PigStorage('\t','-schema');


