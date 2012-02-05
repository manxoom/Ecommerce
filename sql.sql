--
-- Database: `ecommerce2`
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` tinyint(3) unsigned NOT NULL,
  `user_session_id` char(32) NOT NULL,
  `product_type` enum('coffee','other') NOT NULL,
  `product_id` mediumint(8) unsigned NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `product_type` (`product_type`,`product_id`),
  KEY `user_session_id` (`user_session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(80) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `address1` varchar(80) NOT NULL,
  `address2` varchar(80) DEFAULT NULL,
  `city` varchar(60) NOT NULL,
  `state` char(2) NOT NULL,
  `zip` mediumint(5) unsigned zerofill NOT NULL,
  `phone` int(10) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `general_coffees`
--

CREATE TABLE `general_coffees` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(40) NOT NULL,
  `description` tinytext,
  `image` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`category`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `general_coffees`
--

INSERT INTO `general_coffees` VALUES(1, 'Original Blend', 'Our original blend, featuring a quality mixture of bean and a medium roast for a rich color and smooth flavor.', 'original_coffee.jpg');
INSERT INTO `general_coffees` VALUES(2, 'Dark Roast', 'Our darkest, non-espresso roast, with a full flavor and a slightly bitter aftertaste.', 'dark_roast.jpg');
INSERT INTO `general_coffees` VALUES(3, 'Kona', 'A real treat! Kona coffee, fresh from the lush mountains of Hawaii. Smooth in flavor and perfectly roasted!', 'kona.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `non_coffee_categories`
--

CREATE TABLE `non_coffee_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(40) NOT NULL,
  `description` tinytext NOT NULL,
  `image` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


-- Dumping data for table `non_coffee_categories`
--

INSERT INTO `non_coffee_categories` VALUES(1, 'Edibles', 'A wonderful assortment of goodies to eat. Includes biscotti, baklava, lemon bars, and more!', 'goodies.jpg');
INSERT INTO `non_coffee_categories` VALUES(2, 'Gift Baskets', 'Gift baskets for any occasion! Including our many coffees and other goodies.', 'gift_basket.jpg');
INSERT INTO `non_coffee_categories` VALUES(3, 'Mugs', 'A selection of lovely mugs for enjoying your coffee, tea, hot cocoa or other hot beverages.', '781426_32573620.jpg');
INSERT INTO `non_coffee_categories` VALUES(4, 'Books', 'Our recommended books about coffee, goodies, plus anything written by Larry Ullman!', 'books.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `non_coffee_products`
--

CREATE TABLE `non_coffee_products` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `non_coffee_category_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(60) NOT NULL,
  `description` tinytext,
  `image` varchar(45) NOT NULL,
  `price` decimal(5,2) unsigned NOT NULL,
  `stock` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `non_coffee_category_id` (`non_coffee_category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `non_coffee_products`
--

INSERT INTO `non_coffee_products` VALUES(1, 3, 'Pretty Flower Coffee Mug', 'A pretty coffee mug with a flower design on a white background.', 'd9996aee5639209b3fb618b07e10a34b27baad12.jpg', 6.50, 105, '2010-08-15 12:22:35');
INSERT INTO `non_coffee_products` VALUES(2, 3, 'Red Dragon Mug', 'An elaborate, painted gold dragon on a red background. With partially detached, fancy handle.', '847a1a3bef0fb5c2f2299b06dd63669000f5c6c4.jpg', 7.95, 22, '2010-08-18 16:00:59');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `total` decimal(7,2) unsigned DEFAULT NULL,
  `shipping` decimal(5,2) unsigned NOT NULL,
  `credit_card_number` mediumint(4) unsigned NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `order_date` (`order_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_contents`
--

CREATE TABLE `order_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_type` enum('coffee','other','sale') DEFAULT NULL,
  `product_id` mediumint(8) unsigned NOT NULL,
  `quantity` tinyint(3) unsigned NOT NULL,
  `price_per` decimal(5,2) unsigned NOT NULL,
  `ship_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ship_date` (`ship_date`),
  KEY `product_type` (`product_type`,`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_type` enum('coffee','other') DEFAULT NULL,
  `product_id` mediumint(8) unsigned NOT NULL,
  `price` decimal(5,2) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `start_date` (`start_date`),
  KEY `product_type` (`product_type`,`product_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` VALUES(1, 'other', 1, 5.00, '2010-08-16', '2010-09-30');
INSERT INTO `sales` VALUES(2, 'coffee', 7, 7.00, '2010-08-19', NULL);
INSERT INTO `sales` VALUES(3, 'coffee', 9, 13.00, '2010-08-19', '2010-09-29');
INSERT INTO `sales` VALUES(4, 'other', 2, 7.00, '2010-08-22', NULL);
INSERT INTO `sales` VALUES(5, 'coffee', 8, 13.00, '2010-08-22', '2010-09-30');
INSERT INTO `sales` VALUES(6, 'coffee', 10, 30.00, '2010-08-22', '2010-09-30');

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `size` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `size` (`size`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` VALUES(1, '2 oz. Sample');
INSERT INTO `sizes` VALUES(2, 'Half Pound');
INSERT INTO `sizes` VALUES(3, '1 lb.');
INSERT INTO `sizes` VALUES(4, '2 lbs.');
INSERT INTO `sizes` VALUES(5, '5 lbs.');

-- --------------------------------------------------------

--
-- Table structure for table `specific_coffees`
--

CREATE TABLE `specific_coffees` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `general_coffee_id` tinyint(3) unsigned NOT NULL,
  `size_id` tinyint(3) unsigned NOT NULL,
  `caf_decaf` enum('caf','decaf') DEFAULT NULL,
  `ground_whole` enum('ground','whole') DEFAULT NULL,
  `price` decimal(5,2) unsigned NOT NULL,
  `stock` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `general_coffee_id` (`general_coffee_id`),
  KEY `size` (`size_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `specific_coffees`
--

INSERT INTO `specific_coffees` VALUES(1, 3, 1, 'caf', 'ground', 2.00, 15, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(2, 3, 2, 'caf', 'ground', 4.50, 29, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(3, 3, 2, 'decaf', 'ground', 5.00, 21, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(4, 3, 3, 'caf', 'ground', 8.00, 35, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(5, 3, 3, 'decaf', 'ground', 8.50, 21, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(6, 3, 3, 'caf', 'whole', 7.50, 50, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(7, 3, 3, 'decaf', 'whole', 8.00, 17, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(8, 3, 4, 'caf', 'whole', 15.00, 26, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(9, 3, 4, 'decaf', 'whole', 15.50, 15, '2010-08-15 19:15:54');
INSERT INTO `specific_coffees` VALUES(10, 3, 5, 'caf', 'whole', 32.50, 3, '2010-08-15 19:15:54');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `type` varchar(18) NOT NULL,
  `amount` decimal(7,2) NOT NULL,
  `response_code` tinyint(1) unsigned NOT NULL,
  `response_reason` tinytext,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `response` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wish_lists`
--

CREATE TABLE `wish_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` tinyint(3) unsigned NOT NULL,
  `user_session_id` char(32) NOT NULL,
  `product_type` enum('coffee','other','sale') DEFAULT NULL,
  `product_id` mediumint(8) unsigned NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `product_type` (`product_type`,`product_id`),
  KEY `user_session_id` (`user_session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- -----------------------------
-- Stored Procedures --
-- -----------------------------

DELIMITER $$
CREATE PROCEDURE select_categories (type VARCHAR(6))
BEGIN
IF type = 'coffee' THEN
SELECT * FROM general_coffees ORDER by category;
ELSEIF type = 'other' THEN
SELECT * FROM non_coffee_categories ORDER by category;
END IF;
END$$
DELIMITER;

DELIMITER $$
CREATE PROCEDURE select_products(type VARCHAR(6), cat TINYINT)
BEGIN
	IF type = 'coffee' THEN
SELECT	gc.description, gc.image, CONCAT("C", sc.id) AS sku, 
CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole, sc.price) AS name, 
sc.stock 
FROM specific_coffees AS sc INNER JOIN sizes AS s ON s.id=sc.size_id 
INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id 
WHERE general_coffee_id=cat AND stock>0 
ORDER by name ASC;
	ELSEIF type = 'other' THEN
SELECT ncc.description AS g_description, ncc.image AS g_image, 
CONCAT("O", ncp.id) AS sku, ncp.name, ncp.description, ncp.image, 
ncp.price, ncp.stock 
FROM non_coffee_products AS ncp INNER JOIN non_coffee_categories AS ncc 
ON ncc.id=ncp.non_coffee_category_id 
WHERE non_coffee_category_id=cat ORDER by date_created DESC;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE select_sale_items (get_all BOOLEAN)
BEGIN
IF get_all = 1 THEN 
SELECT CONCAT("O", ncp.id) AS sku, sa.price AS sale_price, ncc.category, ncp.image, ncp.name, ncp.price, ncp.stock, ncp.description FROM sales AS sa INNER JOIN non_coffee_products AS ncp ON sa.product_id=ncp.id INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id WHERE sa.product_type="other" AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) )
UNION SELECT CONCAT("C", sc.id), sa.price, gc.category, gc.image, CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole), sc.price, sc.stock, gc.description FROM sales AS sa INNER JOIN specific_coffees AS sc ON sa.product_id=sc.id INNER JOIN sizes AS s ON s.id=sc.size_id INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id WHERE sa.product_type="coffee" AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) );
ELSE 
(SELECT CONCAT("O", ncp.id) AS sku, sa.price AS sale_price, ncc.category, ncp.image, ncp.name FROM sales AS sa INNER JOIN non_coffee_products AS ncp ON sa.product_id=ncp.id INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id WHERE sa.product_type="other" AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) ) ORDER BY RAND() LIMIT 2) UNION (SELECT CONCAT("C", sc.id), sa.price, gc.category, gc.image, CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole) FROM sales AS sa INNER JOIN specific_coffees AS sc ON sa.product_id=sc.id INNER JOIN sizes AS s ON s.id=sc.size_id INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id WHERE sa.product_type="coffee" AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) ) ORDER BY RAND() LIMIT 2);
END IF;
END$$
DELIMITER ;


-- -----------------------------

-- -----------------------------

DELIMITER $$
CREATE PROCEDURE select_products(type VARCHAR(6), cat TINYINT)
BEGIN
IF type = 'coffee' THEN
SELECT gc.description, gc.image, CONCAT("C", sc.id) AS sku, 
CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole, sc.price) AS name, 
sc.stock, sc.price, sales.price AS sale_price 
FROM specific_coffees AS sc INNER JOIN sizes AS s ON s.id=sc.size_id 
INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id 
LEFT OUTER JOIN sales ON (sales.product_id=sc.id 
AND sales.product_type='coffee' AND 
((NOW() BETWEEN sales.start_date AND sales.end_date) 
OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) 
WHERE general_coffee_id=cat AND stock>0 
ORDER by name;
ELSEIF type = 'other' THEN
SELECT ncc.description AS g_description, ncc.image AS g_image, 
CONCAT("O", ncp.id) AS sku, ncp.name, ncp.description, ncp.image, 
ncp.price, ncp.stock, sales.price AS sale_price
FROM non_coffee_products AS ncp INNER JOIN non_coffee_categories AS ncc 
ON ncc.id=ncp.non_coffee_category_id 
LEFT OUTER JOIN sales ON (sales.product_id=ncp.id 
AND sales.product_type='other' AND 
((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) )
WHERE non_coffee_category_id=cat ORDER by date_created DESC;
END IF;
END$$
DELIMITER ;

-- -----------------------------

-- -----------------------------

DELIMITER $$
CREATE PROCEDURE update_cart (uid CHAR(32), type VARCHAR(6), pid MEDIUMINT, qty TINYINT)
BEGIN
IF qty > 0 THEN
UPDATE carts SET quantity=qty, date_modified=NOW() WHERE user_session_id=uid AND product_type=type AND product_id=pid;
ELSEIF qty = 0 THEN
CALL remove_from_cart (uid, type, pid);
END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE add_to_cart (uid CHAR(32), type VARCHAR(6), pid MEDIUMINT, qty TINYINT)
BEGIN
DECLARE cid INT;
SELECT id INTO cid FROM carts WHERE user_session_id=uid AND product_type=type AND product_id=pid;
IF cid > 0 THEN
UPDATE carts SET quantity=quantity+qty, date_modified=NOW() WHERE id=cid;
ELSE 
INSERT INTO carts (user_session_id, product_type, product_id, quantity) VALUES (uid, type, pid, qty);
END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE remove_from_cart (uid CHAR(32), type VARCHAR(6), pid MEDIUMINT)
BEGIN
DELETE FROM carts WHERE user_session_id=uid AND product_type=type AND product_id=pid;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_shopping_cart_contents (uid CHAR(32))
BEGIN
SELECT CONCAT("O", ncp.id) AS sku, c.quantity, ncc.category, ncp.name, ncp.price, ncp.stock, sales.price AS sale_price FROM carts AS c INNER JOIN non_coffee_products AS ncp ON c.product_id=ncp.id INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id LEFT OUTER JOIN sales ON (sales.product_id=ncp.id AND sales.product_type='other' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) WHERE c.product_type="other" AND c.user_session_id=uid UNION SELECT CONCAT("C", sc.id), c.quantity, gc.category, CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole), sc.price, sc.stock, sales.price FROM carts AS c INNER JOIN specific_coffees AS sc ON c.product_id=sc.id INNER JOIN sizes AS s ON s.id=sc.size_id INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id LEFT OUTER JOIN sales ON (sales.product_id=sc.id AND sales.product_type='coffee' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) WHERE c.product_type="coffee" AND c.user_session_id=uid;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE update_wish_list (uid CHAR(32), type VARCHAR(6), pid MEDIUMINT, qty TINYINT)
BEGIN
IF qty > 0 THEN
UPDATE wish_lists SET quantity=qty, date_modified=NOW() WHERE user_session_id=uid AND product_type=type AND product_id=pid;
ELSEIF qty = 0 THEN
CALL remove_from_wish_list (uid, type, pid);
END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE add_to_wish_list (uid CHAR(32), type VARCHAR(6), pid MEDIUMINT, qty TINYINT)
BEGIN
DECLARE cid INT;
SELECT id INTO cid FROM wish_lists WHERE user_session_id=uid AND product_type=type AND product_id=pid;
IF cid > 0 THEN
UPDATE wish_lists SET quantity=quantity+qty, date_modified=NOW() WHERE id=cid;
ELSE 
INSERT INTO wish_lists (user_session_id, product_type, product_id, quantity) VALUES (uid, type, pid, qty);
END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE remove_from_wish_list (uid CHAR(32), type VARCHAR(6), pid MEDIUMINT)
BEGIN
DELETE FROM wish_lists WHERE user_session_id=uid AND product_type=type AND product_id=pid;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_wish_list_contents (uid CHAR(32))
BEGIN
SELECT CONCAT("O", ncp.id) AS sku, wl.quantity, ncc.category, ncp.name, ncp.price, ncp.stock, sales.price AS sale_price FROM wish_lists AS wl INNER JOIN non_coffee_products AS ncp ON wl.product_id=ncp.id INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id LEFT OUTER JOIN sales ON (sales.product_id=ncp.id AND sales.product_type='other' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) WHERE wl.product_type="other" AND wl.user_session_id=uid UNION SELECT CONCAT("C", sc.id), wl.quantity, gc.category, CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole), sc.price, sc.stock, sales.price FROM wish_lists AS wl INNER JOIN specific_coffees AS sc ON wl.product_id=sc.id INNER JOIN sizes AS s ON s.id=sc.size_id INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id LEFT OUTER JOIN sales ON (sales.product_id=sc.id AND sales.product_type='coffee' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) WHERE wl.product_type="coffee" AND wl.user_session_id=uid;
END$$
DELIMITER ;

-- -----------------------------

-- -----------------------------

DELIMITER $$
CREATE PROCEDURE add_customer (e VARCHAR(80), f VARCHAR(20), l VARCHAR(40), a1 VARCHAR(80), a2 VARCHAR(80), c VARCHAR(60), s CHAR(2), z MEDIUMINT, p INT, OUT cid INT)
BEGIN
	INSERT INTO customers VALUES (NULL, e, f, l, a1, a2, c, s, z, p, NOW());
	SELECT LAST_INSERT_ID() INTO cid;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE add_order (cid INT, uid CHAR(32), ship DECIMAL(5,2), cc MEDIUMINT, OUT total DECIMAL(7,2), OUT oid INT)
BEGIN
	DECLARE subtotal DECIMAL(7,2);
	INSERT INTO orders (customer_id, shipping, credit_card_number, order_date) VALUES (cid, ship, cc, NOW());
	SELECT LAST_INSERT_ID() INTO oid;
	INSERT INTO order_contents (order_id, product_type, product_id, quantity, price_per) SELECT oid, c.product_type, c.product_id, c.quantity, IFNULL(sales.price, ncp.price) FROM carts AS c INNER JOIN non_coffee_products AS ncp ON c.product_id=ncp.id LEFT OUTER JOIN sales ON (sales.product_id=ncp.id AND sales.product_type='other' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) WHERE c.product_type="other" AND c.user_session_id=uid UNION SELECT oid, c.product_type, c.product_id, c.quantity, IFNULL(sales.price, sc.price) FROM carts AS c INNER JOIN specific_coffees AS sc ON c.product_id=sc.id LEFT OUTER JOIN sales ON (sales.product_id=sc.id AND sales.product_type='coffee' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) WHERE c.product_type="coffee" AND c.user_session_id=uid;
	SELECT SUM(quantity*price_per) INTO subtotal FROM order_contents WHERE order_id=oid;
	UPDATE orders SET total = (subtotal + ship) WHERE id=oid;
	SELECT (subtotal + ship) INTO total;
	
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE add_transaction (oid INT, trans_type VARCHAR(18), amt DECIMAL(7,2), rc TINYINT, rrc TINYTEXT, tid BIGINT, r TEXT)
BEGIN
	INSERT INTO transactions VALUES (NULL, oid, trans_type, amt, rc, rrc, tid, r, NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE clear_cart (uid CHAR(32))
BEGIN
	DELETE FROM carts WHERE user_session_id=uid;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE get_order_contents (oid INT)
BEGIN
SELECT oc.quantity, oc.price_per, (oc.quantity*oc.price_per) AS subtotal, ncc.category, ncp.name, o.total, o.shipping FROM order_contents AS oc INNER JOIN non_coffee_products AS ncp ON oc.product_id=ncp.id INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id INNER JOIN orders AS o ON oc.order_id=o.id WHERE oc.product_type="other" AND oc.order_id=oid UNION SELECT oc.quantity, oc.price_per, (oc.quantity*oc.price_per), gc.category, CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole), o.total, o.shipping FROM order_contents AS oc INNER JOIN specific_coffees AS sc ON oc.product_id=sc.id INNER JOIN sizes AS s ON s.id=sc.size_id INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id INNER JOIN orders AS o ON oc.order_id=o.id  WHERE oc.product_type="coffee" AND oc.order_id=oid;
END$$
DELIMITER ;
