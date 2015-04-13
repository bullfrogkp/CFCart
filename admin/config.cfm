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
(code,display_name)
VALUES
('US','USA');

INSERT INTO country
(code,display_name)
VALUES
('CA','Canada');

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

//province
INSERT INTO province
(code,display_name)
VALUES
('AB','Alberta');

INSERT INTO province
(code,display_name)
VALUES
('BC','British Columbia');

INSERT INTO province
(code,display_name)
VALUES
('MB','Manitoba');

INSERT INTO province
(code,display_name)
VALUES
('NB','New Brunswick');

INSERT INTO province
(code,display_name)
VALUES
('NL','Newfoundland and Labrador');

INSERT INTO province
(code,display_name)
VALUES
('NT','Northwest Territories');

INSERT INTO province
(code,display_name)
VALUES
('NS','Nova Scotia');

INSERT INTO province
(code,display_name)
VALUES
('NU','Nunavut');

INSERT INTO province
(code,display_name)
VALUES
('ON','Ontario');

INSERT INTO province
(code,display_name)
VALUES
('PE','Prince Edward Island');

INSERT INTO province
(code,display_name)
VALUES
('QC','Quebec');

INSERT INTO province
(code,display_name)
VALUES
('SK','Saskatchewan');

INSERT INTO province
(code,display_name)
VALUES
('YT','Yukon Territory');

INSERT into province values ('AL', 'Alabama'),
('AK', 'Alaska'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');
