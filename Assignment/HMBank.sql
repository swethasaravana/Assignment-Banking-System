------TASK 1------
-- 1.creating database
create database HMbank

--2.Defining Schema for customers, Accounts and Transaction tables
create table Customers(
customer_id int primary key,
first_name varchar(50) not null,
last_name VARCHAR(50) not null,
DOB date not null,
email varchar(100) not null ,
phone_number varchar(15) not null,
address varchar(100) not null
)

create table Accounts (
account_id int primary key identity(1,1),
customer_id int,
account_type varchar(20) not null,
balance decimal,
foreign key (customer_id) references Customers(customer_id)
)

create table Transactions (
transaction_id int primary key,
account_id int,
transaction_type varchar(20) not null,
amount decimal not null, 
transaction_date date,
foreign key (account_id) references Accounts(account_id)
)

------TASK 2------
--1.Insert at least 10 sample records into each of the tables. 
insert into Customers values
(1,'karthik','Raj','2001-11-22','kathkr@gmail.com','987543','123 Gandhi street,Chennai'),
(2,'Vijay','kumar','1996-09-22','vijay@gmail.com','123456','123 Good street,bangalore'),
(3, 'Suresh', 'Reddy', '1999-10-12', 'suresh.reddy@gmail.com', '333444', '178 John Street, Chennai'),
(4, 'Rahul', 'Ganesh', '2003-10-11', 'rahulgenesh11@gmail.com', '444555', '321 Paul Street, Coimbatore'),
(5, 'Sunita', 'shree', '1990-09-10', 'sunitas@gmail.com', '255689', '234 Nehru Street, Bangalore'),
(6, 'Meena', 'Gupta', '2008-10-09', 'meena23@gmail.com', '672977', '345 Court Road, Bangalore'),
(7, 'Anil', 'Maya', '1980-09-08', 'anilmaya@gmail.com', '987888', '678 Book Street, Coimbatore'),
(8, 'Vijay', 'Menon', '2001-01-01', 'vijay.menon@gmail.com', '993411', '910 Pine Street, Chennai'),
(9, 'Rakesh', 'Jain', '2000-12-25', 'rakeshjain1215@gmail.com', '781223', '019 Paper Street, Bangalore'),
(10, 'Anita', 'Singh', '2015-05-22', 'anita.singh@gmail.com', '765222', '432 Nehru Street, Madurai'),
(11, 'Ravi', 'Kumar', '1992-04-15', 'ravik@gmail.com', '845669', '123 Paris Corner, Chennai')

insert into Accounts(customer_id,account_type,balance) values
(1,'savings',5000),
(2,'current',3000),
(3,'savings',7500),
(4,'current',1200),
(5,'current',6000),
(6,'savings',3500),
(7,'current',2000),
(8,'savings',8000),
(9,'zero_balance',0),
(10,'savings',1050),
(11,'savings',10000),
(2,'savings',5500),
(5,'current',3000),
(10,'savings',4000)
insert into Accounts(customer_id,account_type,balance) values(11,'savings',0)

insert into transactions values
(1,1,'deposit',500,'2024-01-10'),
(2,2,'withdrawal',300,'2024-01-15'),
(3,3,'deposit',1200,'2024-01-20'),
(4,4,'transfer',150,'2024-01-25'),
(5,5,'deposit',600,'2024-01-30'),
(6,6,'withdrawal',200,'2024-02-05'),
(7,7,'transfer',800,'2024-02-10'),
(8,8,'withdrawal',400,'2024-02-15'),
(9,9,'deposit',300,'2024-02-20'),
(10,10,'withdrawal',250,'2024-02-25')
insert into transactions values
(11,3,'withdraw',250,'2024-11-06'),
(12,8,'deposit',2500,'2014-11-09'),
(13,10,'transfer',50,'2021-07-18'),
(14,3,'deposit',9000,'2024-11-07')
insert into Transactions values
(15,6,'deposit',1000,'2024-01-20'),
(16,5,'deposit',1340,'2024-01-20')
insert into Transactions values
(17,3,'deposit',1200,'2024-01-20'),
(18,8,'deposit',2500,'2014-11-09')


--2.Write SQL queries for the following tasks
--(i)Retrieve the name, account type, and email of all customers
   select first_name,last_name,account_type,email from Customers
   join Accounts on Customers.customer_id=Accounts.customer_id
     
--(ii)Write a SQL query to list all transaction corresponding customer
   select c.customer_id,c.first_name,c.last_name,t.transaction_id,t.transaction_type,t.transaction_date,t.amount from Transactions t
   join Accounts a on t.account_id=a.account_id
   join Customers c on a.customer_id=c.customer_id

--(iii)Write a SQL query to increase the balance of a specific account by a certain amount
   update Accounts set balance=balance+200 where account_id=3

--(iv)Write a SQL query to Combine first and last names of customers as a full_name
   select CONCAT_WS(' ',first_name,last_name) as full_name
   from Customers

--(v)Write a SQL query to remove accounts with a balance of zero where the account type is savings
   delete from Accounts where balance=0 and account_type='savings'

--(vi)Write a SQL query to Find customers living in a specific city
   select * from Customers where address like '%Coimbatore%'

--(vii)Write a SQL query to Get the account balance for a specific account
   select balance from Accounts where account_id=5

