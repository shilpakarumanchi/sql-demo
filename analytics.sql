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
