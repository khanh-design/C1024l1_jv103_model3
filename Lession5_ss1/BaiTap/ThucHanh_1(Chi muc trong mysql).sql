use `classicmodels`;

select * from Customers;

ALTER TABLE customers ADD INDEX idx_customerName(customerName);
explain select * from customers where customerName = 'Land Of Toys Inc.';

EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' or contactFirstName = 'King';
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);
alter table customers drop index idx_full_name;
