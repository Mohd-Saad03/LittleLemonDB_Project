INSERT INTO category (category_name) VALUES
('Starters'),('Salads'),('Mains'),('Pizza'),('Pasta'),('Seafood'),('Desserts'),('Beverages');

INSERT INTO customers (first_name,last_name,email,phone_number) VALUES
('Vanessa','McCarthy','vanessa@example.com','+1-555-0101'),
('Marcos','Romero','marcos@example.com','+1-555-0102'),
('Aisha','Khan','aisha@example.com','+1-555-0103'),
('Rahul','Verma','rahul@example.com','+1-555-0104'),
('Priya','Patel','priya@example.com','+1-555-0105'),
('John','Smith','john.smith@example.com','+1-555-0106'),
('Sara','Ali','sara.ali@example.com','+1-555-0107'),
('Aman','Gupta','aman.g@example.com','+1-555-0108'),
('Neha','Sharma','neha.sharma@example.com','+1-555-0109'),
('Omar','Hassan','omar.hassan@example.com','+1-555-0110'),
('Emily','Davis','emily.davis@example.com','+1-555-0111'),
('Daniel','White','daniel.white@example.com','+1-555-0112'),
('Lina','Costa','lina.costa@example.com','+1-555-0113'),
('Kevin','Brown','kevin.brown@example.com','+1-555-0114'),
('Nora','Lopez','nora.lopez@example.com','+1-555-0115'),
('Mina','Park','mina.park@example.com','+1-555-0116'),
('Tom','Green','tom.green@example.com','+1-555-0117'),
('Ahmed','Said','ahmed.said@example.com','+1-555-0118'),
('Ivy','Lee','ivy.lee@example.com','+1-555-0119'),
('Yuki','Tanaka','yuki.tanaka@example.com','+1-555-0120');

INSERT INTO staff (first_name,last_name,role,salary,phone_number,email) VALUES
('Maya','Singh','HOST',35000.00,'+91-90000-00001','host1@littlelemon.local'),
('Ravi','Kumar','WAITER',28000.00,'+91-90000-00002','waiter1@littlelemon.local'),
('Anita','Roy','MANAGER',55000.00,'+91-90000-00003','manager1@littlelemon.local'),
('Karan','Patil','CHEF',45000.00,'+91-90000-00004','chef1@littlelemon.local'),
('Neel','Shah','WAITER',29000.00,'+91-90000-00005','waiter2@littlelemon.local'),
('Zara','Qureshi','HOST',36000.00,'+91-90000-00006','host2@littlelemon.local'),
('Sanjay','Kohli','DELIVERY',27000.00,'+91-90000-00007','rider1@littlelemon.local'),
('Pooja','Iyer','CHEF',47000.00,'+91-90000-00008','chef2@littlelemon.local');

INSERT INTO diningtable (table_number,capacity) VALUES
(1,2),(2,4),(3,4),(4,6),(5,2),(6,8),(7,4),(8,4),(9,6),(10,2),(11,8),(12,4);

INSERT INTO menuitems (name,price,is_active,category_id) VALUES
('Bruschetta',250.00,1,1),
('Garlic Bread',200.00,1,1),
('Greek Salad',350.00,1,2),
('Caesar Salad',300.00,1,2),
('Grilled Chicken',450.00,1,3),
('Steak',600.00,1,3),
('Margherita Pizza',400.00,1,4),
('Pepperoni Pizza',500.00,1,4),
('Spaghetti Carbonara',350.00,1,5),
('Fettuccine Alfredo',300.00,1,5),
('Grilled Salmon',650.00,1,6),
('Shrimp Platter',550.00,1,6),
('Tiramisu',250.00,1,7),
('Cheesecake',300.00,1,7),
('Lemonade',150.00,1,8),
('Espresso',100.00,1,8),
('Moussaka',500.00,1,3),
('Manti',400.00,1,3);

