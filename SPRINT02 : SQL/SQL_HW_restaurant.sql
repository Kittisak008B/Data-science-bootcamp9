CREATE TABLE Customer ( 
  Customer_id INT UNIQUE,
  First_Name TEXT,
  Last_Name TEXT,
  Email TEXT,
  Country TEXT,
  Age INT,
  Phone TEXT
);
CREATE TABLE Menu (
  Menu_id INT UNIQUE,
  Menu_name TEXT,
  Price_menu REAL,
  Type_menu TEXT
);
CREATE TABLE Customer_Order (
  Order_id INT UNIQUE,
  Customer_id INT,
  Date DATETIME,
  Menu_id INT,
  Quantity INT
);
INSERT INTO Customer VALUES
  (01,"Walter","White", "Heisenberg99.1@example.com", "USA", 50, "012-346-5678"),
  (02,"Hector","Salamanca", "DingDingDing@example.com", "Mexico", 70, "022-846-6978"),
  (03,"Jesse","Pinkman", "AyoMrWhite@example.com", "USA", 25, "012-486-9667"),
  (04,"Greta","Thunberg","HowDareYou@example.com","Sweden",20,"066-492-7983"),
  (05,"Nancy","Pelosi","Pelosi@example.com","USA",80,"012-896-7842"),
  (06,"Sam","Bankman-Fried", "SamBankman@example.com", "USA", 30, "015-488-7898"),
  (07,"Do","Kwon","Luna888@example.com","Korea",32,"088-888-8888"),
  (08,"Gojo","Satoru","UnlimitedVoid@example.com","Japan",28,"077-893-0166");

INSERT INTO Menu VALUES
  (01,"Rustica", 500, "Pizza"),
  (02,"Bufalina", 360, "Pizza"),
  (03,"Prosciutto_Pizza", 680, "Pizza"),
  (04,"Roasted_Chicken", 500, "Main_course"),
  (05,"Apple&Pineapple,", 80, "Drink"),
  (06,"Caesar_Salad", 200, "Salad"),
  (07,"Crab&Mango_Salad", 200, "Salad"),
  (08,"Truffle_Bruschetta", 400, "Starter"),
  (09,"Water", 20, "Drink"),
  (10,"Lobster_Spaghetti",1660, "Main_course");

INSERT INTO Customer_Order VALUES
  (01,06,"2023-01-01",08,1),
  (02,06,"2023-01-01",05,2),
  (03,06,"2023-01-01",10,1),
  (04,06,"2023-01-01",03,1),
  (05,08,"2023-01-01",01,1),
  (06,08,"2023-01-01",06,1),
  (07,08,"2023-01-01",02,1),
  (08,07,"2023-01-02",05,2),
  (09,07,"2023-01-02",03,1),
  (10,01,"2023-01-05",08,1),
  (11,01,"2023-01-05",03,1),
  (12,02,"2023-01-07",07,1),
  (13,02,"2023-01-07",03,1),
  (14,03,"2023-02-05",06,2),
  (15,03,"2023-02-10",03,1),
  (16,04,"2023-02-15",05,2),
  (17,04,"2023-02-30",03,1),
  (18,05,"2023-03-10",04,2),
  (19,05,"2023-03-15",03,1),
  (20,02,"2023-03-30",02,1),
  (21,02,"2023-04-01",03,1),
  (22,02,"2023-04-01",09,2),
  (23,04,"2023-05-01",04,1),
  (24,04,"2023-05-01",02,2),
  (25,04,"2023-05-01",09,1),
  (26,01,"2023-06-15",01,2),
  (27,01,"2023-06-15",06,1),
  (28,01,"2023-06-15",09,1),
  (29,05,"2023-07-20",08,1),
  (30,05,"2023-07-20",09,1),
  (31,07,"2023-08-05",09,1),
  (32,07,"2023-08-05",07,2),
  (33,07,"2023-08-05",02,1),
  (34,04,"2023-09-18",05,2),
  (35,04,"2023-09-18",06,1),
  (36,04,"2023-09-18",04,2),
  (37,05,"2023-10-09",05,1),
  (38,05,"2023-10-09",10,1),
  (39,05,"2023-10-09",07,1),
  (40,02,"2023-11-11",09,1),
  (41,02,"2023-11-11",08,1),
  (42,02,"2023-11-11",02,2),
  (43,06,"2023-12-22",10,2),
  (44,06,"2023-12-22",05,2),
  (45,06,"2023-12-22",02,3);
.mode box
SELECT * 
FROM Menu;
.mode box
SELECT * 
FROM Customer;
.mode box
SELECT * 
FROM Customer_Order;
.mode box

