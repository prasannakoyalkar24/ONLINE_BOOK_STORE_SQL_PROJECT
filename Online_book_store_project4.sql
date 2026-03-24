--CREATING TABLES

DROP TABLE IF EXISTS books;
create table books (
Book_ID int PRIMARY KEY,
Title     varchar(300),
Author    varchar(100),
Genre      varchar(100),
Published_Year   int,
Price       numeric(10, 2),
Stock       int
);

DROP TABLE IF EXISTS Customers;
create table Customers (
Customer_ID    int PRIMARY KEY,
Name           varchar(100),
Email          varchar(200),
Phone          varchar(30),
City	       varchar(50),
Country        varchar(180)
);

DROP TABLE IF EXISTS Orders;
create table Orders (
Order_ID      int PRIMARY KEY,
Customer_ID   int REFERENCES Customers(Customer_ID),
Book_ID       int REFERENCES books(Book_ID),
Order_Date    DATE,
Quantity      int,
Total_Amount  numeric(10, 2)
);

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- PROJECT TASKS :
--Q1. Retrieve all books in the "Fiction" genre:
SELECT * FROM books 
WHERE genre = 'Fiction';

--Q2.Find books published after the year 1950:
SELECT * FROM books 
WHERE published_year > 1950
ORDER BY published_year;

--Q3.List all customers from the Canada:
SELECT * FROM customers 
WHERE country = 'Canada';

--Q4. Show Orders Placed in November 2023
SELECT * FROM orders WHERE order_date
BETWEEN '2023-11-01' AND '2023-11-30';

--Q5.Retrieve the total stock of books available
SELECT sum(stock) as total_stock FROM books; 

--Q6.Find the details of most expensive book?
SELECT * FROM books 
ORDER BY price DESC
LIMIT 2;

--Q7.Show all customers who ordered more than 1 quantity of book
SELECT * 
FROM customers as c
JOIN orders as o 
ON o.customer_id = c.customer_id
where quantity > 1;

--Q8.Retrieve all orders where the total amount exceeds $20?
SELECT * FROM orders 
WHERE total_amount > 20;

--Q9.List all the genres available in books table
SELECT DISTINCT genre FROM books;

--Q10.Find the books with lowest stock?
SELECT * FROM books 
ORDER BY stock
LIMIT 10;

--Q11.Calculate the total revenue generated from all orders
SELECT SUM(total_amount) FROM orders;

-- Adavance Questions
--Q12.Retrieve the total number of books sold for each genre
SELECT genre , COUNT(quantity)
FROM books as b
JOIN orders as o
ON b.book_id = o.book_id
GROUP BY genre;

--Q13.Find the average price of books in the 'Fanatsy' genre?
SELECT avg(price)
FROM books 
where genre = 'Fantasy';

--Q14.List customers who have placed atleast 2 orders
SELECT o.customer_id, c.name, COUNT(o.order_id)
FROM orders as o
JOIN customers as c
ON o.customer_id = c.customer_id
GROUP BY o.customer_id , c.name
HAVING COUNT(o.order_id) >= 2;


--Q15.Finf the most frequently ordered book
SELECT b.book_id , b.title , COUNT(o.order_id) as order_count
FROM books as b
JOIN orders as o
ON b.book_id = o.book_id
GROUP BY b.book_id , b.title
ORDER BY 3 DESC
LIMIT 1;

--Q16.Show the top 3 most expensive books of 'Fantasy' Genre 

SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price desc
LIMIT 3;

--Q17.Retrieve the total quantity of books sold by each author:
SELECT author, SUM(quantity) as quantity_sold
FROM books as b
JOIN orders as o
ON o.book_id = b.book_id
GROUP BY 1;

--Q18.List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city , o.total_amount
FROM orders as o 
JOIN customers as c
ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;

--Q19.Find the customer who spent the most on orders:
SELECT c.customer_id , c.name , SUM(o.total_amount) as total_spent
FROM customers as c
JOIN orders as o 
ON o.customer_id = c.customer_id
GROUP BY 1, 2
ORDER BY 3 desc
LIMIT 1;

--Q20. Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id 
ORDER BY b.book_id;









