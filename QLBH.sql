CREATE DATABASE QLBH 										
	GO
	USE QLBH
	--BÀI 1--
--CÂU 1--
CREATE TABLE KHACHHANG
(
	MAKH char(4) NOT NULL,
	HOTEN varchar(40),
	DCHI varchar(50),
	SODT varchar(20),
	NGSINH smalldatetime,
	NGDK smalldatetime,
	DOANHSO money,
	PRIMARY KEY (MAKH)
)
CREATE TABLE NHANVIEN
(
	MANV char(4) NOT NULL,
	HOTEN varchar(20),
	SODT varchar(20),
	NGVL smalldatetime,
	PRIMARY KEY (MANV)
)
CREATE TABLE SANPHAM
(
	MASP char(4) NOT NULL,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money,
	PRIMARY KEY (MASP)
)
CREATE TABLE HOADON
(
	SOHD int NOT NULL,
	NGHD smalldatetime,
	MAKH char(4) REFERENCES KHACHHANG(MAKH),
	MANV char(4) REFERENCES NHANVIEN(MANV),
	TRIGIA money,
	PRIMARY KEY (SOHD)
)
CREATE TABLE CTHD
(
	SOHD int REFERENCES HOADON(SOHD),
	MASP char(4)  REFERENCES SANPHAM(MASP),
	SL  int,
	PRIMARY KEY (SOHD, MASP)
)
									--BÀI 2--
