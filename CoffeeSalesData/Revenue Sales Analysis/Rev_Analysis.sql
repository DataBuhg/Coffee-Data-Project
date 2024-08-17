select * from coffee_sales;

-- Objective: Calculate and analyze revenue generated from sales:

-- Total revenue per day and per product:

select date, coffee_name, SUM(SUM(money)) OVER (PARTITION BY date) AS total_rev_per_day
from coffee_sales
group by date, coffee_name
order by date desc;

-- Identify high-revenue days and products:

-- High-revenue days
select date, total_rev_per_day from(
select date, coffee_name, SUM(SUM(money)) OVER (PARTITION BY date) AS total_rev_per_day
from coffee_sales
group by date, coffee_name)
group by date, total_rev_per_day
order by total_rev_per_day desc;

-- High revenue product is shown in previous query within the CoffeeQuery



