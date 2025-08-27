-- Task 1 Created a view called OrdersView where quantity is greater than 2
CREATE VIEW Ordersview AS
SELECT
  oi.order_id   AS OrderID,
  SUM(oi.quantity)   AS Quantity,
  CAST(SUM(oi.quantity * oi.unit_price) AS DECIMAL(10,2)) AS Cost
FROM orderitem AS oi
GROUP BY oi.order_id
HAVING SUM(oi.quantity) > 2;

select * from ordersview;

-- Task 2 get data from diffrent table where cost is > 150
SELECT
  c.customer_id AS CustomerID,
  CONCAT(c.first_name,' ',c.last_name) AS FullName,
  o.order_id AS OrderID,
  CAST(o.total_amount AS DECIMAL(10,2)) AS Cost,
  cat.category_name AS MenuName,
  mi.name AS CourseName
FROM orders o
JOIN customers c  ON c.customer_id = o.customer_id
JOIN orderitem oi ON oi.order_id = o.order_id
JOIN menuitems mi ON mi.menu_item_id = oi.menu_item_id
JOIN category cat ON cat.category_id = mi.category_id

-- Task 3 find all menu items for which more than 2 orders have been placed use quantity > 2
SELECT DISTINCT mi.name AS MenuName
FROM menuitems mi
WHERE mi.menu_item_id = ANY (
  SELECT oi.menu_item_id
  FROM orderitem oi
  WHERE oi.quantity > 2
)
ORDER BY MenuName;

-- Task 4 created a procedure that displays the maximum ordered quantity in the Orders table.

delimiter $$
CREATE PROCEDURE GetMaxQuantity()
BEGIN
  -- Max single-line quantity across all order items
  SELECT MAX(oi.quantity) AS 'Max Quantity in Order'
  FROM orderitem AS oi;
END$$
Delimiter;

call getmaxquantity()


-- Task 5 Created the prepared statement for order detail and the input parameter value will be customer_id 
PREPARE GetOrderDetail FROM
'SELECT
    o.order_id                            AS OrderID,
    SUM(oi.quantity)                      AS Quantity,
    CAST(SUM(oi.quantity*oi.unit_price) AS DECIMAL(10,2)) AS Cost
  FROM orders o
  JOIN orderitem oi ON oi.order_id = o.order_id
  WHERE o.customer_id = ?
  GROUP BY o.order_id';

-- Run it for a specific customer
SET @id = 3;
EXECUTE GetOrderDetail USING @id;

-- Task 6 Created a Cancelleorder Procedure to delete an order record based on the user input of the order id.

DELIMITER $$

CREATE PROCEDURE CancelOrder(IN p_order_id INT)
BEGIN
  DELETE FROM orders WHERE order_id = p_order_id;

  -- one-row message based on whether anything was deleted
  SELECT IF(ROW_COUNT() = 0,
            CONCAT('Order ', p_order_id, ' not found'),
            CONCAT('Order ', p_order_id, ' is cancelled')) AS Confirmation;
END$$

DELIMITER ;

