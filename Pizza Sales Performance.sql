SELECT * FROM pizza_db.pizza_sales;
SELECT COUNT(*) FROM pizza_db.pizza_sales;
SELECT COUNT(*) AS total_rows FROM pizza_db.pizza_sales;

select sum(total_price) AS Total_Revenue from pizza_sales;

select sum(total_price)/count( distinct order_id) AS Average_Order_Value from pizza_sales;

select sum(quantity) AS Total_Pizza_Sold from pizza_sales;

select count(distinct order_id) as Total_Orders from pizza_sales;

select cast(cast(sum(quantity) AS DECIMAL(10,2)) /CAST(count(distinct order_id) AS DECIMAL (10,2)) as decimal(10,2)) as Average_Pizza_per_order from pizza_sales;  #10,2 means that only consider upto 2 decimals of the 10

#daily trend
alter table pizza_sales add column order_day varchar(50);
update pizza_sales set order_day = DAYNAME(order_date);
select order_day, COUNT(distinct order_id) as total_orders from pizza_sales
group by order_day; #order will come as random, for monday to sunday - need to do this - order by FIELD(order_day, 'Monday', 'Tuesday'.....,'Sunday');

select weekday(order_date) as order_dy, dayname(order_date) as order_D, count(distinct order_id) as total_orders from pizza_sales
group by order_dy, order_D;


#hourly trend
select hour(order_time), count(distinct order_id) as total_orders from pizza_sales
group by hour(order_time)
order by hour(order_time);

select pizza_category, sum(total_price) , cast((sum(total_price)*100)/(select sum(total_price) from pizza_sales where monthname(order_date) = 'january') as decimal (10,2)) as percentage_of_each_pizza_category from pizza_sales
where monthname(order_date) = 'january'
group by pizza_category; #numerator is for that particular pizza category and denominator is total
#use quarter() = number for quarterly (here you will have to put this inside the total price select also else 
#it will give total sales and not total quarterly sales , month()=1-12 for alternative month wise

select pizza_category, sum(quantity) from pizza_sales
group by pizza_category;

select pizza_size, sum(total_price) , cast((sum(total_price)*100)/(select sum(total_price) from pizza_sales) as decimal (10,2)) as percentage_of_each_pizza_size from pizza_sales
group by pizza_size
order by  percentage_of_each_pizza_size desc;

#top 5 best seller:
select pizza_name, sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_name
order by Total_Pizzas_Sold desc LIMIT 5;

#top 5 worst seller:
select pizza_name, sum(quantity) as Total_Pizzas_Sold from pizza_sales
group by pizza_name
order by Total_Pizzas_Sold asc LIMIT 5;