/* Total sales for each month */
SELECT STRFTIME('%m',Customer_Order.Date) AS Month,
CASE WHEN STRFTIME('%m',Customer_Order.Date) = '01' THEN 'January'
  WHEN STRFTIME('%m',Customer_Order.Date) = '02' THEN 'February'
  WHEN STRFTIME('%m',Customer_Order.Date) = '03' THEN 'March'
  WHEN STRFTIME('%m',Customer_Order.Date) = '04' THEN 'April'
  WHEN STRFTIME('%m',Customer_Order.Date) = '05' THEN 'May'
  WHEN STRFTIME('%m',Customer_Order.Date) = '06' THEN 'June'
  WHEN STRFTIME('%m',Customer_Order.Date) = '07' THEN 'July'
  WHEN STRFTIME('%m',Customer_Order.Date) = '08' THEN 'August'
  WHEN STRFTIME('%m',Customer_Order.Date) = '09' THEN 'September'
  WHEN STRFTIME('%m',Customer_Order.Date) = '10' THEN 'October'
  WHEN STRFTIME('%m',Customer_Order.Date) = '11' THEN 'November'
  WHEN STRFTIME('%m',Customer_Order.Date) = '12' THEN 'December'
  ELSE 'Invalid Month' END AS MonthName,
SUM(Menu.Price_menu*Customer_Order.Quantity) AS Sales
FROM Customer_Order
INNER JOIN Menu ON 
  Customer_Order.Menu_id = Menu.Menu_id
GROUP BY Month
ORDER BY Month;

/* Total Sales and quantity for each menu */
SELECT Menu.Menu_name, SUM(Menu.Price_menu*Customer_Order.Quantity) AS TotalSales, SUM(Customer_Order.Quantity) AS Quantity_Sold
FROM Customer_Order
INNER JOIN Menu ON 
Customer_Order.Menu_id = Menu.Menu_id
GROUP BY Menu.Menu_name
ORDER BY TotalSales DESC;

/* Total Sales and quantity for each type */
SELECT Menu.Type_menu, SUM(Menu.Price_menu*Customer_Order.Quantity) AS TotalSales, SUM(Customer_Order.Quantity) AS Quantity_Sold
FROM Customer_Order
INNER JOIN Menu ON 
Customer_Order.Menu_id = Menu.Menu_id
GROUP BY Menu.Type_menu
ORDER BY TotalSales DESC;
/* Join 3 Table */
SELECT Order_id , Customer.First_Name ||" "|| Customer.Last_Name AS FullName , Menu_name ,Type_menu, Price_menu,Quantity 
FROM Customer 
INNER JOIN Customer_Order ON
Customer.Customer_id = Customer_Order.Customer_id
INNER JOIN Menu ON 
Customer_Order.Menu_id = Menu.Menu_id
ORDER BY Order_id;
/* Total spending by each customer */
SELECT Customer.First_Name ||" "|| Customer.Last_Name AS FullName,
SUM(Menu.Price_menu*Customer_Order.Quantity) AS Spending
FROM Customer
INNER JOIN Customer_Order ON Customer.Customer_id = Customer_Order.Customer_id
INNER JOIN Menu ON Menu.Menu_id = Customer_Order.Menu_id
GROUP BY FullName
ORDER BY Spending DESC;

/* with clauses Query USA customer in 2023-01 */
WITH USA_Customers AS(
  SELECT * 
  FROM Customer 
  WHERE Country in("USA")
),Customer_Jan AS(
  SELECT *
  FROM Customer_Order
  WHERE STRFTIME("%Y-%m",Date) ="2023-01"
)
SELECT First_Name , Email ,COUNT(*) AS COUNT_USAinJAN_ORDER
FROM USA_Customers AS A1
INNER JOIN Customer_Jan AS A2 ON 
A1.Customer_id =A2.Customer_id
GROUP BY 1,2;

/* Most frequently sold together dishes in menu on jan*/
WITH preparetable AS(
  SELECT Order_id,STRFTIME('%m',Customer_Order.Date) AS Month, 
  Customer_id , Menu_name 
  FROM Customer_Order 
  INNER JOIN Menu ON 
  Menu.Menu_id = Customer_Order.Menu_id
  WHERE STRFTIME('%m',Customer_Order.Date)  ="01"
)
SELECT  t1.Menu_name, t2.Menu_name , COUNT(*)
FROM preparetable AS t1
INNER JOIN preparetable AS t2 ON
t1.Customer_id = t2.Customer_id
AND t1.Menu_name  < t2.Menu_name 
GROUP BY t1.Menu_name,t2.Menu_name 
ORDER BY COUNT(*) DESC,t1.Menu_name; 
