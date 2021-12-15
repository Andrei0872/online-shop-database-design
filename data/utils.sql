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