-- Getting a feel of the dataset
SELECT *
FROM coffee_sales
LIMIT 10;

-- Looking at the distinct names within the coffee name columns
-- Americano with Milk, Cappuccino, Americano, Cortado, Latte, Cocoa, Hot Chocolate, Espresso
SELECT distinct coffee_name
from coffee_sales;

-- Looking at the distinct cash types
-- Cash and card
select distinct cash_type
from coffee_sales;

-- Objective: Analyze sales performance of different coffee products:

-- Total amount of drinks sold by coffee name
select coffee_name, count(coffee_name) as number_coffee_sold
from coffee_sales
group by coffee_name;

-- Money gained per coffee's sold
create view coffee_sold as
select coffee_name, count(coffee_name) as number_coffee_sold, money, (count(coffee_name) * money) as total_amount_gained
from coffee_sales
group by coffee_name, money
order by total_amount_gained desc;

-- Total amount made per type of coffee sold
SELECT coffee_name, SUM(total_amount_gained) AS total_rev
FROM coffee_sold
GROUP BY coffee_name
ORDER BY total_rev DESC;

-- Total amount made per type of coffee sold (CREATING VIEW)
create view coffee_sold_totalrevenue as
SELECT coffee_name, SUM(total_amount_gained) AS total_rev
FROM coffee_sold
GROUP BY coffee_name
ORDER BY total_rev DESC;

-- Total amount of drinks sold by coffee name (CREATING VIEW)
create view total_coffees_sold as
select coffee_name, count(coffee_name) as number_coffee_sold
from coffee_sales
group by coffee_name;

-- Comparing amount sold with revenue gained by that product **
select total_coffees_sold.coffee_name, number_coffee_sold, total_rev
from total_coffees_sold
inner join coffee_sold_totalrevenue
on total_coffees_sold.coffee_name = coffee_sold_totalrevenue.coffee_name;

-- Total Revenue By Payment Type **

select cash_type, sum(money) as TotalRev_PaymentType
from coffee_sales
group by cash_type
order by TotalRev_PaymentType desc;

