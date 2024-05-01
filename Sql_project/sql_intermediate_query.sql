use pizzahut;
-- ------------------------------------------------------------------------------------------------
# 1. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category AS category,
    SUM(order_details.quantity) AS total_qty
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY total_qty DESC;
-- ------------------------------------------------------------------------------------------------
# 2. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) as hour_time, COUNT(order_id) as total_orders
FROM
    orders
GROUP BY (hour_time) order by hour_time asc;

-- ------------------------------------------------------------------------------------------------
# 3. Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category AS category,
    COUNT(order_details.quantity) AS total_qty
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category
ORDER BY total_qty;

-- ------------------------------------------------------------------------------------------------
# 4. Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0)
FROM
    (SELECT 
        orders.order_date order_date, SUM(order_details.quantity) as quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY order_date
    ORDER BY order_date) AS order_qty;
    
-- ------------------------------------------------------------------------------------------------
# 5. Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name AS name,
    sum(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY (name)
ORDER BY revenue desc limit 3;
