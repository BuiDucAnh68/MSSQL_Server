Create database BAITHI_DE4
go 
use BAITHI_DE4 
Create table KHACHHANG
(
	MAKH char(4) not null,
	TENKH varchar(40),
	DIACHI varchar(20),
	LOAIKH varchar(20),
	Primary key(MAKH)
)
Create table LOAICAY
(
	MALC char(4) not null,
	TENLC varchar(40),
	XUATXU varchar(20),
	GIA money,
	primary key(MALC)
)
Create table HOADON
(
	SOHD int not null,
	NGHD smalldatetime,
	MAKH char(4) references KHACHHANG(MAKH),
	KHUYENMAI int,
	Primary key(SOHD),
)
Create table CTHD
(
	SOHD int references HOADON(SOHD),
	MALC char(4) references LOAICAY(MALC),
	SOLUONG int,
)
Set dateformat dmy
--Khach hang
Insert into KHACHHANG values ('KH01', 'Liz Kim Cuong', 'Ha Noi', 'Vang lai')
Insert into KHACHHANG values ('KH02', 'Ivone Dieu Linh' ,'Da Nang', 'Thuong xuyen')
Insert into KHACHHANG values ('KH03', 'Emma Nhat Khanh', 'TP.HCM', 'Vang lai')
--Loai cay
Insert into LOAICAY values('LC01', 'Xuong rong tai tho', 'Mexico', 180.000)
Insert into LOAICAY values('LC02', 'Sen thach ngoc', 'Anh', 300.000)
Insert into LOAICAY values('LC03', 'Ba mau rau', 'Nam Phi', 270.000)
--Hoa don
Insert into HOADON values(00001, '22/11/2017', 'KH01',5)
Insert into HOADON values(00002, '4/12/2017', 'KH03',5)
Insert into HOADON values(00003, '10/12/2017', 'KH02',10)
--CTHD 
Insert into CTHD values(00001 ,'LC01',1)
Insert into CTHD values(00001 ,'LC02',2)
Insert into CTHD values(00003 ,'LC03',3)

--3. Hiện thực ràng buộc toàn vẹn sau: Tất cả các mặt hàng xuất xứ từ nước Anh đều có giá lớn hơn 250.000
alter table LOAICAY add check (XUATXU <> 'Anh' or GIA >250.000)
--4.Hiện thực ràng buộc toàn vẹn sau: Hóa đơn mua với số lượng tổng cộng lớn hơn hoặc bằng 5 đều được giảm giá 10 phần trăm
Create trigger trg_up_HD on HOADON
for update 
as if UPDATE (KHUYENMAI)
begin
	if exists(select*from inserted I,CTHD C where I.SOHD=C.SOHD and I.KHUYENMAI <10
				group by I.SOHD 
				HAVING SUM(C.SOLUONG) >=5)
		begin
			raiserror('Loi',16,1)
			rollback tran
		end
	else
	begin
		print 'Thanh cong'
	end
end

CREATE TRIGGER trg_ins_cthd ON CTHD
FOR INSERT
AS
BEGIN
	-- Tìm những hóa đơn nào có KhuyenMai bé hơn 10 mới update
	--- những hóa đơn có KhuyenMai >= 10 sẵn thì để nguyên
	UPDATE HOADON
	SET KHUYENMAI = 10
	WHERE SOHD = (SELECT I.SOHD FROM INSERTED I, HOADON H, CTHD C
				WHERE I.SOHD = H.SOHD AND H.SOHD = C.SOHD
					AND H.KHUYENMAI < 10
				GROUP BY I.SOHD
				HAVING SUM(C.SOLUONG) >= 5)
				
	PRINT('DA CAP NHAT LAI KHUYEN MAI')
END

CREATE TRIGGER trg_upd_cthd ON CTHD
FOR UPDATE
AS IF (UPDATE(SOHD) OR UPDATE(SOLUONG))
BEGIN
	-- Tìm những hóa đơn nào có KhuyenMai bé hơn 10 mới update
	--- những hóa đơn có KhuyenMai >= 10 sẵn thì để nguyên
	UPDATE HOADON
	SET KHUYENMAI = 10
	WHERE SOHD = (SELECT I.SOHD FROM INSERTED I, HOADON H, CTHD C
				WHERE I.SOHD = H.SOHD AND H.SOHD = C.SOHD
					AND H.KHUYENMAI < 10
				GROUP BY I.SOHD
				HAVING SUM(C.SOLUONG) >= 5)
				
	PRINT('DA CAP NHAT LAI KHUYEN MAI')
END

--5.Tìm tất cả các hóa đơn có ngày lập hóa đơn trong quý 4 năm 2017, sắp xếp kết quả tăng dần theo phần trăm giảm giá
select*from HOADON
where MONTH(NGHD)=11 or MONTH(NGHD)=12 and YEAR(NGHD)=2017 
order by KHUYENMAI asc

--6.Tìm loại cây có số lượng mua ít nhất trong tháng 12
Select*from LOAICAY where exists(select top 1 SOLUONG from CTHD where LOAICAY.MALC=CTHD.MALC 
and exists(select*from HOADON where HOADON.SOHD=CTHD.SOHD and MONTH(NGHD)=12) order by SOLUONG asc)
--7.Tìm loại cây mà cả khách thường xuyên (LOAIKH là ‘Thuong xuyen’) và khách vãng lai (LOAIKH là ‘Vang lai’) đều mua
select*from LOAICAY 
where not exists(select*from CTHD where LOAICAY.MALC=CTHD.MALC and not exists
(select*from HOADON where HOADON.SOHD= CTHD.SOHD and not exists
(select*from KHACHHANG where KHACHHANG.MAKH=HOADON.MAKH and KHACHHANG.LOAIKH='Vang lai' or LOAIKH='Thuong xuyen')))
--8. Tìm khách hàng đã từng mua tất cả các loại cây
select*from KHACHHANG
where not exists(select*from HOADON where HOADON.MAKH=KHACHHANG.MAKH and not exists(select*from CTHD where CTHD.SOHD=HOADON.SOHD
and not exists (select*from LOAICAY where LOAICAY.MALC=CTHD.MALC)))



