/* Task 1: 
Understanding the data in hand
A. Describe the data in hand in your own words. (Word Limit is 500)
ANSWER: The whole schema consists of 5 different tables. One table gives the details(name, province etc) about the customers which is cust_dimen. Orders_dimen table gives details about the orders placed from the store. Prod_dimen details us about the products details in the store. Shipping_dimen gives details about shipping of the orders. Market_fact gives details about all the details about a product ranging from its order id, product id to shipping id, discount of product , profit etc.*/


/*B. Identify and list the Primary Keys and Foreign Keys for this dataset (Hint: If a table don’t have Primary Key or Foreign Key, then specifically mention it in your answer.);
ANSWER:
Primary keys: cust_id in cust_dimen table , ord_id from orders_dimen table, prod_id from prod_dimen table, ship_id from shipping_dimen table
Foreign keys: cust_id,  is the foreign key for market_fact table*/

#Task 2:

#A. Find the total and the average sales (display total_sales and avg_sales) 
select sum(sales) as total_sales, avg(sales) as avg_sales
from market_fact;

/*B. Display the number of customers in each region in decreasing order of
no_of_customers. The result should contain columns Region, no_of_customers */
select region as Region, count(*) as no_of_customers
from cust_dimen
group by Region
order by count(*) desc;

/*C. Find the region having maximum customers (display the region name and
max(no_of_customers)*/
select region as 'Region name' , count(*) as 'max(no_of_customers)'
from cust_dimen
group by Region
order by count(*) desc
limit 1;

/*D. Find the number and id of products sold in decreasing order of products sold (display
product id, no_of_products sold)*/
select prod_id as Product_id , sum(sales) as No_of_Products
from market_fact
group by Prod_id
order by sum(sales) desc;

/*E. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and
the number of tables purchased (display the customer name, no_of_tables
purchased) */
select  cd.Customer_Name
from cust_dimen cd inner join market_fact mf on cd.Cust_id=mf.Cust_id
	inner join prod_dimen pd on mf.Prod_id = pd.Prod_id
where cd.Region = 'ATLANTIC' and pd.Product_Sub_Category='TABLES';

#Task3

/* A. Display the product categories in descending order of profits (display the product
category wise profits i.e. product_category, profits)? */
select pd.product_category, sum(mf.profit) as 'total_profit'
from prod_dimen pd inner join market_fact mf on pd.Prod_id = mf.Prod_id
group by pd.Product_Category
order by total_profit desc;

/*B. Display the product category, product sub-category and the profit within each subcategory
in three columns */
select  pd.Product_Category,pd.product_sub_category, sum(mf.profit)
from prod_dimen pd inner join market_fact mf on pd.Prod_id=mf.Prod_id
group by pd.Product_Sub_Category, pd.Product_Category;

/*C. Where is the least profitable product subcategory shipped the most? For the least
profitable product sub-category, display the region-wise no_of_shipments and the
profit made in each region in decreasing order of profits (i.e. region,
no_of_shipments, profit_in_each_region)
o Note: You can hardcode the name of the least profitable product subcategory */
select c.Region as 'Region',count(m.Ship_id) as 'No of Shipments', sum(m.Profit) as 'Profit in each region'
from market_fact m inner join cust_dimen c on m.Cust_id = c.Cust_id
	inner join prod_dimen p on m.Prod_id = p.Prod_id
Where Product_Sub_Category = 'Tables' 
group by c.Region
order by sum(m.Profit);