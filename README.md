# Restaurant Order Analysis- Maven Analytics Project

![Restaurant Image](https://github.com/ArunJakhmola/restaurant_order-_analysis/blob/fed2d8e9a69888723f881479ba4fef4d81cdf3eb/Restaurant%20project%20thumbnail2.jpg)

## Project Overview

The **Restaurant Order Analysis** project aims to analyze order data to identify the most and least popular menu items and types of cuisine. The analysis objectives and their corresponding queries are outlined below.

## Objectives and Queries

### Objective 1: Explore the Menu Items Table

1. **View the menu_items table and find the number of items on the menu**
  ```
   SELECT count(*)
   FROM menu_items;
```
2. **Identify the least and most expensive items on the menu**

```
#### Least expensive:

SELECT item_name, price
FROM menu_items
ORDER BY price
LIMIT 1;

#### Most expensive:

SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 1;
```

3. **Count the number of Italian dishes and find the least and most expensive Italian dishes**

``` SELECT category, count(*) AS number_of_dishes
FROM menu_items
GROUP BY category
HAVING category = 'Italian';
```

4. **Count the number of dishes in each category and calculate the average dish price within each category**
```
SELECT category, count(*) AS number_of_dishes, avg(price) AS average_price
FROM menu_items
GROUP BY category
ORDER BY category;
```

### Objective 2: Explore the Orders Table

1. **View the order_details table**
```
SELECT *
FROM order_details;
```

2. **Determine the date range of the table**
```
SELECT max(order_date) - min(order_date) AS date_range
FROM order_details;
```

3. **Count the number of orders made within the date range**
```
SELECT count(order_id) AS number_of_orders
FROM order_details;
```

4. **Count the number of items ordered within the date range**
```
SELECT count(distinct order_details_id) AS number_of_orders
FROM order_details;
```

5. **Identify the orders with the most number of items**
```
SELECT order_id, count(item_id) AS order_counts
FROM order_details
GROUP BY order_id
ORDER BY order_counts DESC;
```

6. **Count the number of orders that had more than 12 items**
```
SELECT count(*) AS orders_more_than_12items
FROM (
    SELECT order_id, count(item_id) AS order_counts
    FROM order_details
    GROUP BY order_id
    HAVING order_counts > 12
    ORDER BY order_counts DESC
) ct;
```

### Objective 3: Analyze Customer Behavior

1. **Combine the menu_items and order_details tables into a single table**
```
WITH temp AS (
    SELECT * 
    FROM menu_items m
    JOIN order_details o
    ON o.item_id = m.menu_item_id
)
SELECT * 
FROM temp;
```

2. **Identify the least and most ordered items and their categories**
```
#### Most ordered:

WITH temp AS (
    SELECT * 
    FROM menu_items m
    JOIN order_details o
    ON o.item_id = m.menu_item_id
)
SELECT category, item_name, count(*) AS num_items
FROM temp
GROUP BY category, item_name
ORDER BY num_items DESC
LIMIT 1;

#### Least ordered:

WITH temp AS (
    SELECT * 
    FROM order_details o
    JOIN menu_items m
    ON m.menu_item_id = o.item_id
)
SELECT category, item_name, count(*) AS num_items
FROM temp
GROUP BY category, item_name
ORDER BY num_items 
LIMIT 1;
```

3. **Identify the top 5 orders that spent the most money**
```
WITH temp AS (
    SELECT * 
    FROM order_details o
    JOIN menu_items m
    ON m.menu_item_id = o.item_id
)
SELECT order_id, sum(price) AS amount
FROM temp
GROUP BY order_id
ORDER BY amount DESC
LIMIT 5;
```

4. **View the details of the highest spend order (order_id 440)**
```
WITH temp AS (
    SELECT * 
    FROM order_details o
    JOIN menu_items m
    ON m.menu_item_id = o.item_id
)
SELECT order_id, item_name, category, sum(price) AS amount
FROM temp
GROUP BY order_id, item_name, category
HAVING order_id = 440
ORDER BY amount DESC;
```

5. **View the details of the top 5 highest spend orders**
```
WITH temp AS (
    SELECT * 
    FROM order_details o
    JOIN menu_items m
    ON m.menu_item_id = o.item_id
)
SELECT order_id, category, count(*) AS num_items
FROM temp
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category
ORDER BY num_items DESC;
```

## Conclusion

1. Identified most and least popular menu items.
2. Analyzed category distribution and pricing.
3. Determined customer ordering patterns and high-value orders.
4. Provided actionable insights for menu optimization and customer satisfaction improvement.


## Project Link
View the complete [project](https://mavenanalytics.io/project/17466) here.


## Thank You
### Arun Jakhmola
