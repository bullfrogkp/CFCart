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