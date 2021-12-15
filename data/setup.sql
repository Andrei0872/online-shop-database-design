-- Main entities

create table "user" (
  id number(4) constraint user_pk primary key not null,
  username varchar2(50) not null,
  email varchar2(50) not null,
  password varchar2(50) not null,
  joined_at date
);

create table "admin" (
  user_id number(4) not null,

  constraint fk_admin_user
  foreign key (user_id)
  references "user"(id)
  on delete cascade
);

create table "provider" (
  id number(4) constraint provider_pk primary key not null,
  name varchar2(50) not null,
  products_currency varchar2(10) not null
);

create table "product" (
  id number(4) constraint product_pk primary key not null,
  provider_id number(4) not null,
  name varchar2(50) not null,
  price number(4),
  created_at date,

  constraint fk_product_provider
  foreign key (provider_id)
  references "provider"(id)
  on delete cascade
);

create table "order" (
  id number(4) constraint order_pk primary key not null,
  user_id number(4) not null,
  created_at date,

  constraint fk_order_user
  foreign key (user_id)
  references "user"(id)
);

create table "courier" (
  id number(4) constraint courier_pk primary key not null,
  name varchar2(50) not null
);

create table "offer" (
  id number(4) constraint offer_pk primary key not null,
  name varchar2(50) not null,
  description varchar2(100) not null
);

-- Associative tables

create table "order_product" (
  order_id number(4) not null,
  product_id number(4) not null,
  quantity number(2) not null,

  constraint fk_order_product_order
  foreign key (order_id)
  references "order"(id),

  constraint fk_order_product_product
  foreign key (product_id)
  references "product"(id)
);

create table "shipment" (
  id number(4) constraint shipment_pk primary key not null,
  order_id number(4) not null,
  courier_id number(4) not null,

  constraint fk_shipment_order
  foreign key (order_id)
  references "order"(id),

  constraint fk_shipment_courier
  foreign key (courier_id)
  references "courier"(id)
);

create table "offer_product" (
  offer_id number(4) not null,
  product_id number(4) not null,

  constraint fk_offer_product_offer
  foreign key (offer_id)
  references "offer"(id),

  constraint fk_offer_product_product
  foreign key (product_id)
  references "product"(id)
);
