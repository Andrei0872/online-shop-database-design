-- Main entities

drop table "user" cascade constraints;
drop table "admin" cascade constraints;
drop table "provider" cascade constraints;
drop table "product" cascade constraints;
drop table "order" cascade constraints;
drop table "courier" cascade constraints;
drop table "offer" cascade constraints;

-- Associative tables

drop table "order_product" cascade constraints;
drop table "shipment" cascade constraints;
drop table "offer_product" cascade constraints;