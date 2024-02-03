# HW2  from restaurant pizza SQL
#create 3-5 dataframes => write table into PostgreSQL server


## connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

## create connection
con <- dbConnect(
  PostgreSQL(),
  host = "*****.db.elephantsql.com",
  dbname = "*****",
  user = "*****",
  password = "***************",
  port = 5432
)

##Create dataframe

menu <- tribble(
  ~menu_id, ~menu_name, ~price_menu,~type_menu,
01,"Rustica", 500, "Pizza",
02,"Bufalina", 360, "Pizza",
03,"Prosciutto_Pizza", 680, "Pizza",
04,"Roasted_Chicken", 500, "Main_course",
05,"Apple&Pineapple,", 80, "Drink",
06,"Caesar_Salad", 200, "Salad",
07,"Crab&Mango_Salad", 200, "Salad",
08,"Truffle_Bruschetta", 400, "Starter",
09,"Water", 20, "Drink",
10,"Lobster_Spaghetti",1660, "Main_course"
)

customer <- tribble(
  ~customer_id, ~first_Name,~last_Name,
~email,~country,~age,~phone,
01,"Walter","White", "Heisenberg99.1@example.com", "USA", 50, "012-346-5678",
02,"Hector","Salamanca", "DingDingDing@example.com", "Mexico", 70, "022-846-6978",
03,"Jesse","Pinkman", "AyoMrWhite@example.com", "USA", 25, "012-486-9667",
04,"Greta","Thunberg","HowDareYou@example.com","Sweden",20,"066-492-7983",
05,"Nancy","Pelosi","Pelosi@example.com","USA",80,"012-896-7842",
06,"Sam","Bankman-Fried", "SamBankman@example.com", "USA", 30, "015-488-7898",
07,"Do","Kwon","Luna888@example.com","Korea",32,"088-888-8888",
08,"Gojo","Satoru","UnlimitedVoid@example.com","Japan",28,"077-893-0166"
)

customer_order <- tribble(
  ~order_id, ~customer_id, ~date, ~menu_id, ~quantity,
01,06,"2023-01-01",08,1,
02,06,"2023-01-01",05,2,
03,06,"2023-01-01",10,1,
04,06,"2023-01-01",03,1,
05,08,"2023-01-01",01,1,
06,08,"2023-01-01",06,1,
07,08,"2023-01-01",02,1,
08,07,"2023-01-02",05,2,
09,07,"2023-01-02",03,1,
10,01,"2023-01-05",08,1,
11,01,"2023-01-05",03,1,
12,02,"2023-01-07",07,1,
13,02,"2023-01-07",03,1,
14,03,"2023-02-05",06,2,
15,03,"2023-02-10",03,1,
16,04,"2023-02-15",05,2,
17,04,"2023-02-30",03,1,
18,05,"2023-03-10",04,2,
19,05,"2023-03-15",03,1,
20,02,"2023-03-30",02,1,
21,02,"2023-04-01",03,1,
22,02,"2023-04-01",09,2,
23,04,"2023-05-01",04,1,
24,04,"2023-05-01",02,2,
25,04,"2023-05-01",09,1,
26,01,"2023-06-15",01,2,
27,01,"2023-06-15",06,1,
28,01,"2023-06-15",09,1,
29,05,"2023-07-20",08,1,
30,05,"2023-07-20",09,1,
31,07,"2023-08-05",09,1,
32,07,"2023-08-05",07,2,
33,07,"2023-08-05",02,1,
34,04,"2023-09-18",05,2,
35,04,"2023-09-18",06,1,
36,04,"2023-09-18",04,2,
37,05,"2023-10-09",05,1,
38,05,"2023-10-09",10,1,
39,05,"2023-10-09",07,1,
40,02,"2023-11-11",09,1,
41,02,"2023-11-11",08,1,
42,02,"2023-11-11",02,2,
43,06,"2023-12-22",10,2,
44,06,"2023-12-22",05,2,
45,06,"2023-12-22",02,3
)

## database List Tables
dbWriteTable(con, "menu", menu)
dbWriteTable(con, "customer", customer)
dbWriteTable(con, "customer_order", customer_order)


# check database tables ,get data
dbListTables(con)
dbGetQuery(con, "select * from menu")
dbGetQuery(con, "select * from customer")
dbGetQuery(con, "select * from customer_order")

# Disconnect from database 
dbDisconnect(con)









