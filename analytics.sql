SELECT *
FROM orders
LIMIT 15;

SELECT  id, account_id, total_amt_usd
FROM orders
ORDERBY account_id, total_amt_usd DESC;

SELECT *
FROM orders
WHERE gloss_amt_usd >=1000
LIMIT 5;

SELECT *
FROM orders
WHERE total_amt_usd <500
LIMIT 10;

SELECT name, website, primary_poc
FROM accounts
WHERE name ='Exxon Mobil';

SELECT id, account_id, standard_amt_usd/standard_qty as unit_price 
FROM orders
LIMIT 10;

SELECT id, account_id, poster_amt_usd/(standard_amt_usd+gloss_amt_usd+poster_amt_usd)*100 as poster_revenue 
FROM orders
LIMIT 10;

SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%s';

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstorm');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

SELECT *
FROM orders
WHERE standard_qty>1000 AND poster_qty = 0 AND gloss_qty=0;

SELECT *
FROM accounts 
WHERE name NOT LIKE 'C%' AND name LIKE '%S';

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND (occurred_at BETWEEN '2016-01-01' AND '2016-12-31')
ORDER BY occurred_at DESC;

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty>4000;

SELECT *
FROM orders
WHERE standard_qty = 4000 AND (gloss_qty > 1000 OR poster_qty>1000);

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

SELECT a.name, a.primary_poc, o.occurred_at, w.channel
FROM accounts a
JOIN orders o
ON a.id=o.account_id
JOIN web_events w
ON a.id=w.account_id
WHERE a.name LIKE 'walmart' OR a.name LIKE 'Walmart';

Provide a table that provides the region for each sales_rep along with their associated accounts. 
  Your final table should include three columns: the region name, 
  the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name, s.name, a.name
FROM region r
JOIN sales_reps s
ON r.id=s.region_id
JOIN accounts a
ON a.sales_rep_id=s.id
ORDER BY a.name;

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
  Your final table should have 3 columns: region name, account name, and unit price.
  A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
