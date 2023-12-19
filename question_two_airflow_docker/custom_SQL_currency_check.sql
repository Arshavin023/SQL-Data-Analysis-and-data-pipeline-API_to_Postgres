truncate staging.Nigeria;
truncate staging.Ghana;
truncate staging.Egypt;
truncate staging.Morocco;
truncate staging.Ivory_Coast;
truncate staging.Kenya;
truncate staging.Uganda;

select currency_from, currency_to, usd_to_currency_rate,timestamp, currency_to_usd_rate from staging.Ghana
union all
select currency_from, currency_to, usd_to_currency_rate,timestamp, currency_to_usd_rate from staging.Uganda
union all
select currency_from, currency_to, usd_to_currency_rate,timestamp,currency_to_usd_rate from staging.Morocco
union all
select currency_from, currency_to, usd_to_currency_rate,timestamp,currency_to_usd_rate from staging.Nigeria
union all 
select currency_from, currency_to, usd_to_currency_rate,timestamp,currency_to_usd_rate from staging.Ivory_Coast
union all
select currency_from, currency_to, usd_to_currency_rate,timestamp,currency_to_usd_rate from staging.Egypt
union all 
select currency_from, currency_to, usd_to_currency_rate,timestamp,currency_to_usd_rate from staging.Kenya