--(viii)Write a SQL query to List all current accounts with a balance greater than $1,000. 
   select * from Accounts where account_type='current' and balance>1000

--(ix)Write a SQL query to Retrieve all transactions for a specific account. 
   select * from Transactions where account_id=3

--(x)Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate
   select account_id,balance,(balance*0.5) as interest from Accounts
   where account_type='savings'

--(xi)Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit
   select * from Accounts where balance<500

--(xii)Write a SQL query to Find customers not living in a specific city.
   select * from Customers where address not like '%Bangalore%'


------TASK 3------
--1.Write a SQL query to Find the average account balance for all customers
   select avg(balance) as average_balance from Accounts

--2.Write a SQL query to Retrieve the top 10 highest account balances
   select top 10 account_id,balance from Accounts
   order by balance desc

--3.Write a SQL query to Calculate Total Deposits for All Customers in specific date
   select sum(Amount) as total_deposit from Transactions
   where transaction_type='deposit' and transaction_date='2024-01-20'
  
--4.Write a SQL query to Find the Oldest and Newest Customers
   select top 1 * from Customers
   order by DOB
   select top 1* from Customers
   order by DOB desc

--5.Write a SQL query to Retrieve transaction details along with the account type
   select T.*,A.account_type 
   from Transactions T
   join Accounts A on T.account_id=A.account_id

--6.Write a SQL query to Get a list of customers along with their account details.
   select C.*,account_id,account_type,balance
   from Accounts A
   join Customers C on A.customer_id=C.customer_id
   order by C.customer_id
   
--7.Write a SQL query to Retrieve transaction details along with customer information for a specific account
   select c.customer_id,c.first_name,c.last_name,t.*
   from Customers c
   join Accounts a on c.customer_id=a.customer_id
   join Transactions t on a.account_id=t.account_id
   where a.account_id=3

--8.Write a SQL query to Identify customers who have more than one account. 
   select customer_id,count(account_id) as account_count
   from Accounts
   group by customer_id having count(account_id)>1

--9.Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals
   select  
    (select sum(amount) from Transactions where transaction_type = 'deposit') as Total_Deposit,  
    (select sum(amount) from Transactions where transaction_type = 'withdrawal') as Total_Withdrawal,
    (select sum(amount) from Transactions where transaction_type = 'deposit') - 
    (select sum(amount) from Transactions where transaction_type = 'withdrawal') as Difference

--10.Write a SQL query to Calculate the average daily balance for each account over a specified period
   select a.account_id,AVG(a.balance) as [average balance]
   from accounts a
   join Transactions t on t.account_id=a.account_id
   where t.transaction_date between '10-01-2023' and '08-11-2024'
   group by a.account_id

--11.Calculate the total balance for each account type
   select account_type,sum(balance) as total_balance from Accounts
   group by account_type

--12.Identify accounts with the highest number of transactions order by descending order
   select account_id,count(transaction_id)as transaction_count from transactions
   group by account_id
   order by transaction_count desc
     
--13.List customers with high aggregate account balances, along with their account types
   select c.first_name,c.last_name,a.account_type,sum(a.balance) as [Total Balance]
   from accounts a
   join Customers c
   on c.customer_id=a.customer_id
   group by a.account_type,c.first_name,c.last_name
   having SUM(a.balance)>5000
   order by sum(a.balance) desc


--14.Identify and list duplicate transactions based on transaction amount, date, and account
   select account_id,amount,transaction_date,count(account_id) as duplicates
   from transactions
   group by account_id,amount,transaction_date
   having count(account_id)>1
  

------TASK 4------
--1.Retrieve the customer(s) with the highest account balance
   select * from Customers 
   where customer_id=(select top 1 customer_id from Accounts order by balance desc)

--2.Calculate the average account balance for customers who have more than one account
   select customer_id,avg(balance) as avg_balance
   from Accounts
   group by customer_id having count(account_id)>1
   
--3.Retrieve accounts with transactions whose amounts exceed the average transaction amount
   select account_id,transaction_type,amount from Transactions
   where amount >(select avg(amount) from Transactions)

--4.Identify customers who have no recorded transactions
   select * from Customers
   where customer_id not in(select customer_id from Accounts where account_id in (select account_id from Transactions))
              
--5.Calculate the total balance of accounts with no recorded transactions
   select sum(balance) from Accounts
   where account_id not in(select account_id from Transactions)

--6.Retrieve transactions for accounts with the lowest balance
   select transaction_id,transaction_type,transaction_date
   from Transactions where account_id in (select account_id from Accounts where balance =(select min(balance)from Accounts))

--7.Identify customers who have accounts of multiple types
   select * from Customers
   where customer_id in (select customer_id from Accounts group by customer_id having count(distinct account_type)>1)

--8.Calculate the percentage of each account type out of the total number of accounts
   select account_type,(count(account_type)*100.0)/(select count(account_type) from Accounts) as percentange
   from Accounts
   group by account_type
  
--9.Retrieve all transactions for a customer with a given customer_id
   select * from Transactions 
   Customers where account_id in (select account_id from Accounts where customer_id=5)

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause
   select account_type,(select sum(balance) as total 
   from accounts a1
   where a1.account_type=a2.account_type)as total_balance
   from Accounts a2
   group by account_type
    
   

     
