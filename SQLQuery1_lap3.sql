﻿-- Bai 1 ---------------
SELECT DEAN.TENDEAN , CAST(SUM(PHANCONG.THOIGIAN) AS decimal(4,2))  AS TONG_THOI_GIAN
	FROM PHANCONG 
	INNER JOIN DEAN ON PHANCONG.MADA =DEAN.MADA
GROUP BY DEAN.TENDEAN
--------------
SELECT DEAN.TENDEAN , CAST(SUM(PHANCONG.THOIGIAN) AS VARCHAR(10) ) AS TONG_THOI_GIAN
	FROM PHANCONG 
	INNER JOIN DEAN ON PHANCONG.MADA =DEAN.MADA
GROUP BY DEAN.TENDEAN
-----------------------
SELECT PHONGBAN.TENPHG , CAST(AVG(NHANVIEN.LUONG) AS decimal(10,2)) AS LUONG_TRUNG_BINH FROM NHANVIEN
	INNER JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
GROUP BY PHONGBAN.TENPHG

---------------
SELECT PHONGBAN.TENPHG , LEFT(CAST(AVG(NHANVIEN.LUONG) AS VARCHAR(20)),3)+
	',' +
	REPLACE(CAST(AVG(NHANVIEN.LUONG) AS VARCHAR(20)),LEFT(CAST(AVG(NHANVIEN.LUONG) 	AS VARCHAR(20)),3),'')
	AS LUONG_TRUNG_BINH 
	FROM NHANVIEN
	INNER JOIN PHONGBAN ON NHANVIEN.PHG=PHONGBAN.MAPHG
GROUP BY PHONGBAN.TENPHG

--- Bai 2 -----------
SELECT DEAN.TENDEAN , CEILING(CONVERT(decimal(4,2),SUM(PHANCONG.THOIGIAN))) AS 	TONG_THOI_GIAN
	FROM PHANCONG 
	INNER JOIN DEAN ON PHANCONG.MADA =DEAN.MADA
GROUP BY DEAN.TENDEAN	
-------------
SELECT DEAN.TENDEAN ,FLOOR( CONVERT(decimal(4,2),SUM(PHANCONG.THOIGIAN))) AS 	TONG_THOI_GIAN
	FROM PHANCONG 
	INNER JOIN DEAN ON PHANCONG.MADA =DEAN.MADA
GROUP BY DEAN.TENDEAN
----------------
SELECT DEAN.TENDEAN , ROUND(CONVERT(decimal(4,2),SUM(PHANCONG.THOIGIAN)),2) AS 	TONG_THOI_GIAN
	FROM PHANCONG 
	INNER JOIN DEAN ON PHANCONG.MADA =DEAN.MADA
GROUP BY DEAN.TENDEAN

-----------------
DECLARE @avg_luong float;
	DECLARE @Ma_phong_nghien_cuu int;
	SELECT @Ma_phong_nghien_cuu =(SELECT MAPHG FROM PHONGBAN WHERE TENPHG=N'Nghiên cứu')
	SELECT @avg_luong = (SELECT ROUND(AVG(NHANVIEN.LUONG),2) FROM NHANVIEN  WHERE 	NHANVIEN.PHG=@Ma_phong_nghien_cuu)
	SELECT HONV + ' '+TENLOT + ' '+TENNV AS 'HỌ VÀ TÊN '
	FROM NHANVIEN
WHERE LUONG > @avg_luong

---- Bai 3 ----------
SELECT UPPER(HONV) AS HONV,
	LOWER(TENLOT) AS TENLOT,
	LOWER(LEFT(TENNV,1))+UPPER(SUBSTRING(TENNV,2,1))+SUBSTRING(TENNV,3,LEN(TENNV)-2) AS TENNV,
	SUBSTRING(DCHI,CHARINDEX(' ',DCHI),CHARINDEX(',',DCHI)-CHARINDEX(' ',DCHI)), 
	COUNT(MA_NVIEN) AS 'SO THAN NHAN' 
	FROM NHANVIEN
	INNER JOIN THANNHAN ON THANNHAN.MA_NVIEN=NHANVIEN.MANV
	GROUP BY HONV, TENLOT, TENNV, DCHI
HAVING COUNT(MA_NVIEN)>=2

---- Bai 4

SELECT * FROM NHANVIEN
WHERE YEAR(NGSINH) BETWEEN 1960 AND 1965

---------------
SELECT TENNV, YEAR(GETDATE())-YEAR(NGSINH) AS TUOI
FROM NHANVIEN

------------
SELECT  *,DATENAME(dw,NGSINH) AS DAY_OF_WEEK FROM NHANVIEN