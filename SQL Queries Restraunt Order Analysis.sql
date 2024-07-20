USE restraunt_55db;

-- OBJECTIVE 1
-- Explore the items table

--  QUESTIONS
-- View the menu_items table and write a query to find the number of items on the menu
SELECT count(*)
FROM menu_items;

-- What are the least and most expensive items on the menu?
# Least expensive
select item_name, price
from menu_items
ORDER BY price
limit 1;

# Most expensive
select item_name, price
from menu_items
order by price desc
limit 1;

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
select category, count(*) as number_of_dishes
from menu_items
group by category
having category = "Italian";

-- How many dishes are in each category? What is the average dish price within each category? 
select category, count(*) as number_of_dishes, avg(price) as average_price
from menu_items
group by category
order by category;

-- OBJECTIVE 2
-- Explore the orders table

-- View the order_details table.
select *
from order_details;

-- What is the date range of the table?
select max(order_date) - min(order_date) as date_range
from order_details;

-- How many orders were made within this date range?
select count(order_id) number_of_orders
from order_details;

--  How many items were ordered within this date range?
select count(distinct order_details_id) number_of_orders
from order_details;

-- Which orders had the most number of items?
select order_id, count(item_id) as order_counts
from order_details
group by order_id
order by order_counts desc;

-- How many orders had more than 12 items?
select count(*) as orders_more_than_12items
from(
select order_id, count(item_id) as order_counts
from order_details
group by order_id
having order_counts > 12
order by order_counts desc) ct;


-- OBJECTIVE 3
-- Analyze customer behavior

-- Combine the menu_items and order_details tables into a single table
with temp as (select * from menu_items m
join order_details o
on o.item_id = m.menu_item_id)
select * from temp;

-- What were the least and most ordered items? What categories were they in?

#Most Ordered'Hamburger', '622'
with temp as (select * from menu_items m
join order_details o
on o.item_id = m.menu_item_id)
select category, item_name, count(*) as num_items
from temp
group by category, item_name
order by num_items desc
limit 1;

#Least Ordered - 'Chicken Tacos', '123'
with temp as (
select * from order_details o
join menu_items m
on m.menu_item_id = o.item_id)
select category, item_name, count(*) as num_items
from temp
group by category, item_name
order by num_items 
limit 1;

-- What were the top 5 orders that spent the most money?

-- Highest spend order is for order_id '440', '$192.15'
with temp as (
select * from order_details o
join menu_items m
on m.menu_item_id = o.item_id)
select order_id, sum(price) amount
from temp
group by order_id
order by amount desc
limit 5;

-- View the details of the highest spend order. Which specific items were purchased?
with temp as (
select * from order_details o
join menu_items m
on m.menu_item_id = o.item_id)
select order_id, item_name, category, sum(price) amount
from temp
group by order_id, item_name, category
having order_id = 440
order by amount desc;

-- View the details of the top 5 highest spend orders
with temp as (
select * from order_details o
join menu_items m
on m.menu_item_id = o.item_id)
select order_id, category, count(*) num_items
from temp
where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category
order by num_items desc;

