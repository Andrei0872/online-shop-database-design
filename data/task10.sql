/*
insert into "order" values (X, 1, to_date('28-12-2021','dd-mm-yyyy'));

select *
from "shipment";
*/

create or replace trigger create_shipment_after_order
  after insert on "order"
declare
  last_created_order_id number;
  last_shipment_id number;
  random_courier_idx number;

  type t_couriers is table of number
  index by binary_integer;
  v_couriers t_couriers;
begin

  select max(id)
  into last_created_order_id
  from "order";

  select max(id)
  into last_shipment_id
  from "shipment";

  select id
  bulk collect into v_couriers
  from "courier";

  random_courier_idx := trunc(dbms_random.value(0, v_couriers.count));

  insert into
  "shipment"
  values (last_shipment_id + 1, last_created_order_id, v_couriers(random_courier_idx));

end;
/