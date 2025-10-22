 -- total orders --
select SUM(DISTINCT order_id) as Total_orders FROM pizza_sales ;
GO

-- total revenue --
select ROUND(SUM(total_price),2) as total_revenue FROM pizza_sales;

--average order Value--

--q1 : avgOrderValue for each pizza type
SELECT 
pizza_id, pizza_name, ROUND(total_revenue/totalOrders,1) as avgOrderValue
FROM(
SELECT 
pizza_id, pizza_name,
COUNT(DISTINCT order_id) as totalOrders,
ROUND(SUM(total_price),2) as total_revenue
FROM pizza_sales
GROUP BY pizza_id, pizza_name
)t
ORDER BY pizza_id

--q2: overall analysis
SELECT 
SUM(total_price)/COUNT(distinct order_id) as avgOrderValue
FROM pizza_sales

-- total pizza sold --
SELECT SUM(quantity) as totalPizzaSold FROM pizza_sales

-- total orders-- 
SELECT COUNT(DISTINCT order_id) as total_orders FROM pizza_sales

-- average pizza per order -- 
SELECT 
ROUND(SUM(CAST(quantity AS FLOAT)) / COUNT(DISTINCT order_id) ,1) as avg_pizza_per_order 
FROM pizza_sales

-- daily performance --
SELECT DATENAME(DW,order_date) as order_day , COUNT(DISTINCT order_id) as total_orders from pizza_sales
group by DATENAME(DW, order_date)

-- hourly perfromance : identify peak hours --

SELECT DATENAME(hour, order_time) as peak_hours , COUNT(DISTINCT order_id) as totalOrders FROM pizza_sales
group by DATENAME(hour, order_time)
order by COUNT(DISTINCT order_id) desc

-- monthly performance --
SELECT DATENAME(month, order_date) as month_name , COUNT(DISTINCT order_id) as totalOrders FROM pizza_sales
group by DATENAME(month, order_date)
order by COUNT(DISTINCT order_id) desc

--percentage of sales by pizza category--
 
SELECT 
pizza_category,
ROUND(sum(total_price),5) as total_sales,
CONCAT(ROUND(SUM(CAST(total_price as float)) / (SELECT SUM(total_price) FROM pizza_sales /*WHERE MONTH(order_date) = 1*/), 5) * 100, '%') as percentage_sales
FROM 
pizza_sales
--WHERE MONTH(order_date) = 1 --to identify the PCT for specific month
group by 
pizza_category
order by CONCAT(ROUND(SUM(CAST(total_price as float)) / (SELECT SUM(total_price) FROM pizza_sales), 5) * 100, '%')  DESC

--percentage of sales by pizza size--
 
SELECT 
pizza_size,
ROUND(sum(total_price),5) as total_sales,
CONCAT(ROUND(SUM(CAST(total_price as float)) / (SELECT SUM(total_price) FROM pizza_sales ), 5) * 100, '%') as percentage_sales
FROM 
pizza_sales
group by 
pizza_size
order by CONCAT(ROUND(SUM(CAST(total_price as float)) / (SELECT SUM(total_price) FROM pizza_sales), 5) * 100, '%')  DESC

-- top 5 best sellers by revenue, total quantity, & total orders
SELECT TOP 5
pizza_name,
sum(total_price) as total_revenue
FROM pizza_sales
GROUP BY
pizza_name
order by total_revenue ASC
--
SELECT TOP 5
pizza_name,
sum(quantity) as total_quantity
FROM pizza_sales
GROUP BY
pizza_name
order by total_quantity DESC
 
--
SELECT TOP 5
pizza_name,
COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY
pizza_name
order by total_orders asc
