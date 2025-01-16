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

Find the total amount of standard_qty paper ordered in the orders table.

Find the total dollar amount of sales using the total_amt_usd in the orders table.

Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
  

Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.

