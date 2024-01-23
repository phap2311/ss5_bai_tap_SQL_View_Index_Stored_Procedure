drop database if exists demo55;
create database if not exists demo55;
use demo55;
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_code VARCHAR(30) NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    product_price INT NOT NULL,
    product_amount INT NOT NULL,
    product_description TEXT NOT NULL,
    product_status VARCHAR(20) NOT NULL
);
insert into products(id, product_code, product_name, product_price, product_amount, product_description, product_status)
values
(1,'p001', 'product A', 1500, 50, 'description for product A', 'active'),
(2,'p002', 'product B', 10000, 50, 'description for product B', 'inactive'),
(3,'p003', 'product C', 7000, 50, 'description for product C', 'active'),
(4,'p004', 'product D', 5500, 50, 'description for product D', 'active');

create unique index products_pcode
on products (product_code);

create index inx_products_name_price 
on products (product_name, product_price);

explain select * from products
where product_name = 'product C' and product_price = 7000;

CREATE VIEW products_infor_view AS
    SELECT 
        product_code, product_name, product_price, product_status
    FROM
        products;

SELECT 
    *
FROM
    products_infor_view;
-- sửa view
CREATE OR REPLACE VIEW products_infor_view AS
    SELECT 
        product_code, product_name, product_price, product_status
    FROM
        products
    WHERE
        product_status = 'active';
select * from products_infor_view;
-- xóa view
drop view if exists products_info_view;

delimiter //
create procedure get_all_products()
begin
select * from products;
end //
delimiter ;
call get_all_products();
-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure add_products(
in p_product_code varchar(30),
    in p_product_name varchar(50),
    in p_product_price int,
    in p_product_amount int,
    in p_product_description text,
    in p_product_status varchar(20)
)
begin 
insert into products(
	product_code, 
	product_name, 
	product_price, 
	product_amount, 
	product_description, 
	product_status
)
values (
	p_product_code,
	p_product_name ,
	p_product_price ,
	p_product_amount ,
	p_product_description ,
	p_product_status
    );
end //
delimiter ;

call add_products('p005', 'product E', 8500, 70, 'description for product E', 'inactive');
-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure update_products_by_id(
	in p_product_id int,
	in p_product_code varchar(30),
    in p_product_name varchar(50),
    in p_product_price int,
    in p_product_amount int,
    in p_product_description text,
    in p_product_status varchar(20)
)
begin 
update products
set
	product_code = p_product_code, 
	product_name = p_product_name , 
	product_price = p_product_price , 
	product_amount = p_product_amount , 
	product_description = p_product_description , 
	product_status = p_product_status
    where id = p_product_id;
    end //
    delimiter ;
   call update_products_by_id(1,'p001','update product',2000,30,'description for product update','inactive'); 
delimiter //
-- Tạo store procedure xoá sản phẩm theo id
create procedure remove_product_by_id(
in p_product_id int
)
begin
delete from products 
where id = p_product_id;
end //
delimiter ;
call remove_product_by_id(2);