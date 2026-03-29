-- Dữ liệu 
create database ql_order_detail

create table inventory (
    product_id serial primary key,
    product_name varchar(100),
    quantity int
);

insert into inventory (product_name, quantity)
values
('iphone 13', 10),
('airpods pro', 25),
('samsung galaxy s22', 15),
('samsung charger', 50),
('laptop dell xps 13', 5),
('wireless mouse', 30),
('macbook air m2', 8),
('usb-c hub', 20),
('ipad pro', 12),
('apple pencil', 18);


create or replace procedure check_stock(
	p_id int,
	p_quatity int
)
language plpgsql
as $$
	begin
		if exists ( select * from inventory where product_id =p_id and quantity<p_quatity) then
			raise exception 'Không đủ hàng trong kho';
		else
			raise notice ' Đủ hàng trong kho';
		end if ;
	end;
$$;

-- Gọi Procedure với các trường hợp:
	-- Một sản phẩm có đủ hàng
	call check_stock(1,5);
	
	-- Một sản phẩm không đủ hàng
	call check_stock(1,30);

