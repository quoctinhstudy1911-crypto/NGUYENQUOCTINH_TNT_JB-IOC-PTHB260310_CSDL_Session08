-- dữ liệu
create database ql_order_detail;

create table products (
    id serial primary key,
    name varchar(100),
    price numeric,
    discount_percent int
);

insert into products (name, price, discount_percent)
values
('iphone 13', 20000000, 10),
('airpods pro', 5000000, 5),
('samsung galaxy s22', 18000000, 15),
('laptop dell xps 13', 35000000, 20),
('macbook air m2', 28000000, 10),
('ipad pro', 25000000, 12),
('apple pencil', 3000000, 5),
('wireless mouse', 500000, 8),
('usb-c hub', 700000, 10),
('samsung charger', 300000, 3);
select * from products

/*
Viết Procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC) để:
Lấy price và discount_percent của sản phẩm
Tính giá sau giảm:
 p_final_price = price - (price * discount_percent / 100)
Nếu phần trăm giảm giá > 50, thì giới hạn chỉ còn 50%
Cập nhật lại cột price trong bảng products thành giá sau giảm
*/
create or replace procedure calculate_discount(
    p_id int,
    out p_final_price numeric
)
language plpgsql
as $$
declare
    price_before numeric;
    discount int;
begin
    select price, discount_percent
    into price_before, discount
    from products
    where id = p_id;

    if price_before is null then
        raise notice 'Sản phẩm không tồn tại';
        p_final_price := null;
        return;
    end if;

    if discount > 50 then
        discount := 50;
    end if;

    p_final_price := price_before - (price_before * discount / 100.0);

    update products
    set price = p_final_price
    where id = p_id;

end;
$$;

-- Gọi thử: 
do $$
declare 
	p_final_price numeric;
	begin
	call calculate_discount(3,p_final_price);
	raise notice 'Giá sau khi giảm là: %',p_final_price;
	end;
$$
	




