create view V_customer as
select customerNumber, customerName, phone
from customers;

select * from V_customer;

CREATE OR REPLACE VIEW V_customer AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

DROP VIEW V_customer;
