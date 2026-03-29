
---------- HƯỚNG DẪN LÀM BÀI 1 
-- SINH RA CÂU LỆNH SQL 
create database ql_order_detail

CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

insert into order_detail (order_id, product_name, quantity, unit_price)
values
(1, 'iphone 13', 2, 20000000),
(1, 'airpods pro', 1, 5000000),

(2, 'samsung galaxy s22', 1, 18000000),
(2, 'samsung charger', 2, 300000),

(3, 'laptop dell xps 13', 1, 35000000),
(3, 'wireless mouse', 1, 500000),

(4, 'macbook air m2', 1, 28000000),
(4, 'usb-c hub', 1, 700000),

(5, 'ipad pro', 1, 25000000),
(5, 'apple pencil', 1, 3000000);

create or replace procedure calculate_order_total(
		order_id_input INT,
		OUT total NUMERIC)
language plpgsql 
as $$
	begin
		select sum(quantity*unit_price)
		into total
		from order_detail
		where order_id = order_id_input;
	end;
$$;

do $$
declare
total NUMERIC;
	begin
		call calculate_order_total(1,total);
		raise notice 'ĐƠN HÀNG % CÓ GIÁ TRỊ LÀ: %',1,total;
	end;
$$;



