SELECT r.name region_name, a.name account_name, (o.total_amt_usd/(o.total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id=s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id=o.account_id;

Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region.
  Your final table should include three columns: the region name, the sales rep name, and the account name. 
  Sort the accounts alphabetically (A-Z) according to account name.
  SELECT r.name region_name, s.name salesrep_name, a.name account_name
FROM region r
JOIN sales_reps s
ON r.id=s.region_id
JOIN accounts a
ON s.id=a.sales_rep_id
  WHERE r.name = 'Midwest'
ORDER BY account_name;

Provide a table that provides the region for each sales_rep along with their associated accounts. 
  This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
  Your final table should include three columns: the region name, the sales rep name, and the account name. 
  Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region_name, s.name sales_rep_name, a.name accounts_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id=a.sales_rep_id
WHERE s.name LIKE 'S%' AND r.name LIKE 'Midwest'
ORDER BY a.name;

Provide a table that provides the region for each sales_rep along with their associated accounts. 
  This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. 
  Your final table should include three columns: the region name, the sales rep name, and the account name. 
  Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region_name, s.name sales_rep_name, a.name accounts_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id=a.sales_rep_id
WHERE s.name LIKE '% K%' AND r.name = 'Midwest'
ORDER BY accounts_name;

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
  However, you should only provide the results if the standard order quantity exceeds 100.
  Your final table should have 3 columns: region name, account name, and unit price. 
  In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
  
SELECT r.name region_name, a.name account_name, (o.total_amt_usd/(o.total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id=s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id=o.account_id
WHERE o.standard_qty >100;

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
  However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
  Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first.
  SELECT r.name region_name, a.name account_name, (o.total_amt_usd/(o.total+0.01)) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id=s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id=o.account_id
WHERE o.standard_qty >100 AND o.poster_qty>50
  ORDER BY unit_price;

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
  However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
  Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.
  Same as above except add DESC in the last line;

What are the different channels used by account id 1001?
  Your final table should have only 2 columns: account name and the different channels. 
  You can try SELECT DISTINCT to narrow down the results to only the unique values.

SELECT DISTINCT a.name, w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.id = '1001';

Find all the orders that occurred in 2015. 
  Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
  SELECT o.occurred_at, a.name account_name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON a.id=o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC;

Find the total amount of poster_qty paper ordered in the orders table.
  SELECT SUM(poster_qty) as total_poster_sales
  FROM orders;

Find the total amount of standard_qty paper ordered in the orders table.
Find the total dollar amount of sales using the total_amt_usd in the orders table.

Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
  SELECT standard_amt_usd + gloss_amt_usd paper as total_amt
  FROM orders;  

Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
  SELECT SUM(standard_amt_usd)/SUM(standard_qty)
FROM orders;

When was the earliest order ever placed? You only need to return the date.
SELECT MIN(occurred_at)
  FROM orders;

Try performing the same query as in question 1 without using an aggregation function.
SELECT occurred_at
  FROM orders
  ORDER BY occurred_at
  LIMIT 1;

When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at)
  FROM web_event;
  
Try to perform the result of the previous query without using an aggregation function.
SELECT occurred_at
  FROM web_event
  ORDER BY occurred_at DESC
  LIMIT 1;
  
Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
SELECT AVG(standard_qty) mean_standard, AVG(standard_amt_usd) mean_standard_dollars, AVG(gloss_qty), AVG(gloss_amt_usd), AVG(poster_qty), AVG(poster_amt_usd)
  FROM orders;
Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?

SELECT *
FROM orders
COUNT(standard_qty)

Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
  SELECT a.name account_name, o.occured_at order_date
  FROM accounts a
  JOIN orders o
  ON a.id=o.account_id
  ORDER BY order_date
  LIMIT 1;  

Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
  SELECT a.name account_name, SUM(o.total_amt_usd) total_sales_amt
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY account_name;

Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
  Your query should return only three values - the date, channel, and account name.
  SELECT w.channel, w.occurred_at date, a.name account_name
  FROM web_events w
  JOIN accounts a
  ON a.id=w.account_id
  ORDER BY date DESC
  LIMIT 1;

Find the total number of times each type of channel from the web_events was used. 
  Your final table should have two columns - the channel and the number of times the channel was used.
SELECT channel, COUNT(*)
  FROM web_events
  GROUP BY channel;
  
Who was the primary contact associated with the earliest web_event?
  SELECT a.primary_poc primary_poc
  FROM web_events w
  JOIN accounts a
  ON a.id=w.account_id
  ORDER BY w.occurred_at
  LIMIT 1; 

What was the smallest order placed by each account in terms of total usd. 
  Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
  SELECT MIN(o.total_usd) smallest_order, a.name
  FROM orders o
  JOIN accounts a
  ON o.account_id=a.id
  GROUP BY a.name
  ORDER BY smallest_order;

Find the number of sales reps in each region. 
  Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
  SELECT r.name region, COUNT(DISTINCT(s.name)) number_of_salesreps
  FROM region r
  JOIN sales_reps s
  ON r.id =s.region_id
  GROUP BY region
  ORDER BY number_of_salesreps;
  
For each account, determine the average amount of each type of paper they purchased across their orders. 
  Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.


For each account, determine the average amount spent per order on each paper type. 
  Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
SELECT a.name account_name, AVG(o.standard_amt_usd) avg_std_usd, AVG(o.gloss_amt_usd) avg_gloss_usd, AVG(o.poster_amt_usd) avg_poster_usd
  FROM accounts a
  JOIN orders o
  ON a.id=o.account_id
  GROUP BY account_name;

Determine the number of times a particular channel was used in the web_events table for each sales rep.
  Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT s.name, w.channel, COUNT(*) num_channel_occur
  FROM sales_reps s
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN web_events w
  ON a.id = w.account_id
  GROUP BY s.name, w. channel
  ORDER BY num_channel_occur DESC;

Determine the number of times a particular channel was used in the web_events table for each region. 
  Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT r.name region, w.channel channel, COUNT(*) num_events
  FROM sales_reps s
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN web_events w
  ON a.id = w.account_id
  JOIN region r
ON r.id = s.region_id
  GROUP BY region, channel
ORDER BY num_events DESC;
  
  How many of the sales reps have more than 5 accounts that they manage?
SELECT s.id, s.name, COUNT(*) as num_accounts
  FROM sales_reps s
  LEFT JOIN accounts a
  ON s.id = a.sales_rep_id
  GROUP BY s.id, s.name
  HAVING num_accounts > 5
  ORDER BY num_accounts;  

How many accounts have more than 20 orders?
SELECT account_id, COUNT(*) as num_orders
  FROM orders
  GROUP BY account_id
  HAVING COUNT(*) >20
  ORDER BY num_orders desc;
  

Which account has the most orders?
SELECT account_id, COUNT(*) as num_orders
  FROM orders
  GROUP BY account_id
   ORDER BY num_orders desc
  LIMIT 1;

Which accounts spent more than 30,000 usd total across all orders?
  SELECT a.id, a.name, sum(o.total_amt_usd) as total_usd
  FROM accounts a
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY a.id, a.name
  HAVING sum(o.total_amt_usd)>30000
  ORDER BY total_usd;
  
Which accounts spent less than 1,000 usd total across all orders?
HAVING sum(o.total_amt_usd) < 1000
  ORDER BY total_usd;

Which account has spent the most with us?
  ORDER BY total_usd desc
  LIMIT 1;

Which account has spent the least with us?

Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.id, a.name, channel, COUNT(*) as contact_customers
  FROM accounts a
  LEFT JOIN web_events w
  ON a.id = w.account_id
   HAVING COUNT(*) > 6 AND channel ='facebook'
  GROUP BY a.id, a.name, channel
  ORDER BY COUNT(*);  

Which account used facebook most as a channel?
  WHERE channel = 'facebook'
 GROUP BY a.id, a.name, channel
  ORDER BY COUNT(*) desc
  LIMIT 1;

Which channel was most frequently used by most accounts?
   GROUP BY a.id, a.name, channel
  ORDER BY COUNT(*) desc
  LIMIT 1;
  
  Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT extract(year from occurred_at) as year, sum(total_amt_usd) as total_dollars
  FROM web_events w
  LEFT JOIN accounts a
  ON w.account_id = a.id
  LEFT JOIN order o
  ON a.id = o.account_id
  GROUP BY 1
  ORDER BY 2 desc;

Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
SELECT extract(month from occurred_at) as month, sum(total_amt_usd) as total_dollars
  FROM web_events w
  LEFT JOIN accounts a
  ON w.account_id = a.id
  LEFT JOIN order o
  ON a.id = o.account_id
  GROUP BY 1
  ORDER BY 2 desc;

Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
COUNT(id) as num_orders

Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?


In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.

Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.

We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.


We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.


We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.


The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!
