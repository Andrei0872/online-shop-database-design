-- Main entities

insert into "user" VALUES (1, 'username_1', 'foo_1@bar', 'password_1', to_date( '15-12-2021','dd-mm-yyyy'));
insert into "user" VALUES (2, 'username_2', 'foo_2@bar', 'password_2', to_date( '15-12-2021','dd-mm-yyyy'));
insert into "user" VALUES (3, 'username_3', 'foo_3@bar', 'password_3', to_date( '15-12-2021','dd-mm-yyyy'));
insert into "user" VALUES (4, 'username_4', 'foo_4@bar', 'password_4', to_date( '16-12-2021','dd-mm-yyyy'));
insert into "user" VALUES (5, 'username_5', 'foo_5@bar', 'password_5', to_date( '17-12-2021','dd-mm-yyyy'));

insert into "admin" values (1);

insert into "provider" values (1, 'provider_1', 'RON');
insert into "provider" values (2, 'provider_2', 'RON');
insert into "provider" values (3, 'provider_3', 'EUR');
insert into "provider" values (4, 'provider_4', 'EUR');
insert into "provider" values (5, 'provider_5', 'USD');

insert into "product" values (1, 1, 'product_1', 10, to_date('17-12-2021','dd-mm-yyyy'));
insert into "product" values (2, 1, 'product_2', 10, to_date('17-12-2021','dd-mm-yyyy'));
insert into "product" values (3, 2, 'product_3', 10, to_date('17-12-2021','dd-mm-yyyy'));
insert into "product" values (4, 3, 'product_4', 10, to_date('18-12-2021','dd-mm-yyyy'));
insert into "product" values (5, 3, 'product_5', 10, to_date('18-12-2021','dd-mm-yyyy'));
insert into "product" values (6, 3, 'product_6', 10, to_date('19-12-2021','dd-mm-yyyy'));
insert into "product" values (7, 4, 'product_7', 10, to_date('20-12-2021','dd-mm-yyyy'));
insert into "product" values (8, 4, 'product_8', 10, to_date('20-12-2021','dd-mm-yyyy'));
insert into "product" values (9, 5, 'product_9', 10, to_date('21-12-2021','dd-mm-yyyy'));
insert into "product" values (10, 5, 'product_10', 10, to_date('22-12-2021','dd-mm-yyyy'));

insert into "order" values (1, 1, to_date('24-12-2021','dd-mm-yyyy'));
insert into "order" values (2, 2, to_date('24-12-2021','dd-mm-yyyy'));
insert into "order" values (3, 3, to_date('23-12-2021','dd-mm-yyyy'));
insert into "order" values (4, 4, to_date('23-12-2021','dd-mm-yyyy'));
insert into "order" values (5, 5, to_date('25-12-2021','dd-mm-yyyy'));
insert into "order" values (6, 5, to_date('25-12-2021','dd-mm-yyyy'));

insert into "courier" values (1, 'courier_1');
insert into "courier" values (2, 'courier_2');
insert into "courier" values (3, 'courier_3');
insert into "courier" values (4, 'courier_4');
insert into "courier" values (5, 'courier_5');

insert into "offer" values (1, 'offer_1', 'offer_1_desc');
insert into "offer" values (2, 'offer_2', 'offer_2_desc');
insert into "offer" values (3, 'offer_3', 'offer_3_desc');
insert into "offer" values (4, 'offer_4', 'offer_4_desc');
insert into "offer" values (5, 'offer_5', 'offer_5_desc');

-- Associative tables

insert into "order_product" values (1, 1, 1);
insert into "order_product" values (1, 2, 1);
insert into "order_product" values (1, 3, 3);
insert into "order_product" values (2, 1, 2);
insert into "order_product" values (2, 4, 2);
insert into "order_product" values (3, 4, 1);
insert into "order_product" values (3, 5, 1);
insert into "order_product" values (3, 6, 1);
insert into "order_product" values (4, 7, 1);
insert into "order_product" values (5, 1, 1);
insert into "order_product" values (5, 8, 1);
insert into "order_product" values (5, 9, 1);
insert into "order_product" values (5, 10, 2);
insert into "order_product" values (6, 8, 1);
insert into "order_product" values (6, 9, 1);

insert into "shipment" values (1, 1, 1);
insert into "shipment" values (2, 2, 2);
insert into "shipment" values (3, 3, 3);
insert into "shipment" values (4, 4, 4);
insert into "shipment" values (5, 5, 5);
insert into "shipment" values (6, 6, 1);

insert into "offer_product" values (1, 1);
insert into "offer_product" values (1, 2);
insert into "offer_product" values (2, 3);
insert into "offer_product" values (2, 4);
insert into "offer_product" values (3, 5);
insert into "offer_product" values (3, 6);
insert into "offer_product" values (4, 7);
insert into "offer_product" values (4, 8);
insert into "offer_product" values (5, 9);
insert into "offer_product" values (5, 10);
