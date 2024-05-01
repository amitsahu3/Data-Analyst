# 1. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category AS category,
    ROUND((SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id)) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY revenue DESC;

# 2. Analyze the cumulative revenue generated over time.
select order_date, 
sum(revenue) over (order by order_date) as cum_revenue 
from 
(select orders.order_date, sum(order_details.quantity * pizzas.price) as revenue from order_details join pizzas on order_details.pizza_id = pizzas.pizza_id 
join orders on orders.order_id = order_details.order_id group by orders.order_date ) as sales;

# 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select pizza_name, revenue, rn from
(
select category, pizza_name, revenue, rank() over(partition by category order by revenue desc) as rn
from (
SELECT 
    pizza_types.category AS category,
    pizza_types.name AS pizza_name,
    SUM(order_details.quantity * price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category , pizza_name
ORDER BY revenue DESC) as a) as b where rn<=3;