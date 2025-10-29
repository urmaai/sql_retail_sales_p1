select * from reatail_sales;

select 
	count(*)
from reatail_sales;

--Data cleaning
select * from reatail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id	is null
	or
	gender is null
	or
	age	is null
	or
	category is null
	or
	quantity is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

delete from reatail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id	is null
	or
	gender is null
	or
	age	is null
	or
	category is null
	or
	quantity is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null;

--Data exploration
--How many sales we have?
select count(*) as total_sales from reatail_sales;

--How many unique customers we have?
select count (distinct customer_id) as total_customer from reatail_sales;

select distinct category as total_category from reatail_sales;

--Data Analysis & Business Key problems & Answers
--q1 Write a sql query to retrieve all columns for sales made on '2022-11-05'

select * from reatail_sales
where sale_date='2022-11-05';

--q2 Write a sql query to retrieve all transactions where the category is  clothing and the quantity sold is more than 10 in month of nov-2022?
select 
	*
	from reatail_sales
where 
    category='Clothing'
	and
	to_char(sale_date,'YYYY-MM')='2022-11'
	and
	quantity>=4;

--q3 write a sql query to calculate total the total sales(total_sale) for each category
select
	category,
	sum(total_sale) as tot_sale,
	count(*) as total_orders
from reatail_sales
group by 1;

--q4 write a sql query to find average of customers who purchased items from the beauty category 
select 
	round(avg(age),2) as avg_age
from reatail_sales
where category='Beauty';

--q5 write a sql query to find all transactions where the total_sale greater than 1000
select
	*
from reatail_sales
where total_sale>1000;

--q6 write a sql query to find the total number of transactions(transaction_id) made by each gender in each category

select 
	category,
	gender,
	count(*) as total_count
from reatail_sales
group by 1,2
order by 1;

--q7 write a sql query to calculate the average sale each month Find out the best selling month in each year

select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale
from reatail_sales
group by 1,2
order by 1,3 desc;

--q8 write a sql query to find top 5 customers based on the highest total sales

select
	customer_id,
	sum(total_sale) as sum_total_sales
from reatail_sales
group by 1
order by 2 desc
limit 5;

--q9 write a sql query to find the number of unique customers who purchased items from each category
 
select 
	category,
	count (distinct customer_id) as unique_customers
from reatail_sales
group by 1;

--q10 write a sql query to create each shift and number of orders(example morning<=12, afternoon between 12&17, evening>17)

select 
	CASE 
		when extract (hour from sale_time)<=12 then 'Morning'
		when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift,
	count(*) as transaction_number
from reatail_sales
group by shift
order by transaction_number desc;

--End of project

	
	