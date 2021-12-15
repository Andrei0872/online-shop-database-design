# Online shop database design

* mention how to inspect errors: `show errors`

## Tasks

## 1

> Prezentați pe scurt baza de date (utilitatea ei).

Prezenta baza de date modeleaza un magazin online. In ziua de azi exista numeroase servicii pe Internet ce-si pot dovedi utilitatea doar prin cateva click-uri. Datorita lor, si nu numai, viata oamenilor a devenit mult mai simpla deoarece ei isi pot aloca mai mult timp activitatilor prioritare. Asadar, acest proiect urmareste crearea unei arhitecturi care sta la baza unui astfel de serviciu.

## 2

> Realizați diagrama entitate-relație (ERD).

<div style="text-align: center;">
  <img src="./images/erd-shop.jpg">
</div>

## 3

> Pornind de la diagrama entitate-relație realizați diagrama conceptuală a modelului propus, integrând toate atributele necesare.

<div style="text-align: center;">
  <img src="./images/conceptual-diagram-shop.jpg">
</div>

## 4

> Implementați în Oracle diagrama conceptuală realizată: definiți toate tabelele, implementând toate constrângerile de integritate necesare (chei primare, cheile externe etc).

```sql
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
```

## 5

> Adăugați informații coerente în tabelele create (minim 5 înregistrări pentru fiecare entitate independentă; minim 10 înregistrări pentru tabela asociativă).

```sql
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
```

## 6

> Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat care săutilizeze două tipuri de colecție studiate. Apelați subprogramul.

Dat fiind printr-un parametru ID-ul unui produs, determinati numarul de curieri care au livrat comenzi care contin acel produs.

```sql
create or replace function get_nr_couriers_for_product (product_id in number)
  return number
is
  nr_couriers number := 0;
  
  -- Nested table.
  type t_couriers is table of "courier"%rowtype;
  v_couriers t_couriers;
  
  -- Associative array.
  type t_products is table of number
  index by binary_integer;
  v_products_of_courier t_products;
  begin
    select *
    bulk collect into v_couriers
    from "courier";

    if v_couriers.count = 0 then
      return 0;
    end if;

    for i in v_couriers.first..v_couriers.last loop
      select op.product_id
      bulk collect into v_products_of_courier
      from "courier" c
      join "shipment" s
        on s.courier_id = c.id 
      join "order_product" op
        on op.order_id = s.order_id
      where c.id = v_couriers(i).id;

      for prod_idx in v_products_of_courier.first..v_products_of_courier.last loop
        if product_id = v_products_of_courier(prod_idx) then
          nr_couriers := nr_couriers + 1;
          exit;
        end if;
      end loop;
    end loop;

    return nr_couriers;
  end;
/
```

Rezultat:

```sql
SQL> select get_nr_couriers_for_product(1) from dual;

GET_NR_COURIERS_FOR_PRODUCT(1)
------------------------------
			     3

SQL> select get_nr_couriers_for_product(4) from dual;

GET_NR_COURIERS_FOR_PRODUCT(4)
------------------------------
			     2
```

<div style="text-align: center;">
  <img src="./images/tasks/task6-sol.png">
</div>

## 7

> Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat care să utilizeze un tip de cursor studiat. Apelați subprogramul.