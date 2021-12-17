/*
insert into "order_product" values (8, 1, 1);
insert into "order_product" values (8, 10, 0);
insert into "order_product" values (8, 10, 30);
insert into "order_product" values (8, 10, 8);

select *
from "order_product"
where order_id = 8;
*/

create or replace trigger validate_order_products
  before insert on "order_product"
  for each row
begin
  if :new.quantity <= 0 then
    raise_application_error(
      -20000,
      'The quantity cannot be less than or equal to 0!'
    );
  elsif :new.quantity > 10 then
    raise_application_error(
      -20000,
      'The quantity cannot greater than 10!'
    );
  end if;
end;
/