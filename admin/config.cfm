/*tax category*/
INSERT INTO tax_category
(name,display_name)
VALUES
('taxable','Taxable');

INSERT INTO tax_category
(name,display_name,rate)
VALUES
('zero-rated','Zero-rated',0),
('exempt','Exempt',0);

/*calculation type*/
INSERT INTO calculation_type
(name,display_name)
VALUES
('percentage','Percentage'),
('fixed','Fixed');

/*attribute*/
INSERT INTO attribute
(name,display_name)
VALUES
('color','Color'),
('size','Size'),
('brand','Brand'),
('material','Material');

/*filter*/
INSERT INTO filter
(name,display_name)
VALUES
('color','Color'),
('size','Size'),
('brand','Brand'),
('material','Material');

/*country*/
INSERT INTO country
(code,display_name)
VALUES
('US','USA'),
('CA','Canada');

/*coupon status type*/
INSERT INTO coupon_status_type
(name,display_name)
VALUES
('active','Active'),
('expired','Expired'),
('used','Used'),
('disabled','Disabled');

/*order_product_status_type*/
/*www.amazon.com/gp/help/customer/display.html?nodeId=200243170*/
INSERT INTO order_product_status_type
(name,display_name)
VALUES
('working','Working'),
('ready_to_ship','Ready to Ship'),
('shipped','Shipped'),
('in_transit','In-Transit'),
('delivered','Delivered'),
('checked_in','Checked-In'),
('directed_to_prep','Directed to Prep'),
('receiving','Receiving'),
('closed','Closed'),
('canceled','Cancelled'),
('deleted','Deleted'),
('receiving_with_problems','Receiving with Problems');

/*order_status_type*/
/*www.amazon.com/gp/help/customer/display.html?nodeId=200243170*/
INSERT INTO order_status_type
(name,display_name)
VALUES
('working','Working'),
('ready_to_ship','Ready to Ship'),
('shipped','Shipped'),
('in_transit','In-Transit'),
('delivered','Delivered'),
('checked_in','Checked-In'),
('directed_to_prep','Directed to Prep'),
('receiving','Receiving'),
('closed','Closed'),
('canceled','Cancelled'),
('deleted','Deleted'),
('receiving_with_problems','Receiving with Problems');

/*payment_solution*/
INSERT INTO payment_solution
(name,display_name)
VALUES
('paypal','PayPal'),
('google_checkout','Google Checkout'),
('amazon_payments','Amazon Payments');

/*payment_method*/
INSERT INTO payment_method
(name,display_name,payment_solution_id)
VALUES
('regular','Regular',(SELECT payment_solution_id FROM payment_solution WHERE name = 'paypal')),
('express','Express',(SELECT payment_solution_id FROM payment_solution WHERE name = 'paypal')),
('regular','Regular',(SELECT payment_solution_id FROM payment_solution WHERE name = 'google_checkout')),
('express','Express',(SELECT payment_solution_id FROM payment_solution WHERE name = 'google_checkout')),
('regular','Regular',(SELECT payment_solution_id FROM payment_solution WHERE name = 'amazon_payments')),
('express','Express',(SELECT payment_solution_id FROM payment_solution WHERE name = 'amazon_payments'));

/*province*/
INSERT INTO province
(code,display_name)
VALUES
('AB','Alberta'),
('BC','British Columbia'),
('MB','Manitoba'),
('NB','New Brunswick'),
('NL','Newfoundland and Labrador'),
('NT','Northwest Territories'),
('NS','Nova Scotia'),
('NU','Nunavut'),
('ON','Ontario'),
('PE','Prince Edward Island'),
('QC','Quebec'),
('SK','Saskatchewan'),
('YT','Yukon Territory');

INSERT into province values 
('AL', 'Alabama'),
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

/*review_status_type*/
INSERT INTO review_status_type
(name,display_name)
VALUES
('approved','Approved'),
('rejected','Rejected'),
('pending','Pending');

/*shipping_carrier*/
INSERT INTO shipping_carrier
(name,display_name)
VALUES
('ups','UPS'),
('fedex','Fedex'),
('chinapost','China Post'),
('dhl','DHL'),
('ems','EMS'),
('canadapost','Canada Post');

/*shipping_method*/
INSERT INTO shipping_method
(name,display_name,shipping_carrier_id)
VALUES
('regular','Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups')),
('express','Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups')),
('regular','Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'fedex')),
('express','Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'fedex')),
('regular','Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'chinapost')),
('express','Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'chinapost')),
('regular','Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'dhl')),
('express','Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'dhl')),
('regular','Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ems')),
('express','Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ems')),
('regular','Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost')),
('express','Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'));

/*customer_group*/
INSERT INTO customer_group
(name,display_name,is_default)
VALUES
('default','Default',1),
('wholesaler','Wholesaler',0),
('retailer','Retailer',0);
