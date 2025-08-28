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

/* Task 7 create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked.
Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.*/

delimiter $$
CREATE PROCEDURE CheckBooking(IN p_date DATE,IN p_table_number INT)
BEGIN
select if(exists(

			select customer_id
			from bookings b join diningtable di on b.table_id = di.table_id
			where di.table_number = p_table_number
				and date(b.booking_datetime) = p_date
				and b.booking_status in ('CONFIRMED','SEATED')
			),
			CONCAT('Table ', p_table_number, ' is already booked'),
			CONCAT('Table ', p_table_number, ' is available')
           ) as 'Booking Status';
END$$
delimiter ;

CALL CheckBooking('2022-11-12', 3);

/* Task 8 Little Lemon need to verify a booking, and decline any reservations
for tables that are already booked under another name.*/

DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER $$

CREATE PROCEDURE AddValidBooking(IN p_date DATE, IN p_table_number INT)
BEGIN
  START TRANSACTION;

  INSERT INTO bookings
    (customer_id, table_id, staff_id, booking_datetime, party_size, booking_status, notes)
  SELECT 1, d.table_id, NULL, CONCAT(p_date,' 00:00:00'), 2, 'CONFIRMED', 'AddValidBooking'
  FROM diningtable d
  WHERE d.table_number = p_table_number
    AND NOT EXISTS (
      SELECT 1 FROM bookings b
      WHERE b.table_id = d.table_id
        AND DATE(b.booking_datetime) = p_date
        AND b.booking_status IN ('CONFIRMED','SEATED')
    )
  LIMIT 1;

  IF ROW_COUNT() = 1 THEN
    COMMIT;
    SELECT CONCAT('Booking confirmed for table ', p_table_number, ' on ', p_date) AS `Booking status`;
  ELSE
    ROLLBACK;
    SELECT CONCAT('Table ', p_table_number, ' is already booked') AS `Booking status`;
  END IF;
END$$

DELIMITER ;

/* Task 9 In this first task you need to create a new procedure called AddBooking to add a new table booking record.
The procedure should include four input parameters in the form of the following bookings parameters:*/

DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER $$

CREATE PROCEDURE AddBooking(
  IN p_booking_id   INT,
  IN p_customer_id  INT,
  IN p_table_number INT,
  IN p_booking_date DATE
)
BEGIN
  DECLARE v_table_id INT;

  -- look up the table_id for the given table number
  SELECT dt.table_id
    INTO v_table_id
  FROM diningtable AS dt
  WHERE dt.table_number = p_table_number
  LIMIT 1;

  -- insert the booking (set any defaults you like)
  INSERT INTO bookings
    (booking_id, customer_id, table_id, staff_id, booking_datetime,
     party_size, booking_status, notes)
  VALUES
    (p_booking_id, p_customer_id, v_table_id, NULL,
     CONCAT(p_booking_date, ' 00:00:00'),
     2, 'CONFIRMED', 'Added via AddBooking');

  SELECT 'New booking added' AS Confirmation;
END$$

DELIMITER ;

CALL AddBooking(21, 3, 4, '2022-12-30');

/* Task 10 For your second task, Little Lemon need you to create a new procedure called UpdateBooking that they can use
to update existing bookings in the booking table.*/

DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER $$

CREATE PROCEDURE UpdateBooking(IN p_booking_id INT, IN p_booking_date DATE)
BEGIN
  UPDATE bookings
     SET booking_datetime = CONCAT(p_booking_date, ' 00:00:00'),
         notes = 'Updated via UpdateBooking'
   WHERE booking_id = p_booking_id;

  SELECT IF(ROW_COUNT() = 0,
            CONCAT('Booking ', p_booking_id, ' not found'),
            CONCAT('Booking ', p_booking_id, ' updated')) AS Confirmation;
END$$

DELIMITER ;

CALL UpdateBooking(9, '2022-12-17');

/* Task 11 Little Lemon need you to create a new procedure called CancelBooking that they can use
to cancel or remove a booking.*/

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER $$

CREATE PROCEDURE CancelBooking(IN p_booking_id INT)
BEGIN
  DELETE FROM bookings
  WHERE booking_id = p_booking_id;

  SELECT IF(ROW_COUNT() = 0,
            CONCAT('Booking ', p_booking_id, ' not found'),
            CONCAT('Booking ', p_booking_id, ' cancelled')) AS Confirmation;
END$$

DELIMITER ;

CALL CancelBooking(9);

