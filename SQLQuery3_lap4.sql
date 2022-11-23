------ B1 ------------

declare @tbThongKe table(MaPB int, LuongTB float)

insert into @tbThongKe
	select PHG, AVG(Luong) from NHANVIEN group by PHG

select * from @tbThongKe

select TENNV,PHG, LUONG, LuongTB, 
TinhTrang = case
when LUONG > LuongTB then 'Khong Tang Luong'
else 'Tang Luong'
end
	from NHANVIEN a 
inner join @tbThongKe b
on a.PHG = b.MaPB

--------------------------------------------------------

declare @tbThongKe table(MaPB int, LuongTB float)

insert into @tbThongKe
	select PHG, AVG(Luong) from NHANVIEN group by PHG

select * from @tbThongKe

select TENNV,PHG, LUONG, LuongTB, 
TinhTrang = case
when LUONG > LuongTB then 'Truong Phong'
else 'Nhan VIen'
end
	from NHANVIEN a 
inner join @tbThongKe b
on a.PHG = b.MaPB

----------------------------------------------

select TENNV = case 
when PHAI = 'Nam' then 'Mr. ' + TENNV
when PHAI = N'Nữ' then 'Ms. ' + TENNV
else 'khong biet' 
end
	from NHANVIEN


--------------------------------------------------------

select TENNV, LUONG,
Thue = case 
	when LUONG between 0 and 25000 then LUONG * 0.1
	when LUONG between 25000 and 30000 then LUONG * 0.12
	when LUONG between 30000 and 40000 then LUONG * 0.15
	when LUONG between 40000 and 50000 then LUONG * 0.2
	else LUONG * 0.25
	end
from NHANVIEN

--------------- B2 --------------

select * from NHANVIEN
declare @i int = 2, @dem int ;
set @dem = (select COUNT(*) from NHANVIEN)
while (@i < @dem)
begin 
	if (@i = 4)
		begin
			set @i = @i + 2;
			continue;
		end
	select MANV, HONV, TENLOT, TENNV from NHANVIEN
	where CAST(MANV as int) = @i ;
	set @i = @i + 2;
end

--------- B3 ----------

begin try 
	insert PHONGBAN (TENPHG, MAPHG, TRPHG, NG_NHANCHUC)
	values('Ke Hoach', 111 , '019', '2022-11-23')
	print 'Them du lieu thanh cong'
end try 
begin catch
	print 'Loi' + convert(varchar, Error_number(), 1) 
	+ '=>' + Error_message()  
end catch

-------------------------------

begin try 
	declare @a int = 4 , @b int = 0, @chia int ;
	set @chia = @a / @b;
end try
begin catch 
	declare @ErMessage nvarchar (2048),
			@ErSeverity int,
			@ErState int
	select @ErMessage = ERROR_MESSAGE(),
			@ErSeverity = ERROR_SEVERITY(),
			@ErState = ERROR_STATE()
	raiserror (@ErMessage, @ErSeverity, @ErState)
end catch

------------- B4 ---------
DECLARE @TONG1 INT = 0,@D INT = 10,@F INT
SET @F = 1
WHILE (@F<=@D)
BEGIN
if (@F %2 =0)
SET @TONG1 = @TONG1 + @F
SET @F = @F + 1 
if(@F = 4)
SET @TONG1 = @TONG1 - 4
END
PRINT ('KET QUA: ' )
PRINT @TONG1
