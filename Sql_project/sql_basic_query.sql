# 1. Retrieve the total number of orders placed.

select count(order_id) as total_orders from orders;
use pizzahut;
-- ------------------------------------------------------------------------------------------------------

# 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- ------------------------------------------------------------------------------------------------------
# 3. Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
-- ------------------------------------------------------------------------------------------------------
# 4. Identify the most common pizza size ordered.
SELECT 
    pizzas.size AS size,
    sum(order_details.order_details_id * order_details.quantity) AS total_qty
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY total_qty DESC;