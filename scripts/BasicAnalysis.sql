WITH basic_query AS (
	select 
		pizza_id,
		order_id,
		pizza_name_id,
		quantity,
		order_date,
		order_time,
		unit_price,
		total_price,
		pizza_size,
		pizza_category,
		pizza_ingredients,
		pizza_name
	from pizza_sales

),order_details AS (
	SELECT 
		pizza_name,
		COUNT( order_id) AS total_orders,
		SUM(quantity) as total_quantity,
		MAX(order_date) as last_order,
		SUM(total_price) as total_revenue
	FROM basic_query
	GROUP BY 
	pizza_name
)
select 

	pizza_name,
	total_orders,
	ROUND(total_revenue,1) as total_revenue,
	ROUND(CAST(total_revenue AS FLOAT)/total_orders ,1)as avg_order_value,
	ROUND(CAST(total_quantity AS FLOAT)/total_orders , 1) as avg_pizza_per_order
from order_details

	