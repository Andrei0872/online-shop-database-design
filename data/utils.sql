-- Task 6
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

-- Task 7
create or replace function get_order_id_with_max_nr_products
  return number
is
  max_nr_products number := -32000;
  nr_products_of_order number := 0;
  result_order_id number;

  begin

  for o in (
    select id
    from "order"
  )
  loop
    select sum(quantity)
    into nr_products_of_order
    from "order_product" op
    where op.order_id = o.id;

    dbms_output.put_line(nr_products_of_order);
    if nr_products_of_order > max_nr_products then
      max_nr_products := nr_products_of_order;
      result_order_id := o.id;
    end if;

  end loop;

  return result_order_id;
end;
/

-- Task 8
create or replace function check_courier_delivered_product (courier_id in number, product_id in number)
  return number
is
  crt_courier "courier"%rowtype;
  has_found_product number := 0;

  begin
    select *
    into crt_courier
    from "courier" c
    where c.id = courier_id;

    for courier_and_product_info in (
      select c.id "courier_id", op.product_id
      from "courier" c
      join "shipment" s
        on s.courier_id = c.id
      join "order_product" op
        on op.order_id  = s.order_id
    )
    loop
      if courier_and_product_info."courier_id" != courier_id then
        continue;
      end if;

      if courier_and_product_info.product_id = product_id then
        has_found_product := 1;
        exit;
      end if;
    end loop;

    return has_found_product;
    
    exception
      when NO_DATA_FOUND then
        dbms_output.put_line('There is no courier with the ID ' || courier_id);
        return -1;
end;
/