INSERT INTO bookings (customer_id,table_id,staff_id,booking_datetime,party_size,booking_status,notes) VALUES
(1,1,1,'2025-08-01 11:30:00',2,'CONFIRMED','Lunch'),
(2,2,1,'2025-08-01 12:15:00',2,'CONFIRMED','Lunch'),
(3,3,2,'2025-08-02 18:45:00',3,'CONFIRMED','Dinner'),
(4,4,2,'2025-08-02 19:00:00',2,'CONFIRMED','Dinner'),
(5,5,3,'2025-08-03 19:30:00',2,'CONFIRMED','Dinner'),
(6,6,3,'2025-08-03 12:30:00',4,'CONFIRMED','Lunch'),
(7,7,4,'2025-08-04 20:00:00',2,'CONFIRMED','Dinner'),
(8,8,4,'2025-08-04 21:00:00',2,'CONFIRMED','Late'),
(9,9,5,'2025-08-05 18:30:00',3,'CONFIRMED','Dinner'),
(10,10,5,'2025-08-05 19:30:00',4,'CONFIRMED','Family'),
(11,11,6,'2025-08-06 09:00:00',2,'CONFIRMED','Breakfast'),
(12,12,6,'2025-08-06 13:00:00',2,'CONFIRMED','Lunch'),
(13,1,7,'2025-08-07 12:30:00',2,'CONFIRMED','Lunch'),
(14,2,7,'2025-08-07 19:00:00',2,'CONFIRMED','Dinner'),
(15,3,8,'2025-08-08 20:00:00',4,'CONFIRMED','Group');

INSERT INTO orders (booking_id,customer_id,order_datetime,order_type,payment_status,total_amount) VALUES
(1,1,'2025-08-01 12:00:00','DINE_IN','PAID',1050.00),
(2,2,'2025-08-01 12:30:00','DINE_IN','PAID',1100.00),
(NULL,1,'2025-08-02 13:00:00','TAKEAWAY','PAID',750.00),
(3,3,'2025-08-02 19:15:00','DINE_IN','PAID',1200.00),
(4,4,'2025-08-03 15:10:00','DINE_IN','PAID',1300.00),
(5,5,'2025-08-03 20:00:00','DELIVERY','PENDING',1300.00),
(6,6,'2025-08-04 12:20:00','DINE_IN','PAID',1250.00),
(7,7,'2025-08-04 21:05:00','TAKEAWAY','PAID',1650.00),
(8,8,'2025-08-04 21:30:00','DELIVERY','PAID',2350.00),
(9,9,'2025-08-05 19:45:00','DINE_IN','PAID',1450.00),
(10,10,'2025-08-05 20:00:00','DINE_IN','PAID',1500.00),
(11,11,'2025-08-06 09:30:00','TAKEAWAY','PAID',1200.00),
(12,12,'2025-08-06 18:50:00','DELIVERY','PAID',1550.00),
(13,13,'2025-08-07 12:45:00','DINE_IN','PAID',1600.00),
(14,14,'2025-08-07 19:30:00','DINE_IN','PAID',2050.00),
(15,15,'2025-08-08 20:30:00','DELIVERY','PENDING',1500.00),
(NULL,16,'2025-08-08 13:10:00','DINE_IN','PAID',1350.00),
(NULL,17,'2025-08-08 17:40:00','DINE_IN','REFUNDED',1800.00),
(NULL,18,'2025-08-09 12:15:00','TAKEAWAY','PAID',2000.00),
(NULL,19,'2025-08-09 19:20:00','DELIVERY','PAID',2500.00);

INSERT INTO orderitem (order_id,menu_item_id,quantity,unit_price) VALUES
(1,1,3,250.00),
(1,15,2,150.00),

(2,8,1,500.00),
(2,14,2,300.00),

(3,16,5,100.00),
(3,13,1,250.00),

(4,7,3,400.00),

(5,15,4,150.00),
(5,3,2,350.00),

(6,11,2,650.00),

(7,9,3,350.00),
(7,2,1,200.00),

(8,6,2,600.00),
(8,15,3,150.00),

(9,8,4,500.00),
(9,3,1,350.00),

(10,18,3,400.00),
(10,13,1,250.00),

(11,5,2,450.00),
(11,4,2,300.00),

(12,16,6,100.00),
(12,14,2,300.00),

(13,12,2,550.00),
(13,15,3,150.00),

(14,2,4,200.00),
(14,7,2,400.00),

(15,3,5,350.00),
(15,15,2,150.00),

(16,17,3,500.00),

(17,10,2,300.00),
(17,13,3,250.00),

(18,6,3,600.00),

(19,9,4,350.00),
(19,15,4,150.00),

(20,11,2,650.00),
(20,8,2,500.00),
(20,16,2,100.00);

INSERT INTO orderdeliverystatus (order_id,delivery_datetime,delivery_status,courier_name,notes) VALUES
(6,'2025-08-03 21:10:00','IN_TRANSIT','Own Rider','Evening delivery'),
(9,'2025-08-04 23:00:00','DELIVERED','Swiggy Genie','Delivered to apartment'),
(13,'2025-08-06 20:10:00','DELIVERED','Dunzo','Customer confirmed'),
(16,'2025-08-08 21:15:00','ASSIGNED','Own Rider','Waiting for pickup'),
(20,'2025-08-09 21:30:00','DELIVERED','Dunzo','Paid online');
