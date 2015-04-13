//tax category
INSERT INTO tax_category
(name,display_name)
VALUES
('taxable','Taxable');

INSERT INTO tax_category
(name,display_name,rate)
VALUES
('zero-rated','Zero-rated',0);

INSERT INTO tax_category
(name,display_name,rate)
VALUES
('exempt','Exempt',0);

//calculation type
INSERT INTO calculation_type
(name,display_name)
VALUES
('percentage','Percentage');

INSERT INTO calculation_type
(name,display_name)
VALUES
('fixed','Fixed');

//attribute
INSERT INTO attribute
(name,display_name)
VALUES
('color','Color');

INSERT INTO attribute
(name,display_name)
VALUES
('size','Size');

INSERT INTO attribute
(name,display_name)
VALUES
('brand','Brand');

INSERT INTO attribute
(name,display_name)
VALUES
('material','Material');

//filter
INSERT INTO filter
(name,display_name)
VALUES
('color','Color');

INSERT INTO filter
(name,display_name)
VALUES
('size','Size');

INSERT INTO filter
(name,display_name)
VALUES
('brand','Brand');

INSERT INTO filter
(name,display_name)
VALUES
('material','Material');

//country
INSERT INTO country
(code,name,display_name)
VALUES
('US','usa','USA');

INSERT INTO country
(code,name,display_name)
VALUES
('CA','canada','Canada');

//coupon status type
INSERT INTO coupon_status_type
(name,display_name)
VALUES
('active','Active');

INSERT INTO coupon_status_type
(name,display_name)
VALUES
('expired','Expired');

INSERT INTO coupon_status_type
(name,display_name)
VALUES
('used','Used');

INSERT INTO coupon_status_type
(name,display_name)
VALUES
('disabled','Disabled');

//order_product_status_type
//http://www.amazon.com/gp/help/customer/display.html?nodeId=200243170
INSERT INTO order_product_status_type
(name,display_name)
VALUES
('working','Working');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('ready_to_ship','Ready to Ship');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('shipped','Shipped');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('in_transit','In-Transit');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('delivered','Delivered');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('checked_in','Checked-In');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('directed_to_prep','Directed to Prep');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('receiving','Receiving');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('closed','Closed');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('canceled','Cancelled');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('deleted','Deleted');

INSERT INTO order_product_status_type
(name,display_name)
VALUES
('receiving_with_problems','Receiving with Problems');

//order_status_type
//http://www.amazon.com/gp/help/customer/display.html?nodeId=200243170
INSERT INTO order_status_type
(name,display_name)
VALUES
('working','Working');

INSERT INTO order_status_type
(name,display_name)
VALUES
('ready_to_ship','Ready to Ship');

INSERT INTO order_status_type
(name,display_name)
VALUES
('shipped','Shipped');

INSERT INTO order_status_type
(name,display_name)
VALUES
('in_transit','In-Transit');

INSERT INTO order_status_type
(name,display_name)
VALUES
('delivered','Delivered');

INSERT INTO order_status_type
(name,display_name)
VALUES
('checked_in','Checked-In');

INSERT INTO order_status_type
(name,display_name)
VALUES
('directed_to_prep','Directed to Prep');

INSERT INTO order_status_type
(name,display_name)
VALUES
('receiving','Receiving');

INSERT INTO order_status_type
(name,display_name)
VALUES
('closed','Closed');

INSERT INTO order_status_type
(name,display_name)
VALUES
('canceled','Cancelled');

INSERT INTO order_status_type
(name,display_name)
VALUES
('deleted','Deleted');

INSERT INTO order_status_type
(name,display_name)
VALUES
('receiving_with_problems','Receiving with Problems');

//payment_solution
INSERT INTO payment_solution
(name,display_name)
VALUES
('paypal','PayPal');

INSERT INTO payment_solution
(name,display_name)
VALUES
('google_checkout','Google Checkout');

INSERT INTO payment_solution
(name,display_name)
VALUES
('amazon_payments','Amazon Payments');

//payment_method
INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('regular','Regular',(SELECT payment_solution_id FROM payment_solution WHERE name = 'paypal'));

INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('express','Express',(SELECT payment_solution_id FROM payment_solution WHERE name = 'paypal'));

INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('regular','Regular',(SELECT payment_solution_id FROM payment_solution WHERE name = 'google_checkout'));

INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('express','Express',(SELECT payment_solution_id FROM payment_solution WHERE name = 'google_checkout'));

INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('regular','Regular',(SELECT payment_solution_id FROM payment_solution WHERE name = 'amazon_payments'));

INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('express','Express',(SELECT payment_solution_id FROM payment_solution WHERE name = 'amazon_payments'));