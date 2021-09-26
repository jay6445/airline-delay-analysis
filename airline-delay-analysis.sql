use airline_delays;
select * from airlines;

-- Total Number of Flights cancelled,delayed,diverted and on time Overall between 2003 and 2016
CREATE TABLE overall_flight_data (SELECT '2003 - 2016' AS period,
    ROUND(SUM(flights_cancelled), 0) AS cancelled,
    ROUND(SUM(flights_delayed), 0) AS 'delayed',
    ROUND(SUM(flights_diverted), 0) AS diverted,
    ROUND(SUM(flights_on_time), 0) AS on_time FROM
    airlines)
;
-- 10 million flights were delayed, let us check what caused the delay

-- Overall Total flight delays according to delay categories between 2003 and 2016
CREATE TABLE overall_flight_delay_data (SELECT '2003 - 2016' AS period,
    ROUND(SUM(delays_carrier), 0) AS carrier_delays,
    ROUND(SUM(delays_late_aircraft), 0) AS late_aircrafts,
    ROUND(SUM(delays_national_aviation_system), 0) AS national_aviation_system_delays,
    ROUND(SUM(delays_security), 0) AS security_delays,
    ROUND(SUM(delays_weather), 0) AS weather_delays FROM
    airlines);
    
-- Highest number of delays were due to national aviation system delays followed by late aircraft, carrier delays, 
-- weather and security_delays is the least likely cause.

-- Splitting the delays into average of months of the year to check if the delays depend on the months of the year 

-- Average Number of Flights Delayed per Year and Month by Reason

CREATE TABLE avg_delay_count_by_month_year (SELECT time_year,
    time_month_name,
    ROUND(AVG(delays_carrier), 0) AS avg_carrier_delays,
    ROUND(AVG(delays_late_aircraft), 0) AS avg_late_aircrafts,
    ROUND(AVG(delays_national_aviation_system), 0) AS avg_national_aviation_system_delays,
    ROUND(AVG(delays_security), 0) AS avg_security_delays,
    ROUND(AVG(delays_weather), 0) AS avg_weather_delays,
    ROUND(AVG(flights_delayed), 0) AS avg_total_flights_delayed FROM
    airlines
GROUP BY time_month_name , time_year
ORDER BY time_year ASC);

-- Average Duration of Delay per Year and Month by Reason (in hours)

CREATE TABLE avg_delay_duration_by_month_year (SELECT time_year,
    time_month_name,
    ROUND(AVG(minutes_delayed_carrier) / 60, 0) AS avg_hours_delayed_carrier,
    ROUND(AVG(minutes_delayed_late_aircraft) / 60,
            0) AS avg_hours_delayed_late_aircraft,
    ROUND(AVG(minutes_delayed_national_aviation_system) / 60,
            0) AS avg_hours_delayed_national_aviation_system,
    ROUND(AVG(minutes_delayed_security) / 60, 0) AS avg_hours_delayed_security,
    ROUND(AVG(minutes_delayed_weather) / 60, 0) AS avg_hours_delayed_weather,
    ROUND(AVG(minutes_delayed_total) / 60, 0) AS avg_hours_delayed_total FROM
    airlines
GROUP BY time_month_name , time_year
ORDER BY time_year ASC);

-- Are these delays related to the airport?

-- Average delays per airport split by delay reasons

select * from airlines;

CREATE TABLE avg_delay_count_by_airport (SELECT airport_code,
    airport_name,
    ROUND(AVG(delays_carrier), 0) AS avg_carrier_delays,
    ROUND(AVG(delays_late_aircraft), 0) AS avg_late_aircrafts,
    ROUND(AVG(delays_national_aviation_system), 0) AS avg_national_aviation_system_delays,
    ROUND(AVG(delays_security), 0) AS avg_security_delays,
    ROUND(AVG(delays_weather), 0) AS avg_weather_delays,
    ROUND(AVG(flights_delayed), 0) AS avg_total_flights_delayed FROM
    airlines
GROUP BY airport_code , airport_name);