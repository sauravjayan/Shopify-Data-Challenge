
-- a.
-- Number of orders shipped by Speedy Express is given by the code below

SELECT COUNT(a.OrderID) AS "Number of Orders"
FROM (SELECT sa.OrderID, sa.ShipperID, sb.ShipperName
FROM Orders As sa
INNER JOIN
Shippers AS sb
ON sa.ShipperID = sb.ShipperID) AS a
WHERE a.ShipperName == "Speedy Express"

-- The number of orders shipped is 54

-- b.

SELECT b.LastName, COUNT(a.OrderID) AS n_orders
FROM Orders AS a
INNER JOIN
Employees AS b
ON a.EmployeeID = b.EmployeeID
GROUP BY b.LastName
ORDER BY n_orders DESC LIMIT 1

-- Last name of the employee with the most orders is Peacock.

-- c.

WITH Germany_table
AS (SELECT a.OrderID, b.ProductName, a.Country 
FROM (SELECT sa.OrderID, sa.CustomerID, sb.Country 
FROM Orders AS sa
INNER JOIN
Customers AS sb
ON sa.CustomerID = sb.CustomerID) AS a
INNER JOIN
(SELECT sa.OrderID, sa.ProductID, sb.ProductName
FROM OrderDetails AS sa
INNER JOIN 
Products AS sb
ON sa.ProductID = sb.ProductID) AS b
ON a.OrderID = b.OrderID
WHERE a.Country == 'Germany')
SELECT A.ProductName, COUNT(*) AS "Number of Orders"
FROM Germany_table AS A
GROUP BY A.ProductName
ORDER BY "Number of Orders" DESC LIMIT 1

-- Gorgonzola Telino was ordered the most by customers in Germany