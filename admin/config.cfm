/*attribute*/
INSERT INTO attribute
(name,display_name)
VALUES
('color','Color'),
('size','Size');

/*calculation type*/
INSERT INTO calculation_type
(name,display_name)
VALUES
('percentage','Percentage'),
('fixed','Fixed');

/*country*/
INSERT INTO country
(code,display_name)
VALUES
('US','USA'),
('CA','Canada');

/*currency*/
INSERT INTO currency
(name,display_name)
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

/*customer_group*/
INSERT INTO customer_group
(name,display_name,is_default)
VALUES
('default','Default',1),
('wholesaler','Wholesaler',0),
('retailer','Retailer',0);

/*filter*/
INSERT INTO filter
(name,display_name)
VALUES
('color','Color'),
('size','Size');

/*link_status_type*/
INSERT INTO link_status_type
(name,display_name)
VALUES
('active','Active'),
('processed','Processed');

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

/*order_transaction_type*/
INSERT INTO order_transaction_type
(name,display_name)
VALUES
('purchase','Purchase');

/*page_section*/
INSERT INTO page_section
(name,content,page_id)
VALUES
('slide','',1),
('advertisement','',1),
('top selling','',1),
('group buying','',1),
('advertisement','',2),
('best seller','',2);

/*product_type*/
INSERT INTO product_type
(name,display_name)
VALUES
('simple','Simple'),
('package','Package'),
('configured_product','Configured Product');

/*payment_method*/
INSERT INTO payment_method
(name,display_name)
VALUES
('paypal','PayPal');

/*review_status_type*/
INSERT INTO review_status_type
(name,display_name)
VALUES
('approved','Approved'),
('rejected','Rejected'),
('pending','Pending');

/*shipping_carrier*/
INSERT INTO shipping_carrier
(name,display_name, image_name, component, is_enabled)
VALUES
('ups','UPS','ups','ups',1),
('fedex','Fedex','fedex','fedex',0),
('chinapost','China Post','chinapost','chinapost',1),
('dhl','DHL','dhl','dhl',0),
('ems','EMS','ems','ems',0),
('canadapost','Canada Post','canadapost','canadapost',1);

/*shipping_method*/
INSERT INTO shipping_method
(name,display_name,shipping_carrier_id)
VALUES
('ups regular','UPS - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups')),
('ups express','UPS - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups')),
('fedex regular','Fedex - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'fedex')),
('fedex express','Fedex - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'fedex')),
('chinapost regular','Chinapost - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'chinapost')),
('chinapost express','Chinapost - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'chinapost')),
('dhl regular','DHL - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'dhl')),
('dhl express','DHL - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'dhl')),
('ems regular','EMS - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ems')),
('ems express','EMS - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ems')),
('canadapost regular','Canadapost - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost')),
('canadapost express','Canadapost - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'));

/*tax category*/
INSERT INTO tax_category
(name,display_name)
VALUES
('taxable','Taxable'),
('zero-rated','Zero-rated'),
('exempt','Exempt');

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

/*tracking_record_type*/
INSERT INTO tax_category
(name)
VALUES
('shopping cart'),
('buy later'),
('history'),
('wishlist');

/*add top selling and group buying category*/
INSERT INTO category
(name,display_name,is_enabled,rank,show_category_on_navigation,display_category_list,display_custom_design,display_filter,is_special)
VALUES
('new arrivals','New Arrivals',),
('group buying','Group Buying'),
('search result','Search Result'),
('top sellers','Top Sellers');