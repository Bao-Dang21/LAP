
create trigger trg_insertNhanVien on NhanVien
for insert
as
	if(select luong from inserted) < 15000
		begin
			print 'Luong Phai lon hon 15000'
			rollback transaction
		end
select * from NHANVIEN
insert into NHANVIEN
values('TRan','Thanh','Huy','021','2020-12-12','Da Nang','Nam',16000,'004',1)

-------------------------------------
create trigger trg_insertNhanVien2 on NhanVien
for insert
as
	declare @age int
	set @age = YEAR(GETDATE()) - (select YEAR (NgSinh) from inserted)
	if (@age < 18 or @age > 65)
		begin
			print 'Tuoi khong hop le'
			rollback transaction
		end
insert into NHANVIEN
values('TRan','Thanh','Huy','022','1980-12-12','Da Nang','Nam',16000,'004',1)

------------------------------------
create trigger trg_insertNhanVien3 on NhanVien
for update
as 
	if(select dchi from inserted) like '%HCM%'
		begin
			print 'Dia Chi Khong Hop Le' 
			rollback transaction
		end
select * from NHANVIEN
update NHANVIEN set TENNV = 'NamNV' where MANV ='006'

-----------------Bai 2 ----
create trigger trg_TongNV
   on NHANVIEN
   AFTER INSERT
AS
   Declare @male int, @female int;
   select @female = count(Manv) from NHANVIEN where PHAI = N'Nu';
   select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
   print N'Tổng số nhân viên là nu: ' + cast(@female as varchar);
   print N'Tổng số nhân viên là nam: ' + cast(@male as varchar);

---CÂU Lệnh Kiểm Tra
INSERT INTO [dbo].[NHANVIEN]([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQL],[PHG])
     VALUES ('A','B','C','345','7-12-1999','HCM','Nam',600000,'005',1)
GO

----------------- 2B ------
create trigger trg_TongNVSauUpdate
   on NHANVIEN
   AFTER update
AS
   if (select top 1 PHAI FROM deleted) != (select top 1 PHAI FROM inserted)
   begin
      Declare @male int, @female int;
      select @female = count(Manv) from NHANVIEN where PHAI = N'Nu';
      select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
      print 'Tong Nhan Vien La Nu: ' + cast(@female as varchar);
      print 'Tong NHan Vien la nam: ' + cast(@male as varchar);
   end;
UPDATE [dbo].[NHANVIEN]
   SET [HONV] = 'Tín'
      ,[PHAI] = N'Nu'
 WHERE  MaNV = '345'
GO

-------------------------------
create trigger trg_CountDeAn2c on DeAn
after delete
as
	begin
		select MA_NVIEN, COUNT (MADA) as 'so luong' from PHANCONG
		group by MA_NVIEN
	end
select * from DEAN
delete DEAN where MADA = 22

-----------------Bai3 --------------------
create trigger trg_deleteNhanThanNV on NhanVien
instead of delete
as
begin
	delete from THANNHAN where MA_NVIEN in (select MANV from deleted)
	delete from NHANVIEN where MANV in (select MANV from deleted)
end
delete NHANVIEN where MANV ='345'
select * from NHANVIEN

-----------------------------------

create trigger trg_insertNV3b on NhanVien
after insert 
as begin
	insert into PHANCONG values((select MaNV from inserted),1,1,100)
end

insert into NHANVIEN
values('TRan','Thanh','Huy','055','1980-12-12','Da Nang','Nam',16000,'006',1)
