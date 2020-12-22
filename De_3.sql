Create database BAITHI_DE3
GO
USE BAITHI_DE3
Create table NHACUNGCAP
(
	MANCC char(5) not null,
	TENNCC varchar(40),
	QUOCGIA varchar(10),
	LOAINCC varchar(40),
	Primary key(MANCC)
)
Create table DUOCPHAM
(
	MADP char(4) not null,
	TENDP varchar(50),
	LOAIDP varchar(20),
	GIA money,
	Primary key(MADP)
)
Create table PHIEUNHAP 
(
	SOPN int not null,
	NGNHAP smalldatetime,
	MANCC char(5) references NHACUNGCAP(MANCC),
	LOAINHAP varchar(20) 
	Primary key(SOPN)
)
Create table CTPN
(
	SOPN int references PHIEUNHAP(SOPN),
	MADP char(4) references DUOCPHAM(MADP),
	SOLUONG int,
	Primary key(SOPN,MADP)
)
 Set dateformat dmy 
 --Nha Cung Cap--
 insert into NHACUNGCAP values('NCC01', 'Phuc Hung', 'Viet Nam', 'Thuong xuyen')
 insert into NHACUNGCAP values('NCC02', 'J.B.Pharmaceuticals', 'India' ,'Vang lai')
 insert into NHACUNGCAP values('NCC03', 'Sapharco', 'Singapore', 'Vang lai')
 --Duoc Pham--
 insert into DUOCPHAM values('DP01', 'Thuoc ho PH' ,'Siro', 120.000)
 insert into DUOCPHAM values('DP02', 'Zecuf Herbal CouchRemedy' ,'Vien nen', 200.000)
 insert into DUOCPHAM values('DP03', 'Cotrim' ,'Vien sui', 80.000)
 --Phieu Nhap--
 insert into PHIEUNHAP values(00001, '22/11/2017', 'NCC01', 'Noi dia')
 insert into PHIEUNHAP values(00002, '04/12/2017', 'NCC03', 'Nhap khau')
 insert into PHIEUNHAP values(00003, '10/12/2017', 'NCC02', 'Nhap khau')
 --CTPN--
 insert into CTPN values(00001,'DP01', 100)
 insert into CTPN values(00001,'DP02', 200)
 insert into CTPN values(00003,'DP03', 543)
 --3.Tất cả các dược phẩm có loại là Siro đều có giá lớn hơn 100.000đ
ALTER TABLE dbo.DUOCPHAM ADD CHECK (LOAIDP <> 'Siro' OR GIA > 100000)

--4.Hiện thực ràng buộc toàn vẹn sau: Phiếu nhập của những nhà cung cấp ở những quốc gia khác Việt Nam đều có loại nhập là Nhập khẩu.
Create trigger trg_up_ncc on NHACUNGCAP
for update
as if UPDATE (QUOCGIA)
begin
	if exists (select*from inserted I,PHIEUNHAP P where I.MANCC=P.MANCC and I.QUOCGIA <> 'Viet Nam'
	and P.LOAINHAP <> 'Nhap khau')
	begin
		Raiserror('Loi',16,1)
		Rollback tran
	end
	else 
	begin
		print 'Thanh cong'
	end

end

Create trigger trg_is_ph on PHIEUNHAP
for insert
as 
begin
	if exists (select*from inserted I,NHACUNGCAP N where I.MANCC=N.MANCC and N.QUOCGIA <> 'Viet Nam'
	and I.LOAINHAP <> 'Nhap khau')
	begin
		Raiserror('Loi',16,1)
		Rollback tran
	end
	else 
	begin
		print 'Thanh cong'
	end

end

Create trigger trg_up_phieunhap on PHIEUNHAP
for update
as if (UPDATE (MANCC) OR UPDATE(LOAINHAP))
begin
	if exists (select*from inserted I,NHACUNGCAP N where I.MANCC=N.MANCC and N.QUOCGIA <> 'Viet Nam'
	and I.LOAINHAP <> 'Nhap khau')
	begin
		Raiserror('Loi',16,1)
		Rollback tran
	end
	else 
	begin
		print 'Thanh cong'
	end

end
--5. Tìm tất cả các phiếu nhập có ngày nhập trong tháng 12 năm 2017, sắp xếp kết quả tăng dần theo ngày nhập
Select *from PHIEUNHAP
where Month(NGNHAP) = 12 and YEAR(NGNHAP)=2017
ORDER BY MONTH(NGNHAP) asc

--6. Tìm dược phẩm được nhập số lượng nhiều nhất trong năm 2017
Select top 1 D.MADP,TENDP,LOAIDP,GIA
from DUOCPHAM D,CTPN C
where D.MADP=C.MADP
ORDER BY SOLUONG DESC

--7.Tìm dược phẩm chỉ có nhà cung cấp thường xuyên (LOAINCC là Thuong xuyen) cung cấp, nhà cung cấp vãng lai (LOAINCC là Vang lai) không cung cấp
select*from DUOCPHAM
where not exists(select*from CTPN where CTPN.MADP=DUOCPHAM.MADP 
and not exists (select*from PHIEUNHAP WHERE PHIEUNHAP.SOPN=CTPN.SOPN 
and not exists(Select*from NHACUNGCAP where NHACUNGCAP.MANCC=PHIEUNHAP.MANCC and LOAINCC='Vang lai')))  

--8.Tìm nhà cung cấp đã từng cung cấp tất cả những dược phẩm có giá trên 100.000đ trong năm 2017
select*from NHACUNGCAP 
where  not exists (select*from PHIEUNHAP where NHACUNGCAP.MANCC=PHIEUNHAP.MANCC 
and YEAR(NGNHAP)=2017 and not exists(select*from CTPN where CTPN.SOPN=PHIEUNHAP.SOPN and 
not exists(select*from DUOCPHAM where DUOCPHAM.MADP=CTPN.MADP and GIA < 100.000 )))