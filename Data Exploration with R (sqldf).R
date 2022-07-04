install.packages("sqldf", dependencies = "TRUE")
library("sqldf")
#import employees data
#import orders data
male_employees <-sqldf("SELECT* FROM employees WHERE gender = 'm'")
female_employees <- sqldf("SELECT* FROM employees WHERE gender = 'f'")
firstname_counts <- sqldf("SELECT firstname, COUNT(firstname) AS Occurances FROM employees GROUP BY firstname")
firstname_counts <- sqldf("SELECT firstname, COUNT(firstname) AS Occurances FROM employees WHERE firstname != 'rudi' GROUP BY firstname")
gender_counts <- sqldf("SELECT gender, COUNT(gender) AS Occurances FROM employees GROUP BY gender")
employees_cali <- sqldf("SELECT*, CASE WHEN lower(firstname) = 'stewart' THEN 1 WHEN lower(firstname) = 'hila' THEN 1 WHEN lower(firstname) = 'jon' THEN 1 ELSE 0 END AS emp_cali FROM employees")
employees_cali_order <- sqldf("SELECT*, CASE WHEN lower(firstname) = 'stewart' THEN 1 WHEN lower(firstname) = 'hila' THEN 1 WHEN lower(firstname) = 'jon' THEN 1 ELSE 0 END AS emp_cali FROM employees ORDER BY emp_cali DESC, firstname")
##Multi-table-function##

left_join <- sqldf("SELECT* FROM employees LEFT JOIN orders ON employees.id = orders.id")
right_join <- sqldf("SELECT* FROM orders LEFT JOIN employees ON orders.id = employees.id")
inner_join <- sqldf("SELECT* FROM orders INNER JOIN employees ON orders.id = employees.id")
inexpensive_items <- sqldf("SELECT* FROM orders LEFT JOIN employees ON employees.id = orders.id WHERE item_cost < 10 ORDER BY item_cost")
lineitemcost <- sqldf("SELECT*, (item_cost * quantity_ordered) AS itemlevelcost FROM orders LEFT JOIN employees ON orders.id = employees.id WHERE itemlevelcost < 20 ORDER BY itemlevelcost")
sqldf("SELECT SUM(item_cost * quantity_ordered)/COUNT(DISTINCT id) AS avglunchcost FROM orders WHERE id != 'NA'")
lightweight_employees <- sqldf("SELECT firstname,lastname, SUM(item_cost * quantity_ordered) AS lunchcost FROM orders LEFT JOIN employees ON orders.id = employees.id WHERE orders.id !='NA' GROUP BY orders.id HAVING lunchcost < 56")
