-- Dữ liệu 
create database ql_order_detail

create table employees (
    emp_id serial primary key,
    emp_name varchar(100),
    job_level int,
    salary numeric
);
insert into employees (emp_name, job_level, salary)
values
('nguyen van a', 1, 8000000),
('tran thi b', 2, 12000000),
('le van c', 3, 18000000),
('pham thi d', 2, 13000000),
('hoang van e', 4, 25000000),
('do thi f', 1, 7500000),
('vo van g', 3, 20000000),
('bui thi h', 2, 14000000),
('dang van i', 5, 30000000),
('ngo thi k', 4, 27000000);

-- Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:
	-- + Nhận emp_id của nhâen viên
	-- + Cập nhật lương theo quy tắc trên
	-- + Trả về p_new_salary (lương mới) sau khi cập nhật

create or replace procedure adjust_salary(
    p_emp_id int,
    out p_new_salary numeric
)
language plpgsql
as $$
begin
    update employees
    set salary = case
        when job_level = 1 then salary * 1.05
        when job_level = 2 then salary * 1.1
        when job_level = 3 then salary * 1.15
        else salary
    end
    where emp_id = p_emp_id;

    -- lấy lương mới
    select salary into p_new_salary
    from employees
    where emp_id = p_emp_id;
end;
$$;

do $$
declare
new_salary numeric;
	begin
		call adjust_salary(1,new_salary);
		raise notice 'Lương mới của nhân viên 1 là: %',new_salary;
	end;
$$







	
-- Thực thi thử: