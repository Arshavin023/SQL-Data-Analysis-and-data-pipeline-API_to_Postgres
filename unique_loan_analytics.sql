with borrower_loans as (
select lt.loan_id, bt.city, bt.zip_code, 
	lt.payment_frequency, lt.date_of_release,
	case when left(lt.maturity_date,5) = '02/29' then 
	TO_DATE('02/28/2023','MM/DD/YYYY') 
	else TO_DATE(lt.maturity_date,'MM/DD/YYYY') end as maturity_date
from staging.loan_table lt
left join staging.borrower_table bt on lt.borrower_id=bt.borrower_id),

payment_schedule_borrower_loans as (
select bl.*, ps.expected_payment_amount, 
	to_date(ps.expected_payment_date,'MM/DD/YYYY') expected_payment_date
from staging.payment_schedule ps
left join borrower_loans bl on ps.loan_id = bl.loan_id
),

loan_and_payment as (
select lt.loan_id, lp.amount_paid, lp.date_paid
from staging.loan_table lt
left join staging.loan_payment lp on lt.loan_id=lp.loan_id
),

combined as (
select lap.amount_paid, TO_DATE(lap.date_paid,'MM/DD/YYYY') date_paid, psbl.*
from loan_and_payment lap
join payment_schedule_borrower_loans psbl on lap.loan_id=psbl.loan_id
),

window_table as (
select *, (expected_payment_amount - amount_paid) amount_at_risk,
ROW_NUMBER() OVER (PARTITION BY expected_payment_date 
				   ORDER BY loan_id) AS row_num
from combined)

select loan_id, city, zip_code,payment_frequency,maturity_date,
		max(expected_payment_date) last_due_date, 
		max(date_paid) last_repayment_date,
		(max(date_paid)-max(expected_payment_date)) current_days_past_due,
		sum(amount_at_risk) amount_at_risk
from window_table where row_num=1
group by 1,2,3,4,5
order by loan_id desc;

