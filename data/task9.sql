insert into "order" values (7, 1, to_date('26-12-2021','dd-mm-yyyy'));

insert into "order_product" values (7, 1, 2);
insert into "order_product" values (7, 4, 2);

insert into "shipment" values (7, 7, 2);

-- -------------------------------------------------------------------------

create or replace function convert_to_RON(crt_price in number, currency "provider".products_currency%type)
return float
is
  EUR float := 4.95;
  USD float := 4.37;
begin
  
  if currency = 'EUR' then
    return crt_price * EUR;
  elsif currency = 'USD' then
    return crt_price * USD;
  else
    return crt_price;
  end if;
end;
/

create or replace procedure get_most_expensive_order_of_courier (
  courier_id in "courier".id%type,
  total_price out number
)
is
  crt_courier "courier"%rowtype;

  begin
    select *
    into crt_courier
    from "courier" c
    where c.id = courier_id;

    with
      -- Getting the results as:
      -- courier_id | shipment_id | total_price_from_that_shipment
      courier_products_situation as (
        select 
          c.id "c_id",
          s.id "s_id",
          sum(
            op.quantity * convert_to_RON(p.price, (select products_currency from "provider" prov where prov.id = p.provider_id))
          ) "total_price"
        from "courier" c
        join "shipment" s
          on c.id = s.courier_id 
        join "order_product" op
          on op.order_id = s.order_id
        join "product" p
          on p.id = op.product_id 
        group by (c.id, s.id)
      ),

      -- From the above CTE we're only taking what's relevant.
      crt_courier_situation as (
        select *
        from courier_products_situation
        where "c_id" = courier_id
      )
    select "total_price"
    into total_price
    from crt_courier_situation
    where crt_courier_situation."total_price" = (
      select max("total_price")
      from crt_courier_situation
    );

    exception
      when NO_DATA_FOUND then
        dbms_output.put_line('There is no courier with the ID ' || courier_id);
        total_price := -1;
      when TOO_MANY_ROWS then
        dbms_output.put_line('The courier with the ID ' || courier_id || ' has multiple orders which have the same maximum price.');
        total_price := -1;
end;
/

-- Usage
declare
	total_price number;
begin
	get_most_expensive_order_of_courier(1, total_price);
	dbms_output.put_line('TOTAL PRICE: ' || total_price);
end;
/
