use sales_ecom;

-- Data Cleaing in SQL

select * from sales_ecom;

select count(*) from sales_ecom;

describe sales_ecom;

select count(*) from information_schema.columns where table_name='sales_ecom';

select
   Discount,
   replace(Discount,',', '.')
from sales_ecom;

SET SQL_SAFE_UPDATES=0;

-- Update discount columns

update sales_ecom
set Discount=replace(Discount,',', '.');

select
    Quantity_Ordered,
    Price_Each,
    Discount,
    round((Quantity_Ordered*Price_Each)*(1-Discount),2) as Revenue
from sales_ecom;
    
-- Add Revenue Columns

alter table sales_ecom
add column Revenue float;

-- Update Revenue COlumns
update sales_ecom
set Revenue=round((Quantity_Ordered*Price_Each)*(1-Discount),2);

-- Add Date and Time Columns
alter table sales_ecom
add column Date date;

select
   order_date,
   substring_index(Order_Date,' ',1)
from sales_ecom;
   
   
-- Upadte Order_Date Columns
update sales_ecom
set Order_Date= substring_index(Order_Date,' ',1);


-- Customer Shipping Customers

select
   customer_shipping_address,
   substring_index(customer_shipping_address,',',1),
   substring_index(customer_shipping_address,',',-1),
   substring_index(substring_index(customer_shipping_address,',',2),',',-1)
from sales_ecom;

alter table sales_ecom
add column Customer_City varchar(30);

alter table sales_ecom
add column Customer_State varchar(30);

update sales_ecom
set Customer_City= substring_index(substring_index(customer_shipping_address,',',2),',',-1);

update sales_ecom
set Customer_State= substring_index(customer_shipping_address,',',-1);

alter table sales_ecom
drop column Customer_Shipping_Address;


describe sales_ecom;

alter table sales_ecom
drop Date;

alter table sales_ecom
rename column Order_Date to Date;
