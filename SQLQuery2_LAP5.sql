create proc lab5_Bai1_a @name nvarchar(20)
as 
	begin
		print 'Xin chào : '+ @name
	end

exec lab5_Bai1_a N'Gia Bảo'
---------------------------------
create proc lab5_Bai1_b @numberA int, @numberB int
as
	begin
		declare @sum int = 0;
		set @sum = @numberA + @numberB
		print 'Tong: ' + cast(@sum as varchar(10))
	end
exec lab5_Bai1_b 5,4

--------------------------------------------
create proc lab5_Bai1_c @n int
as 
	begin
		declare @sum int = 0, @i int = 0;
		while @i < @n
			begin
				set @sum = @sum + @i
				set @i = @i + 2
			end
		print 'sum even: ' + cast(@sum as varchar(10))
	end	
exec lab5_Bai1_c 10
--------------------------------

create proc lab5_Bai1_d @a int , @b int
as 
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a = @a - @b
				else 
					set @b = @b - @a
			end
			return @a
	end 
declare @c int
exec @c = lab5_Bai1_d 30 ,40
print @c

-------------------------Bai 2 ------------------------------

create proc bai2_1 @MaNV varchar(3)
as
begin
	select * from NHANVIEN where MANV = @MaNV	
end
exec bai2_1 '001'
-----
create proc bai2_2 @manv int
as 
begin
	select COUNT(MaNV) as 'so luong',MADA, TENPHG from NHANVIEN
	inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
	inner join DEAN on DEAN.PHONG= PHONGBAN.MAPHG
	where MADA = @manv
	group by TENPHG, MADA
end
exec bai2_2 1 
----------------------------------
create proc bai2_3 @manv int , @DD varchar (10)
as 
begin
	select COUNT(MaNV) as 'so luong',MADA, TENPHG from NHANVIEN
	inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
	inner join DEAN on DEAN.PHONG= PHONGBAN.MAPHG
	where MADA = @manv and DDIEM_DA = @DD
	group by TENPHG, MADA
end
exec bai2_3 1 ,'Nha Trang'

-----------------------------------------
create proc bai2_4 @MaTP varchar(5)
as
begin
	select HONV, TENNV, TENPHG, NHANVIEN.MANV, THANNHAN.* from NHANVIEN
	inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
	left outer join THANNHAN on THANNHAN.MA_NVIEN = NHANVIEN.MANV
	where THANNHAN.MA_NVIEN is null and TRPHG = @MaTP
end

exec bai2_4 '007'
---------------------------------
create proc bai2_5 @MaNV varchar(5), @MaPB varchar(5)
as
begin
if exists (select * from NHANVIEN where MANV = @MaNV and PHG= @MaPB)
	print 'Nhan vien: ' +@MaNV +' co trong phong ban:' + @MaPB
else 
		print 'Nhan vien: ' +@MaNV +' khong co trong phong ban:' + @MaPB
end
exec bai2_5 '001', '5'