--Câu 2:
ALTER TABLE dbo.SANPHAM ADD GHICHU VARCHAR(20)
--Câu 3:
ALTER TABLE dbo.KHACHHANG ADD LOAIKH TINYINT
--Câu 4:
ALTER TABLE dbo.SANPHAM ALTER COLUMN GHICHU VARCHAR(100)
--Câu 5:
ALTER TABLE dbo.SANPHAM DROP COLUMN GHICHU
--Câu 6:
ALTER TABLE dbo.KHACHHANG ALTER COLUMN LOAIKH VARCHAR(20)
--Câu 7:
ALTER TABLE dbo.SANPHAM ADD CONSTRAINT SP_CHECK CHECK(DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'))
--Câu 8:
ALTER TABLE dbo.SANPHAM ADD CONSTRAINT GIA_CHECK CHECK(GIA>=500)
--Câu 9:
ALTER TABLE dbo.CTHD ADD CONSTRAINT SL_CHECK CHECK(SL>=1)
--Câu 10:
ALTER TABLE dbo.KHACHHANG ADD CONSTRAINT NGDK_CHECK CHECK(NGDK>NGSINH)
							--Phần II--
set dateformat dmy
--Khach Hang--
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','08823451','22/10/1960','22/07/2006',13060000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) values('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','0908256478','03/04/1974','30/07/2006',280000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','0938776266','12/06/1980','08/05/2006',3860000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','0917325476','09/03/1965','10/02/2006',250000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','08246108','10/03/1950','28/10/2006',21000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','08631738','31/12/1981','24/11/2006',915000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','0916783565','06/04/1971','12/01/2006',12500)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','0938435756','10/01/1971','13/12/2006',365000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','08654763','03/09/1979','14/01/2007',70000)
insert into KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO)values('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','08768904','02/05/1983','16/01/2007',67500)
--Nhan Vien--
Insert into NHANVIEN values('NV01','Nguyen Nhu Nhut','0927345678','13/4/2006')
Insert into NHANVIEN values('NV02','Le Thi Phi Yen','0987567390','21/4/2006')
Insert into NHANVIEN values('NV03','Nguyen Van B','0997047382','27/4/2006')
Insert into NHANVIEN values('NV04','Ngo Thanh Tuan','0913758498','24/6/2006')
Insert into NHANVIEN values('NV05','Nguyen Thi Truc Than','0918590387','20/7/2006')
--San Pham--
Insert into SANPHAM values('BC01','But chi','cay','Singapore',3000)
Insert into SANPHAM values('BC02','But chi','cay','Singapore',5000)
Insert into SANPHAM values('BC03','But chi','cay','Viet Nam',3500)
Insert into SANPHAM values('BC04','But chi','hop','Viet Nam',30000)
Insert into SANPHAM values('BB01','But bi','cay','Viet Nam',5000)
Insert into SANPHAM values('BB02','But bi','cay','Trung Quoc',7000)
Insert into SANPHAM values('BB03','But bi','hop','Thai Lan',100000)
Insert into SANPHAM values('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
Insert into SANPHAM values('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
Insert into SANPHAM values('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
Insert into	SANPHAM values('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
Insert into SANPHAM values('TV05','Tap 100 trang','chuc','Viet Nam',23000)
Insert into SANPHAM values('TV06','Tap 200 trang','chuc','Viet Nam',53000)
Insert into SANPHAM values('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
Insert into	SANPHAM values('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
Insert into SANPHAM values('ST02','So tay loai 1','quyen','Viet Nam',55000)
Insert into SANPHAM values('ST03','So tay loai 2','quyen','Viet Nam',51000)
Insert into SANPHAM values('ST04','So tay','quyen','Thai Lan',55000)
Insert into SANPHAM values('ST05','So tay mong','quyen','Thai Lan',20000)
Insert into SANPHAM values('ST06','Phan viet bang','hop','Viet Nam',5000)
Insert into SANPHAM values('ST07','Phan khong bui','hop','Viet Nam',7000)
Insert into SANPHAM values('ST08','Bong bang','cai','Viet Nam',1000)
Insert into SANPHAM values('ST09','But long','cay','Viet Nam',5000)
Insert into SANPHAM values('ST10','But long','cay','Trung Quoc',7000)
--Hoa Don--
Insert into HOADON values(1001,'23/07/2006','KH01','NV01',320000)
Insert into HOADON values(1002,'12/08/2006','KH01','NV02',840000)
Insert into HOADON values(1003,'23/08/2006','KH02','NV01',100000)
Insert into HOADON values(1004,'01/09/2006','KH02','NV01',180000)
Insert into HOADON values(1005,'20/10/2006','KH01','NV02',3800000)
Insert into HOADON values(1006,'16/10/2006','KH01','NV03',2430000)
Insert into HOADON values(1007,'28/10/2006','KH03','NV03',510000)
Insert into HOADON values(1008,'28/10/2006','KH01','NV03',440000)
Insert into HOADON values(1009,'28/10/2006','KH03','NV04',200000)
Insert into HOADON values(1010,'01/11/2006','KH01','NV01',5200000)
Insert into HOADON values(1011,'04/11/2006','KH04','NV03',250000)
Insert into HOADON values(1012,'30/11/2006','KH05','NV03',21000)
Insert into HOADON values(1013,'12/12/2006','KH06','NV01',5000)
Insert into HOADON values(1014,'31/12/2006','KH03','NV02',3150000)
Insert into HOADON values(1015,'01/01/2007','KH06','NV01',910000)
Insert into HOADON values(1016,'01/01/2007','KH07','NV02',12500)
Insert into HOADON values(1017,'02/01/2007','KH08','NV03',35000)
Insert into HOADON values(1018,'13/01/2007','KH08','NV03',330000)
Insert into HOADON values(1019,'13/01/2007','KH01','NV03',30000)
Insert into HOADON values(1020,'14/01/2007','KH09','NV04',70000)
Insert into HOADON values(1021,'16/01/2007','KH10','NV03',67500)
Insert into HOADON values(1022,'16/01/2007',Null,'NV03',7000)
Insert into HOADON values(1023,'17/01/2007',Null,'NV01',330000)
--CTHD--
Insert into CTHD values(1001,'TV02',10)
Insert into CTHD  values(1001,'ST01',5)
Insert into CTHD  values(1001,'BC01',5)
Insert into CTHD values(1001,'BC02',10)
Insert into CTHD values(1001,'ST08',10)
Insert into CTHD values(1002,'BC04',20)
Insert into CTHD  values(1002,'BB01',20)
Insert into CTHD  values(1002,'BB02',20)
Insert into CTHD  values(1003,'BB03',10)
Insert into CTHD values(1004,'TV01',20)
Insert into CTHD values(1004,'TV02',10)
Insert into CTHD values(1004,'TV03',10)
Insert into CTHD values(1004,'TV04',10)
Insert into CTHD values(1005,'TV05',50)
Insert into CTHD  values(1005,'TV06',50)
Insert into CTHD  values(1006,'TV07',20)
Insert into CTHD values(1006,'ST01',30)
Insert into CTHD  values(1006,'ST02',10)
Insert into CTHD  values(1007,'ST03',10)
Insert into CTHD values(1008,'ST04',8)
Insert into CTHD  values(1009,'ST05',10)
Insert into CTHD  values(1010,'TV07',50)
Insert into CTHD  values(1010,'ST07',50)
Insert into CTHD  values(1010,'ST08',100)
Insert into CTHD values(1010,'ST04',50)
Insert into CTHD  values(1010,'TV03',100)
Insert into CTHD  values(1011,'ST06',50)
Insert into CTHD values(1012,'ST07',3)
Insert into CTHD values(1013,'ST08',5)
Insert into CTHD values(1014,'BC02',80)
Insert into CTHD  values(1014,'BB02',100)
Insert into CTHD  values(1014,'BC04',60)
Insert into CTHD  values(1014,'BB01',50)
Insert into CTHD values(1015,'BB02',30)
Insert into CTHD  values(1015,'BB03',7)
Insert into CTHD  values(1016,'TV01',5)
Insert into CTHD values(1017,'TV02',1)
Insert into CTHD  values(1017,'TV03',1)
Insert into CTHD  values(1017,'TV04',5)
Insert into CTHD  values(1018,'ST04',6)
Insert into CTHD  values(1019,'ST05',1)
Insert into CTHD  values(1019,'ST06',2)
Insert into CTHD  values(1020,'ST07',10)
Insert into CTHD  values(1021,'ST08',5)
Insert into CTHD values(1021,'TV01',7)
Insert into CTHD values(1021,'TV02',10)
Insert into CTHD values(1022,'ST07',1)
Insert into CTHD values(1023,'ST04',6)
--Cau 2--
SELECT * INTO SANPHAM1 FROM SANPHAM
SELECT * INTO KHACHHANG1 FROM KHACHHANG
--Cau 3--
UPDATE SANPHAM1 SET GIA =GIA+GIA*5/100 WHERE NUOCSX='Thai Lan'
--Cau 4--
UPDATE SANPHAM1 SET GIA=Gia -GIA*5/100 WHERE NUOCSX='Trung Quoc' And GIA<'10000'
--Cau 5--
SELECT * INTO KHACHHANG1 FROM KHACHHANG
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE((NGDK<'01/01/2007' AND DOANHSO >1000000) OR (NGDK > '01/01/2007' AND DOANHSO>2000000))
SELECT * FROM KHACHHANG1
					---PHAN III--
--1.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
--2.In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT IN('CAY', 'QUYEN')
--3.	In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE'B%01'
--4.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP,TENSP,NUOCSX
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
AND GIA BETWEEN 30000 AND 40000
--5.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP, NUOCSX
FROM SANPHAM
WHERE (NUOCSX = 'TRUNG QUOC' OR NUOCSX = 'THAI LAN') AND GIA BETWEEN 30000 AND 40000
--6.	In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD >= '1/1/2007' AND NGHD <= '1/2/2007'
--7.	In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT HD.SOHD, HD.TRIGIA
FROM HOADON HD
WHERE MONTH(HD.NGHD) = 1 AND YEAR(HD.NGHD) = 2007
ORDER BY HD.NGHD ASC, HD.TRIGIA DESC
--8.	In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT K.MAKH, HOTEN
FROM KHACHHANG K INNER JOIN HOADON H
ON K.MAKH = H.MAKH
WHERE NGHD = '1/1/2007'
--9.	In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SET DATEFORMAT DMY 
SELECT H.SOHD, TRIGIA
FROM HOADON H INNER JOIN NHANVIEN N
ON H.MANV = N.MANV
WHERE NGHD = '28/10/2006'
AND HOTEN = 'NGUYEN VAN B'
--10.	In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT DISTINCT S.MASP, TENSP
FROM SANPHAM S INNER JOIN CTHD C
ON S.MASP = C.MASP
AND EXISTS(SELECT *
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
AND MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006 AND MAKH IN(SELECT H.MAKH
FROM HOADON H INNER JOIN KHACHHANG K
ON H.MAKH = K.MAKH
WHERE HOTEN = 'NGUYEN VAN A') AND S.MASP = C.MASP)
-- 11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT DISTINCT SOHD from CTHD J
WHERE J.MASP='BB01' or J.MASP = 'BB02'
--12.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD from CTHD L
WHERE (L.MASP='BB01' OR L.MASP ='BB02') AND (L.SL BETWEEN 10 AND 20)
--13.	Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD
FROM CTHD A
WHERE A.MASP = 'BB01'
AND SL BETWEEN 10 AND 20
AND EXISTS(SELECT *
FROM CTHD B
WHERE B.MASP = 'BB02'
AND SL BETWEEN 10 AND 20
AND A.SOHD = B.SOHD)
--14.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT A.MASP, A.TENSP
FROM SANPHAM A INNER JOIN CTHD Q
ON A.MASP =Q.MASP
WHERE A.NUOCSX='Trung Quoc' AND Q.SOHD	IN(SELECT DISTINCT W.SOHD
FROM CTHD W INNER JOIN HOADON E 
ON W.SOHD=E.SOHD
WHERE NGHD='1/1/2007')
--15.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT S.MASP, TENSP
FROM SANPHAM S
WHERE NOT EXISTS(SELECT * 
FROM SANPHAM S2 INNER JOIN CTHD C
ON S2.MASP = C.MASP
AND S2.MASP = S.MASP)

--16.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT S.MASP,S.TENSP
FROM SANPHAM S
WHERE S.MASP NOT IN(SELECT C.MASP FROM CTHD C INNER JOIN HOADON H ON C.SOHD=H.SOHD WHERE YEAR(NGHD) = 2006) 
--17.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006
SELECT K.MASP,K.TENSP
FROM SANPHAM K
WHERE K.NUOCSX ='Trung Quoc' AND K.MASP NOT IN(SELECT U.MASP FROM CTHD U INNER JOIN HOADON I ON U.SOHD=I.SOHD WHERE YEAR(NGHD) =2006)
--18.	Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT DISTINCT L.SOHD
FROM HOADON L
WHERE YEAR(NGHD)= 2006 AND NOT EXISTS(SELECT*FROM SANPHAM P WHERE P.NUOCSX='Sisngapore' AND NOT EXISTS(SELECT*FROM CTHD D WHERE D.SOHD=L.SOHD AND P.MASP=D.MASP))  
--19.	Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*)
FROM HOADON H
WHERE MAKH NOT IN(SELECT MAKH FROM KHACHHANG K WHERE K.MAKH = H.MAKH)
																						--THUC HANH BUOI 4--
--Phan III--
--20.	Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT C.MASP) 
FROM CTHD C, HOADON H  
WHERE YEAR(NGHD)=2006 AND C.SOHD=H.SOHD
--21.	Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
SELECT MAX(DISTINCT H.TRIGIA) MAX, MIN(DISTINCT H.TRIGIA) MIN
FROM HOADON H
--22.	Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(DISTINCT D.TRIGIA) AVG 
FROM HOADON D
WHERE YEAR(NGHD)=2006
--23.	Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(J.TRIGIA) DOANH_THU
FROM HOADON J
WHERE YEAR(NGHD)=2006
--24.	Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT H.SOHD
FROM HOADON H
WHERE YEAR(H.NGHD)=2006 AND TRIGIA>=ALL(SELECT TRIGIA FROM HOADON H1 WHERE YEAR(H1.NGHD) =2006)
--25.	Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT DISTINCT H.SOHD,K.HOTEN
FROM KHACHHANG K, HOADON H
WHERE TRIGIA>=ALL(SELECT TRIGIA FROM HOADON WHERE YEAR(NGHD)=2006) AND YEAR(NGHD)=2006
--26.	In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 L.MAKH,L.HOTEN 
FROM KHACHHANG L 
ORDER BY DOANHSO DESC
--27.	In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT DISTINCT  S.MASP,S.TENSP
FROM SANPHAM S 
WHERE S.GIA IN (SELECT DISTINCT TOP 3 S1.GIA FROM SANPHAM S1 ORDER BY GIA DESC)

--28.	In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT DISTINCT P.MASP,P.TENSP
FROM SANPHAM P
WHERE P.NUOCSX='Thai Lan' AND P.GIA IN(SELECT DISTINCT TOP 3 P.GIA FROM SANPHAM P ORDER BY GIA DESC)
--29.	In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
 SELECT MASP,TENSP
 FROM SANPHAM S
 WHERE NUOCSX='Trung Quoc' AND GIA IN ( SELECT DISTINCT TOP 3 GIA FROM SANPHAM S1 WHERE S1.NUOCSX='Trung Quoc' AND S.NUOCSX=S1.NUOCSX ORDER BY GIA DESC)
--30.	* In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH,HOTEN,RANK() OVER(ORDER BY DOANHSO DESC) XEP_HANG 
FROM KHACHHANG
--31.	Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(DISTINCT S.MASP) 
FROM SANPHAM S
WHERE S.NUOCSX='Trung Quoc'
--32.	Tính tổng số sản phẩm của từng nước sản xuất.
SELECT S.NUOCSX,COUNT(DISTINCT S.MASP) Tong_San_Pham
FROM SANPHAM S
GROUP BY S.NUOCSX
--33.	Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT  S.NUOCSX,MAX(S.GIA) MAX, MIN(S.GIA) MIN,AVG(S.GIA) AVG
FROM SANPHAM S
GROUP BY S.NUOCSX
--34.	Tính doanh thu bán hàng mỗi ngày.
SELECT SUM(H.TRIGIA) DOANHTHU,DAY(H.NGHD) NGAY
FROM HOADON H
GROUP BY DAY(H.NGHD)
--35.	Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT P.MASP,SUM(H.SL) SUM
FROM HOADON, CTHD H,SANPHAM P
WHERE HOADON.SOHD=H.SOHD AND MONTH(NGHD)=10 AND YEAR(NGHD)=2006
GROUP BY P.MASP
--36.	Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(H.NGHD) THANG,SUM(H.TRIGIA) DOANHTHU
FROM CTHD C,HOADON H
WHERE YEAR(H.NGHD)=2006
GROUP BY MONTH(H.NGHD)
--37.	Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT H.SOHD,COUNT(H.MASP) SLSP
FROM CTHD H
GROUP BY H.SOHD
HAVING COUNT(H.MASP) >=4
--38.	Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT DISTINCT H.SOHD
FROM CTHD H,SANPHAM S
WHERE S.NUOCSX='Viet Nam' AND H.SL>=3 AND H.MASP=S.MASP
--39.	Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
SELECT K.MAKH,K.HOTEN 
FROM KHACHHANG K 
WHERE K.MAKH=(SELECT TOP 1 WITH TIES  H.MAKH FROM HOADON H GROUP BY H.MAKH ORDER BY COUNT(DISTINCT H.SOHD) DESC)
--40.	Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 MONTH(H.NGHD) THANG_DT_MAX
FROM HOADON H
WHERE YEAR(NGHD)=2006
GROUP BY MONTH(H.NGHD)
ORDER BY SUM(H.TRIGIA) DESC
--41.	Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT DISTINCT  S.MASP,S.TENSP
FROM SANPHAM S,HOADON 
WHERE S.MASP=(SELECT TOP 1 WITH TIES  C.MASP FROM CTHD C GROUP BY C.MASP ORDER BY SUM(C.SL) ASC) AND YEAR(NGHD)=2006
--42.	*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NUOCSX,MASP,TENSP
FROM SANPHAM S
WHERE GIA >=ALL(SELECT MAX(GIA) FROM SANPHAM S1 WHERE S.NUOCSX=S1.NUOCSX)
--43.	Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT S.NUOCSX
FROM SANPHAM S
GROUP BY NUOCSX
HAVING COUNT(S.GIA) >=3 
--44.	*Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT TOP 1 K.MAKH
FROM KHACHHANG K ,HOADON H
WHERE K.MAKH=(SELECT TOP 10 K1.MAKH FROM KHACHHANG K1 WHERE K.MAKH=K1.MAKH AND H.MAKH=K1.MAKH ORDER BY DOANHSO DESC)  
GROUP BY K.MAKH
ORDER BY COUNT(DISTINCT SOHD) DESC
--C2:
SELECT TOP 1 B.MAKH
FROM KHACHHANG K ,HOADON H ,(SELECT TOP 10 MAKH FROM KHACHHANG ORDER BY DOANHSO DESC) B 
WHERE K.MAKH=B.MAKH AND H.MAKH=B.MAKH
GROUP BY B.MAKH
ORDER BY COUNT(DISTINCT SOHD) DESC
--45.In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng mức giá cao thứ hai
SELECT DISTINCT MASP,TENSP
FROM SANPHAM 
WHERE GIA IN (SELECT MAX(GIA) FROM SANPHAM WHERE GIA NOT IN(SELECT MAX(GIA) FROM SANPHAM))
--46. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng mức giá cao thứ hai và thứ ba
SELECT MASP,TENSP
FROM SANPHAM 
WHERE GIA IN ( SELECT DISTINCT TOP 3 GIA  
			   FROM SANPHAM 
			   ORDER BY GIA DESC 
			   EXCEPT
			   SELECT DISTINCT TOP 1 GIA
			   FROM SANPHAM 
			   ORDER BY GIA DESC)
--47.Tìm sản phẩm (MASP, TENSP) bán chạy nhất theo từng tháng
SELECT YEAR(NGHD) NAM,MONTH(NGHD) THANG,MASP,SUM(SL) TONG_SO_LUONG
FROM HOADON H,CTHD C
WHERE H.SOHD=C.SOHD
GROUP BY YEAR(NGHD),MONTH(NGHD),MASP
--
SELECT YEAR(NGHD) NAM,MONTH(NGHD) THANG,MASP,SUM(SL) TONG_SO_LUONG
FROM HOADON H,CTHD C
WHERE H.SOHD=C.SOHD
GROUP BY YEAR(NGHD),MONTH(NGHD),MASP
HAVING SUM(SL) >=ALL(SELECT SUM(SL)
					FROM HOADON H1,CTHD C1
					WHERE H1.SOHD=C1.SOHD
					GROUP BY YEAR(NGHD),MONTH(NGHD),MASP)
--
SELECT YEAR(NGHD) NAM,MONTH(NGHD) THANG,MASP,SUM(SL) TONG_SO_LUONG
FROM HOADON H,CTHD C
WHERE H.SOHD=C.SOHD
GROUP BY YEAR(NGHD),MONTH(NGHD),MASP
HAVING SUM(SL) >=ALL(SELECT SUM(SL)
					FROM HOADON H1,CTHD C1
					WHERE H1.SOHD=C1.SOHD AND YEAR(H1.NGHD)=YEAR(H.NGHD)
					AND MONTH(H1.NGHD)=MONTH(H.NGHD)
					GROUP BY MASP)
--48. In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng)
SELECT TOP 3 MAKH,HOTEN, RANK() OVER(ORDER BY DOANHSO DESC) XEP_HANG
FROM KHACHHANG
													
													
													
													
													--Thuc hanh buoi 5 --
--11.	Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
CREATE TRIGGER KT_NGHD_NGDK ON HOADON
FOR INSERT
AS
BEGIN
DECLARE @NgayHD smalldatetime, @MaKH char(4), @NgayDK smalldatetime
SELECT @NgayHD=NGHD,@MaKH=MAKH
FROM inserted
SELECT @NgayDK=NGDK
FROM KHACHHANG
WHERE MAKH=@MaKH
IF(@NgayHD<@NgayDK) 
	BEGIN 
		PRINT 'LOI:NGAY HOA DON KHONG HOP LE!'
		ROLLBACK TRANSACTION
	END
ELSE
	BEGIN
		PRINT 'THEM MOI MOT HOA DON THANH CONG'
	END
END
--VD:Cài đặt trigger thực hiện việc cập nhật lại trị giá hóa đơn khi có một chi tiết hóa đơn mới được thêm vào.
create trigger trg_ins_cthd on CTHD
FOR INSERT
AS 
BEGIN
	DECLARE @SoHD int,@MaSP char(4),@SoLG int,@TriGia money
	SELECT @SoHD=SOHD,@MaSP=MASP,@SoLg=SL
	FROM inserted
	SET @TriGia=@SoLg * (SELECT GIA FROM SANPHAM WHERE MASP=@MaSP)
	DECLARE cur_cthd CURSOR
	FOR
		SELECT MASP,SL
		FROM CTHD
		WHERE @SoHD=SOHD
	OPEN cur_cthd
	FETCH NEXT FROM cur_cthd
	INTO @MaSP,@SoLg
	WHILE(@@FETCH_STATUS=0)
	BEGIN
		SET @TriGia=@TriGia +@SoLg * (SELECT GIA FROM SANPHAM WHERE MASP=@MaSP)
		FETCH NEXT FROM cur_cthd
		INTO @MaSP,@SoLg
	END
	CLOSE cur_cthd
	DEALLOCATE cur_cthd
	UPDATE HOADON SET TRIGIA=@TriGia WHERE SOHD=@SoHD
END
--12.	Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
CREATE TRIGGER CHECK_NGHD ON HOADON 
FOR INSERT
AS 
BEGIN
	DECLARE @NgayHD smalldatetime,@MaNV char(4),@NgayVL smalldatetime
	SELECT @NgayHD=NGHD
	FROM inserted
	SELECT @MaNV=MANV,@NgayVL=NGVL
	FROM NHANVIEN
	WHERE @MaNV=MANV
	IF(@NgayHD >= @NgayVL)
		BEGIN 
			PRINT 'NGAY HOA DON LON HON NGAY VAO LAM :TRUE!'
		END
	ELSE
		BEGIN 
			PRINT 'NGAY HOA DON NHO HON NGAY VAO LAM :FALSE!'
			ROLLBACK TRANSACTION
		END
END
--13.	Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
CREATE TRIGGER Tong_thanh_tien  ON CTHD 
FOR INSERT
AS
BEGIN
	DECLARE @Tong money,@SoHD int,@MaSP char(4),@SoLuong int
	SELECT @SoHD=SOHD,@SoLuong=SL,@MaSP=MASP
	FROM inserted 
	SELECT @Tong=TRIGIA  
	FROM HOADON H
	SET @Tong =@Tong + @SoLuong * (SELECT TRIGIA FROM HOADON WHERE @Tong=TRIGIA)
	FETCH NEXT FROM Tong_thanh_tien 
	into @Tong,@SoLuong
	while(@@FETCH_STATUS=0)
	BEGIN
		SET @Tong=@Tong +@SoLuong * (SELECT TRIGIA FROM HOADON WHERE @Tong=TRIGIA)
		FETCH NEXT FROM Tong_thanh_tien
		INTO  @Tong,@SoLuong
	END
	CLOSE Tong_thanh_tien
	DEALLOCATE Tong_thanh_tien
	UPDATE HOADON SET TRIGIA=@Tong WHERE SOHD=@SoHD
END
--14.	Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua.
CREATE TRIGGER DOANH_SO ON HOADON
FOR INSERT
AS
BEGIN
	DECLARE @DOANHSO money,@MaKH char(4),@SoHD char(4)
	SELECT @DOANHSO =SUM(TRIGIA),@SoHD=SOHD,@MaKH=MAKH
	FROM inserted
	WHERE @MaKH=MAKH
	GROUP BY SOHD,MAKH
	SET @DOANHSO=@DOANHSO +(SELECT TRIGIA FROM HOADON  GROUP BY TRIGIA )
	FETCH NEXT FROM DOANH_SO
	INTO @DOANHSO,@SOHD
	WHILE(@@FETCH_STATUS = 0) 
	BEGIN
		SET @DOANHSO=@DOANHSO +(SELECT TRIGIA FROM HOADON GROUP BY TRIGIA)
		FETCH NEXT FROM DOANH_SO
		INTO @DOANHSO,@SOHD
	END
	CLOSE DOANH_SO
	DEALLOCATE DOANH_SO
	UPDATE HOADON SET @DOANHSO=TRIGIA WHERE @SoHD=SOHD
END


