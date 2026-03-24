# Online Book Store SQL Project

**Project Title**: Onine Book Store  
**Database**: `Online_book_store`

## Project Overview
The aim is to analyze the online bookstore dataset using SQL to uncover insights about book sales, customer behaviour, and revenue trends. The goal is to perform data exploration, identify popular books and genres, and generate meaningful insights that can help improve sales and business decisions.

## Objectives

1. **Set up the Onine Book Store Database**: Create and populate the database with tables for Books, Customers, Orders.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup

- **Database Creation**: Created a database named `Online_book_store`.
- **Table Creation**: Created tables for Books, Customers, Orders. Each table includes relevant columns and relationships.

```sql
CREATE DATABASE Online_book_store;

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


-- Create table "Customers"
DROP TABLE IF EXISTS Customers;
create table Customers (
            Customer_ID    int PRIMARY KEY,
            Name           varchar(100),
            Email          varchar(200),
            Phone          varchar(30),
            City	       varchar(50),
            Country        varchar(180)
);

-- Create table "Orders"
DROP TABLE IF EXISTS Orders;
create table Orders (
            Order_ID      int PRIMARY KEY,
            Customer_ID   int REFERENCES Customers(Customer_ID),
            Book_ID       int REFERENCES books(Book_ID),
            Order_Date    DATE,
            Quantity      int,
            Total_Amount  numeric(10, 2)
);
          
### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**:   Retrieved and displayed data from various tables.
- **Update**: Updated records in the `Customers` table.
- **Delete**: Removed records from the `orders` table as needed.

**Task 1. Retrieve all books in the "Fiction" genre**
```sql
SELECT * FROM books 
WHERE genre = 'Fiction';
```
**Task 2: Find books published after the year 1950**

```sql
SELECT * FROM books 
WHERE published_year > 1950
ORDER BY published_year;
```

**Task 3: List all customers from the Canada**
```sql
SELECT * FROM customers 
WHERE country = 'Canada';
```

**Task 4: Show Orders Placed in November 2023**
```sql
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
```


**Task 5: Retrieve the total stock of books available**
```sql
SELECT sum(stock) as total_stock 
FROM books; 
```

- **Task 6: Find the details of most expensive book**

```sql
SELECT * FROM books 
ORDER BY price DESC
LIMIT 2;
```

Task 7. **Show all customers who ordered more than 1 quantity of book**:

```sql
SELECT * 
FROM customers as c
JOIN orders as o 
ON o.customer_id = c.customer_id
where quantity > 1;
```

8. Task 8: **Retrieve all orders where the total amount exceeds $20**:

```sql
SELECT * FROM orders 
WHERE total_amount > 20;
```

9. **List all the genres available in books table**:
```sql
SELECT DISTINCT genre
FROM books;
```

10. **Find the books with lowest stock**:

```sql
SELECT * FROM books 
ORDER BY stock
LIMIT 10;

```

Task 11. **Calculate the total revenue generated from all orders**:

```sql
SELECT SUM(total_amount) FROM orders;
```

Task 12: **Retrieve the total number of books sold for each genre**
```sql
SELECT genre , COUNT(quantity)
FROM books as b
JOIN orders as o
ON b.book_id = o.book_id
GROUP BY genre;
```

**Task 13: Find the average price of books in the 'Fanatsy' genre**  
```sql
SELECT avg(price)
FROM books 
where genre = 'Fantasy'

```

**Task 14: List customers who have placed atleast 2 orders**  
```sql
SELECT o.customer_id, c.name, COUNT(o.order_id)
FROM orders as o
JOIN customers as c
ON o.customer_id = c.customer_id
GROUP BY o.customer_id , c.name
HAVING COUNT(o.order_id) >= 2;
```

**Task 15: Find the most frequently ordered book**  

```sql
SELECT b.book_id , b.title , COUNT(o.order_id) as order_count
FROM books as b
JOIN orders as o
ON b.book_id = o.book_id
GROUP BY b.book_id , b.title
ORDER BY 3 DESC
LIMIT 1;
```

**Task 16: Show the top 3 most expensive books of 'Fantasy' Genre**  
```sql
SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price desc
LIMIT 3;

```
**Task 17: Retrieve the total quantity of books sold by each author**  

```sql
SELECT author, SUM(quantity) as quantity_sold
FROM books as b
JOIN orders as o
ON o.book_id = b.book_id
GROUP BY 1;
```

**Task 18: List the cities where customers who spent over $30 are located**  
```sql
SELECT DISTINCT c.city , o.total_amount
FROM orders as o 
JOIN customers as c
ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;
```

**Task 19: Find the customer who spent the most on orders**
```sql
SELECT c.customer_id , c.name , SUM(o.total_amount) as total_spent
FROM customers as c
JOIN orders as o 
ON o.customer_id = c.customer_id
GROUP BY 1, 2
ORDER BY 3 desc
LIMIT 1;
```

**Task 20: Calculate the stock remaining after fulfilling all orders**
```sql
SELECT b.book_id,
 b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books as b
LEFT JOIN orders as o
ON b.book_id = o.book_id
GROUP BY b.book_id 
ORDER BY b.book_id;

```
## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, customers behaviour, Orders placed.
- **Summary Reports**: Aggregated data on high-demand books and sales.

## Conclusion

The project demonstrates how SQL can be used to analyze sales data and uncover meaningful insights about book popularity, customer behavior, and overall business performance in an online bookstore.


