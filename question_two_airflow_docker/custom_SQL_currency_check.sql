truncate staging.Nigeria;
truncate staging.Ghana;
truncate staging.Egypt;
truncate staging.Morocco;
truncate staging.Ivory_Coast;
truncate staging.Kenya;
truncate staging.Uganda;

select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Ghana
group by 1,2,3,4
union all
select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Uganda
group by 1,2,3,4
union all
select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Morocco
group by 1,2,3,4
union all
select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Nigeria
group by 1,2,3,4
union all 
select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Ivory_Coast
group by 1,2,3,4
union all
select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Egypt
group by 1,2,3,4
union all 
select currency_from, currency_to, usd_to_currency_rate, 
currency_to_usd_rate, max(timestamp) timestamp
from staging.Kenya
group by 1,2,3,4
