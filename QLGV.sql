﻿CREATE DATABASE QLGV
GO 
USE QLGV
GO
							--BAI 1--
--CÂU 1--
CREATE TABLE KHOA
(
	MAKHOA varchar(4) NOT NULL,
	TENKHOA varchar(40),
	NGTLAP	smalldatetime,
	TRGKHOA	char(4),
	PRIMARY KEY (MAKHOA)
)
CREATE TABLE MONHOC
(
	MAMH varchar(10) NOT NULL,
	TENMH VARCHAR(40),		
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4) REFERENCES dbo.KHOA(MAKHOA),
	PRIMARY KEY (MAMH)
)
CREATE TABLE DIEUKIEN
(
	MAMH varchar(10) REFERENCES MONHOC(MAMH),
	MAMH_TRUOC VARCHAR(10) REFERENCES MONHOC(MAMH),
	PRIMARY KEY (MAMH_TRUOC,MAMH)
)
CREATE TABLE GIAOVIEN
(
	MAGV char(4) NOT NULL,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4) REFERENCES KHOA(MAKHOA),
	PRIMARY KEY (MAGV)
)
CREATE TABLE LOP
(
	MALOP char(3) NOT NULL,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4) REFERENCES GIAOVIEN(MAGV),
	PRIMARY KEY (MALOP)
)
CREATE TABLE HOCVIEN
(
	MAHV char(5) NOT NULL,
	HO varchar(40),
	TEN varchar(40), 
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3) REFERENCES LOP(MALOP),
	PRIMARY KEY (MAHV)
)
CREATE TABLE GIANGDAY
(
	MALOP char(3) REFERENCES LOP(MALOP),
	MAMH varchar(10) REFERENCES MONHOC(MAMH),
	MAGV char(4) REFERENCES GIAOVIEN(MAGV),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
)
CREATE TABLE KETQUATHI
(
	MAHV CHAR(5) REFERENCES dbo.HOCVIEN(MAHV),
	MAMH VARCHAR(10) REFERENCES dbo.MONHOC(MAMH),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10),
)

								--BAI 3--
--CAU 3-- 
ALTER TABLE dbo.HOCVIEN ADD CHECK (GIOITINH IN('NAM','NU'))
ALTER TABLE dbo.GIAOVIEN ADD CHECK (GIOITINH IN('NAM','NU'))
--CAU 4--
ALTER TABLE dbo.KETQUATHI ADD CHECK(DIEM >=0 AND DIEM<=10)  
--CAU 5--
ALTER TABLE dbo.KETQUATHI ADD CONSTRAINT CHECK_DIEM CHECK((KQUA='Dat' AND DIEM>=5 AND DIEM<=10) OR (DIEM >= 0 AND DIEM<=5 AND KQUA='Khong dat'))
--CAU 6-- 
ALTER TABLE dbo.KETQUATHI ADD CHECK(LANTHI >=1 OR LANTHI <=3)
--CAU 7--
ALTER TABLE dbo.GIANGDAY ADD CHECK (HOCKY IN('1','2','3')) 
--CAU 8--
ALTER TABLE dbo.GIAOVIEN ADD CHECK( HOCVI IN ('CN','KS','ThS', 'TS','PTS'))

			-----THUC HANH 2------
SET dateformat dmy
--KHOA--
Insert into dbo.KHOA values ('KHMT','Khoa hoc may tinh','7/6/2005','GV01')
Insert into dbo.KHOA values ('HTTT','He thong thong tin','7/6/2005','GV02')
Insert into dbo.KHOA values ('CNPM','Cong nghe phan mem','7/6/2005','GV04')
Insert into dbo.KHOA values ('MTT',	'Mang va truyen thong',	'20/10/2005','GV03')
Insert into dbo.KHOA values ('KTMT','Ky thuat may tinh','20/12/2005',Null)
--MON HOC--
INSERT INTO dbo.MONHOC VALUES('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT')
INSERT INTO dbo.MONHOC VALUES('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT')
INSERT INTO dbo.MONHOC VALUES('CSDL', 'Co so du lieu', 3, 1, 'HTTT')
INSERT INTO dbo.MONHOC VALUES('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT')
INSERT INTO dbo.MONHOC VALUES('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT')
INSERT INTO dbo.MONHOC VALUES('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT')
INSERT INTO dbo.MONHOC VALUES('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT')
INSERT INTO dbo.MONHOC VALUES('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT')
INSERT INTO dbo.MONHOC VALUES('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT')
INSERT INTO dbo.MONHOC VALUES('HDH', 'He dieu hanh', 4, 1, 'KTMT')
INSERT INTO dbo.MONHOC VALUES('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM')
INSERT INTO dbo.MONHOC VALUES('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM')
INSERT INTO dbo.MONHOC VALUES('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM')
--DIEU KIEN--
INSERT INTO dbo.DIEUKIEN VALUES('CSDL', 'CTRR')
INSERT INTO dbo.DIEUKIEN VALUES('CSDL', 'CTDLGT')
INSERT INTO dbo.DIEUKIEN VALUES('CTDLGT', 'THDC')
INSERT INTO dbo.DIEUKIEN VALUES('PTTKTT', 'THDC')
INSERT INTO dbo.DIEUKIEN VALUES('PTTKTT', 'CTDLGT')
INSERT INTO dbo.DIEUKIEN VALUES('DHMT', 'THDC')
INSERT INTO dbo.DIEUKIEN VALUES('LTHDT', 'THDC')
INSERT INTO dbo.DIEUKIEN VALUES('PTTKHTTT', 'CSDL')
--GIAO VIEN--
INSERT INTO dbo.GIAOVIEN VALUES('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '2/5/1950', '11/1/2004', 5.00, 2250000, 'KHMT')
INSERT INTO dbo.GIAOVIEN VALUES('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '17/12/1965', '20/4/2004', 4.50, 2025000, 'HTTT')
INSERT INTO dbo.GIAOVIEN VALUES('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1/8/1950', '23/9/2004', 4.00, 1800000, 'CNPM')
INSERT INTO dbo.GIAOVIEN VALUES('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '22/2/1961', '12/1/2005', 4.50, 2025000, 'KTMT')
INSERT INTO dbo.GIAOVIEN VALUES('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '12/3/1958', '12/1/2005', 3.00, 1350000, 'HTTT')
INSERT INTO dbo.GIAOVIEN VALUES('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '11/3/1953', '12/1/2005', 4.50, 2025000, 'KHMT')
INSERT INTO dbo.GIAOVIEN VALUES('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '23/11/1971', '1/3/2005', 4.00, 1800000, 'KHMT')
INSERT INTO dbo.GIAOVIEN VALUES('GV08', 'Le Thi Tran', 'KS', 'Null', 'Nu', '26/3/1974', '1/3/2005', 1.69, 760500, 'KHMT')
INSERT INTO dbo.GIAOVIEN VALUES('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '31/12/1966', '1/3/2005', 4.00, 1800000, 'HTTT')
INSERT INTO dbo.GIAOVIEN VALUES('GV10', 'Le Tran Anh Loan', 'KS', 'Null', 'Nu', '17/7/1972', '1/3/2005', 1.86, 837000, 'CNPM')
INSERT INTO dbo.GIAOVIEN VALUES('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '12/1/1980', '15/5/2005', 2.67, 1201500, 'MTT')
INSERT INTO dbo.GIAOVIEN VALUES('GV12', 'Tran Van Anh', 'CN', 'Null', 'Nu', '29/3/1981', '15/5/2005', 1.69, 760500, 'CNPM')
INSERT INTO dbo.GIAOVIEN VALUES('GV13', 'Nguyen Linh Dan', 'CN', 'Null', 'Nu', '23/5/1980', '15/5/2005', 1.69, 760500, 'KTMT')
INSERT INTO dbo.GIAOVIEN VALUES('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '30/11/1976', '15/5/2005', 3.00, 1350000, 'MTT')
INSERT INTO dbo.GIAOVIEN VALUES('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '4/5/1978', '15/5/2005', 3.00, 1350000, 'KHMT')
--LOP--
INSERT INTO dbo.LOP VALUES('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07')
INSERT INTO dbo.LOP VALUES('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09')
INSERT INTO dbo.LOP VALUES('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14')
--HOC VIEN--
INSERT INTO dbo.HOCVIEN VALUES('K1101', 'Nguyen Van', 'A', '27/1/1986', 'Nam', 'TpHCM', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1102', 'Tran Ngoc', 'Han', '14/3/1986', 'Nu', 'Kien Giang', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1103', 'Ha Duy', 'Lap', '18/4/1986', 'Nam', 'Nghe An', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1104', 'Tran Ngoc', 'Linh', '30/3/1986', 'Nu', 'Tay Ninh', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1105', 'Tran Minh', 'Long', '27/2/1986', 'Nam', 'TpHCM', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1106', 'Le Nhat', 'Minh', '24/1/1986', 'Nam', 'TpHCM', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1107', 'Nguyen Nhu', 'Nhut', '27/1/1986', 'Nam', 'Ha Noi', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1108', 'Nguyen Manh', 'Tam', '27/2/1986', 'Nam', 'Kien Giang', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1109', 'Phan Thi Thanh', 'Tam', '27/1/1986', 'Nu', 'Vinh Long', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1110', 'Le Hoai', 'Thuong', '5/2/1986', 'Nu', 'Can Tho', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1111', 'Le Ha', 'Vinh', '25/12/1986', 'Nam', 'Vinh Long', 'K11')
INSERT INTO dbo.HOCVIEN VALUES('K1201', 'Nguyen Van', 'B', '11/2/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1202', 'Nguyen Thi Kim', 'Duyen', '18/1/1986', 'Nu', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1203', 'Tran Thi Kim', 'Duyen', '17/9/1986', 'Nu', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1204', 'Truong My', 'Hanh', '19/5/1986', 'Nu', 'Dong Nai', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1205', 'Nguyen Thanh', 'Nam', '17/4/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1206', 'Nguyen Thi Truc', 'Thanh', '4/3/1986', 'Nu', 'Kien Giang', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1207', 'Tran Thi Bich', 'Thuy', '8/2/1986', 'Nu', 'Nghe An', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1208', 'Huynh Thi Kim', 'Trieu', '8/4/1986', 'Nu', 'Tay Ninh', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1209', 'Pham Thanh', 'Trieu', '23/2/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1210', 'Ngo Thanh', 'Tuan', '14/2/1986', 'Nam', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1211', 'Do Thi', 'Xuan', '9/3/1986', 'Nu', 'Ha Noi', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1212', 'Le Thi Phi', 'Yen', '12/3/1986', 'Nu', 'TpHCM', 'K12')
INSERT INTO dbo.HOCVIEN VALUES('K1301', 'Nguyen Thi Kim', 'Cuc', '9/6/1986', 'Nu', 'Kien Giang', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1302', 'Truong Thi My', 'Hien', '18/3/1986', 'Nu', 'Nghe An', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1303', 'Le Duc', 'Hien', '21/3/1986', 'Nam', 'Tay Ninh', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1304', 'Le Quang', 'Hien', '18/4/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1305', 'Le Thi', 'Huong', '27/3/1986', 'Nu', 'TpHCM', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1306', 'Nguyen Thai', 'Huu', '30/3/1986', 'Nam', 'Ha Noi', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1307', 'Tran Minh', 'Man', '28/5/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1308', 'Nguyen Hieu', 'Nghia', '8/4/1986', 'Nam', 'Kien Giang', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1309', 'Nguyen Trung', 'Nghia', '18/1/1987', 'Nam', 'Nghe An', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1310', 'Tran Thi Hong', 'Tham', '22/4/1986', 'Nu', 'Tay Ninh', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1311', 'Tran Minh', 'Thuc', '4/4/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO dbo.HOCVIEN VALUES('K1312', 'Nguyen Thi Kim', 'Yen', '7/9/1986', 'Nu', 'TpHCM', 'K13')
--GIANG DAY--
INSERT INTO dbo.GIANGDAY VALUES('K11', 'THDC', 'GV07', 1, 2006, '2/1/2006', '12/5/2006')
INSERT INTO dbo.GIANGDAY VALUES('K12', 'THDC', 'GV06', 1, 2006, '2/1/2006', '12/5/2006')
INSERT INTO dbo.GIANGDAY VALUES('K13', 'THDC', 'GV15', 1, 2006, '2/1/2006', '12/5/2006')
INSERT INTO dbo.GIANGDAY VALUES('K11', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006')
INSERT INTO dbo.GIANGDAY VALUES('K12', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006')
INSERT INTO dbo.GIANGDAY VALUES('K13', 'CTRR', 'GV08', 1, 2006, '9/1/2006', '17/5/2006')
INSERT INTO dbo.GIANGDAY VALUES('K11', 'CSDL', 'GV05', 2, 2006, '1/6/2006', '15/7/2006')
INSERT INTO dbo.GIANGDAY VALUES('K12', 'CSDL', 'GV09', 2, 2006, '1/6/2006', '15/7/2006')
INSERT INTO dbo.GIANGDAY VALUES('K13', 'CTDLGT', 'GV15', 2, 2006, '1/6/2006', '15/7/2006')
INSERT INTO dbo.GIANGDAY VALUES('K13', 'CSDL', 'GV05', 3, 2006, '1/8/2006', '15/12/2006')
INSERT INTO dbo.GIANGDAY VALUES('K13', 'DHMT', 'GV07', 3, 2006, '1/8/2006', '15/12/2006')
INSERT INTO dbo.GIANGDAY VALUES('K11', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006')
INSERT INTO dbo.GIANGDAY VALUES('K12', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006')
INSERT INTO dbo.GIANGDAY VALUES('K11', 'HDH', 'GV04', 1, 2007, '2/1/2007', '18/2/2007')
INSERT INTO dbo.GIANGDAY VALUES('K12', 'HDH', 'GV04', 1, 2007, '2/1/2007', '20/3/2007')
INSERT INTO dbo.GIANGDAY VALUES('K11', 'DHMT', 'GV07', 1, 2007, '18/2/2007', '20/3/2007')
--KET QUA THI--
INSERT INTO dbo.KETQUATHI VALUES('K1101', 'CSDL', 1, '20/7/2006', 10.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1101', 'CTDLGT', 1, '28/12/2006', 9.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1101', 'THDC', 1, '20/5/2006', 9.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1101', 'CTRR', 1, '13/5/2006', 9.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CSDL', 1, '20/7/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CSDL', 2, '27/7/2006', 4.25, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CSDL', 3, '10/8/2006', 4.50, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CTDLGT', 1, '28/12/2006', 4.50, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CTDLGT', 2, '5/1/2007', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CTDLGT', 3, '15/1/2007', 6.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'THDC', 1, '20/5/2006', 5.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1102', 'CTRR', 1, '13/5/2006', 7.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1103', 'CSDL', 1, '20/7/2006', 3.50, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1103', 'CSDL', 2, '27/7/2006', 8.25, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1103', 'CTDLGT', 1, '28/12/2006', 7.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1103', 'THDC', 1, '20/5/2006', 8.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1103', 'CTRR', 1, '13/5/2006', 6.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1104', 'CSDL', 1, '20/7/2006', 3.75, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1104', 'CTDLGT', 1, '28/12/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1104', 'THDC', 1, '20/5/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1104', 'CTRR', 1, '13/5/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1104', 'CTRR', 2, '20/5/2006', 3.50, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1104', 'CTRR', 3, '30/6/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1201', 'CSDL', 1, '20/7/2006', 6.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1201', 'CTDLGT', 1, '28/12/2006', 5.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1201', 'THDC', 1, '20/5/2006', 8.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1201', 'CTRR', 1, '13/5/2006', 9.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'CSDL', 1, '20/7/2006', 8.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'CTDLGT', 1, '28/12/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'CTDLGT', 2, '5/1/2007', 5.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'THDC', 1, '20/5/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'THDC', 2, '27/5/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'CTRR', 1, '13/5/2006', 3.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'CTRR', 2, '20/5/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1202', 'CTRR', 3, '30/6/2006', 6.25, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1203', 'CSDL', 1, '20/7/2006', 9.25, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1203', 'CTDLGT', 1, '28/12/2006', 9.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1203', 'THDC', 1, '20/5/2006', 10.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1203', 'CTRR', 1, '13/5/2006', 10.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1204', 'CSDL', 1, '20/7/2006', 8.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1204', 'CTDLGT', 1, '28/12/2006', 6.75, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1204', 'THDC', 1, '20/5/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1204', 'CTRR', 1, '13/5/2006', 6.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1301', 'CSDL', 1, '20/12/2006', 4.25, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1301', 'CTDLGT', 1, '25/7/2006', 8.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1301', 'THDC', 1, '20/5/2006', 7.75, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1301', 'CTRR', 1, '13/5/2006', 8.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1302', 'CSDL', 1, '20/12/2006', 6.75, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1302', 'CTDLGT', 1, '25/7/2006', 5.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1302', 'THDC', 1, '20/5/2006', 8.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1302', 'CTRR', 1, '13/5/2006', 8.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'CSDL', 1, '20/12/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'CTDLGT', 1, '25/7/2006', 4.50, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'CTDLGT', 2, '7/8/2006', 4.00, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'CTDLGT', 3, '15/8/2006', 4.25, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'THDC', 1, '20/5/2006', 4.50, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'CTRR', 1, '13/5/2006', 3.25, 'Khong Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1303', 'CTRR', 2, '20/5/2006', 5.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1304', 'CSDL', 1, '20/12/2006', 7.75, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1304', 'CTDLGT', 1, '25/7/2006', 9.75, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1304', 'THDC', 1, '20/5/2006', 5.50, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1304', 'CTRR', 1, '13/5/2006', 5.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1305', 'CSDL', 1, '20/12/2006', 9.25, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1305', 'CTDLGT', 1, '25/7/2006', 10.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1305', 'THDC', 1, '20/5/2006', 8.00, 'Dat')
INSERT INTO dbo.KETQUATHI VALUES('K1305', 'CTRR', 1, '13/5/2006', 10.00, 'Dat')
														-----Thuc Hanh Ngay 2 ---- 
	--PHAN I---
--11.Học viên ít nhất là 18 tuổi.
ALTER TABLE dbo.HOCVIEN ADD CONSTRAINT CHECK_TUOI CHECK( YEAR(GETDATE())-YEAR(NGSINH)>18 )
--12.	Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE dbo.GIANGDAY ADD CONSTRAINT CHECK_GD CHECK (TUNGAY < DENNGAY)
--13.	Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE dbo.GIAOVIEN ADD CONSTRAINT CHECK__TUOIGV CHECK(YEAR(GETDATE())-YEAR(NGSINH)>=22)
--14.	Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE dbo.MONHOC ADD CONSTRAINT CHECK__TINCHI CHECK(ABS(TCLT-TCTH) <= 3)  
		--PHAN III---
--1.	In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT HV.MAHV,HV.HO,HV.TEN,HV.NGSINH,L.MALOP
FROM HOCVIEN HV INNER JOIN LOP L
ON HV.MAHV=L.TRGLOP
--2.	In ra bảng điểm khi thi (mã học viên, họ tên, lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên
SELECT DISTINCT H.MAHV,H.HO,H.TEN,KQT.LANTHI,KQT.DIEM FROM HOCVIEN H INNER JOIN KETQUATHI KQT 
ON H.MAHV=KQT.MAHV
WHERE KQT.MAMH='CTRR' AND H.MALOP='K12'
ORDER BY H.TEN ASC,H.HO ASC;

--3.	In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT DISTINCT V.MAHV,V.HO,V.TEN
FROM HOCVIEN V INNER JOIN KETQUATHI KQ
ON V.MAHV = KQ.MAHV
WHERE KQ.LANTHI <= 1 AND KQ.KQUA='Dat'
--4.	In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT DISTINCT K.MAHV,K.HO,K.TEN
FROM HOCVIEN K INNER JOIN KETQUATHI M
ON K.MAHV=M.MAHV
WHERE K.MALOP='K11' AND M.MAMH='CTRR' AND M.KQUA ='Khong Dat' AND M.LANTHI =1

--5.	* Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT DISTINCT T.MAHV,T.HO,T.TEN
FROM HOCVIEN T INNER JOIN KETQUATHI Q
ON T.MAHV=Q.MAHV
WHERE T.MALOP LIKE '%K%' AND Q.MAMH='CTRR' AND Q.KQUA='Khong Dat'
	--Thuc Hanh Buoi 3--
--Phan II--
--1.	Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
UPDATE GIAOVIEN SET MUCLUONG =MUCLUONG + MUCLUONG*0.2 FROM KHOA K INNER JOIN GIAOVIEN F ON F.MAKHOA=K.MAKHOA WHERE K.TRGKHOA in ('GV01','GV02','GV03','GV04',NULL)
--2.	Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
ALTER TABLE dbo.KETQUATHI ADD DIEMTB int
UPDATE KETQUATHI SET DIEMTB=''
--3.	Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm
ALTER TABLE dbo.KETQUATHI ADD GHICHU NVARCHAR(20)
UPDATE KETQUATHI SET GHICHU ='Cam Thi' WHERE LANTHI=3 AND DIEM < 5
--4.	Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN
ALTER TABLE dbo.HOCVIEN ADD XEPLOAI NVARCHAR(20)
UPDATE HOCVIEN SET XEPLOAI=NULL
--Phan III--
--6.	Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT DISTINCT K.TENMH FROM MONHOC K, GIAOVIEN G
WHERE G.HOTEN='Tran Tam Thanh' AND K.MAKHOA=G.MAKHOA AND EXISTS (SELECT*FROM GIAOVIEN I INNER JOIN GIANGDAY D ON I.MAGV=D.MAGV WHERE D.HOCKY=1 AND D.NAM=2006 ) 
--7.	Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
SELECT DISTINCT H.MAMH,H.TENMH FROM MONHOC H INNER JOIN GIAOVIEN V ON H.MAKHOA =V.MAKHOA   WHERE EXISTS (SELECT*FROM GIAOVIEN A INNER JOIN LOP L ON A.MAGV=L.MAGVCN
WHERE L.MAGVCN IN('GV07','GV09','GV14') AND L.MALOP='K11' AND  EXISTS(SELECT*FROM LOP O INNER JOIN GIANGDAY Y ON O.MALOP=Y.MALOP WHERE Y.HOCKY=1 AND Y.NAM=2006))
--8.	Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
SELECT DISTINCT J.HO,J.TEN FROM HOCVIEN J INNER JOIN LOP K ON J.MALOP=K.MALOP WHERE K.TRGLOP IN('K1108','K1205','K1305') AND EXISTS (SELECT*FROM LOP H INNER JOIN GIAOVIEN O ON H.MAGVCN=O.MAGV WHERE O.HOTEN='Nguyen To Lan'
AND EXISTS( SELECT*FROM GIAOVIEN Y INNER JOIN  MONHOC C ON Y.MAKHOA=C.MAKHOA WHERE C.TENMH='Co so du lieu'))
--9.	In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT M.MAMH,M.TENMH FROM MONHOC M INNER JOIN DIEUKIEN K ON M.MAMH=K.MAMH WHERE K.MAMH_TRUOC='CSDL'
--10.	Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT K.MAMH,K.TENMH FROM MONHOC K INNER JOIN  DIEUKIEN D ON K.MAMH=D.MAMH WHERE D.MAMH='CTRR'
--11.	Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT DISTINCT G.HOTEN FROM GIAOVIEN G INNER JOIN GIANGDAY D ON G.MAGV=D.MAGV WHERE D.MAMH='CTRR' AND D.MALOP IN ('K11','K12')
--12.	Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
SELECT DISTINCT K.MAHV,K.HO,K.TEN FROM HOCVIEN K INNER JOIN KETQUATHI KQT ON K. MAHV =KQT.MAHV WHERE KQT.LANTHI=1 AND EXISTS(SELECT*FROM KETQUATHI Q INNER JOIN MONHOC F ON Q.MAMH=F.MAMH WHERE F.MAMH='CSDL' AND Q.KQUA='Khong Dat')
--13.	Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT DISTINCT P.MAGV,P.HOTEN FROM GIAOVIEN P WHERE NOT EXISTS(SELECT*FROM GIAOVIEN P2 INNER JOIN GIANGDAY G ON P2.MAGV=G.MAGV AND P2.MAGV=P.MAGV)
--14.	Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
SELECT DISTINCT G.MAGV,G.HOTEN FROM  GIAOVIEN G INNER JOIN KHOA K ON G.MAKHOA=K.MAKHOA WHERE K.TRGKHOA IN ('GV01','GV02','GV03','GV04',NULL) AND NOT EXISTS( SELECT*FROM GIAOVIEN G2 INNER JOIN GIANGDAY D 
ON D.MAGV=G2.MAGV AND G.MAGV=G2.MAGV)
--15.	Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT DISTINCT H.HO,H.TEN FROM HOCVIEN H INNER JOIN LOP L ON H.MALOP=L.MALOP WHERE L.MALOP='K11' AND NOT EXISTS(SELECT*FROM HOCVIEN Q INNER JOIN KETQUATHI K ON Q.MAHV=K.MAHV AND Q.MAHV=H.MAHV WHERE (K.LANTHI >= 3 AND K.KQUA='Khong Dat') 
OR (K.LANTHI=2 AND K.MAMH='CTRR' AND K.DIEM=5))
--16.	Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT K.HOTEN FROM GIAOVIEN K WHERE EXISTS(SELECT*FROM GIANGDAY D WHERE K.MAGV=D.MAGV AND  D.MAMH='CTRR' HAVING COUNT(D.MALOP)>=2)
--17.	Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT DISTINCT  H.MAHV,H.HO,H.TEN,MAX(DISTINCT K.LANTHI) LAN_THI_THU,MAX(K.DIEM) MAX_DIEM
FROM HOCVIEN H,KETQUATHI K 
WHERE K.MAHV=H.MAHV AND EXISTS (SELECT*FROM MONHOC M WHERE M.MAMH='CSDL'AND M.MAMH=K.MAMH)
GROUP BY H.MAHV,H.HO,H.TEN
ORDER BY H.MAHV ASC
--18.	Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT TOP 15 MAX(DISTINCT K.DIEM) MAX_DIEM ,H.MAHV,H.HO,H.TEN FROM HOCVIEN H,KETQUATHI K 
WHERE K.MAMH='CSDL' AND H.MAHV=K.MAHV
GROUP BY H.MAHV,H.HO,H.TEN
ORDER BY H.MAHV ASC

						--Thuc Hanh Buoi 4--
--Phan III--
--19.	Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT TOP 2 K.MAKHOA,K.TENKHOA
FROM KHOA K
ORDER BY K.NGTLAP ASC
--20.	Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(G.MAGV) Hoc_Ham_GV
FROM GIAOVIEN G
WHERE G.HOCHAM='GS' OR G.HOCHAM='PGS'
--21.	Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT COUNT(K.MAGV) HV_GV,K.HOTEN,K.MAKHOA,K.GIOITINH,K.HOCVI,K.NGSINH
FROM GIAOVIEN K
WHERE K.HOCVI='CN' OR K.HOCVI='KS' OR K.HOCVI='Ths' OR K.HOCVI='TS' OR K.HOCVI='PTS'
GROUP BY K.MAGV,K.MAKHOA,K.HOTEN,K.NGSINH,K.GIOITINH,K.HOCVI
--22.	Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT COUNT(A.KQUA) DAT,A.MAMH 
FROM KETQUATHI A
WHERE A.KQUA='DAT'
GROUP BY A.MAMH
SELECT COUNT(B.KQUA) KHONG_DAT,B.MAMH 
FROM KETQUATHI B
WHERE B.KQUA='Khong Dat'
GROUP BY B.MAMH
SELECT A.MAMH,DAT,KHONG_DAT
FROM A INNER JOIN B ON A.MAMH=B.MAMH
--23.	Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
select distinct GIAOVIEN.MAGV , HOTEN
from LOP inner join GIANGDAY on
LOP.MAGVCN =GIANGDAY.MAGV
inner join GIAOVIEN on
GIANGDAY.MAGV =GIAOVIEN.MAGV
--24.	Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
select MAHV,HO,TEN
from HOCVIEN inner join LOP on
HOCVIEN.MALOP=LOP.MALOP
where MAHV in (select TRGLOP from LOP) and
SISO in (select max (SISO) from LOP)
--25.	* Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
select MAHV,HO,TEN
from HOCVIEN
where MAHV in (select TRGLOP from LOP) and
MAHV not in (select distinct MAHV
from KETQUATHI
where KQUA=' Dat '
group by MAHV)
--26.	Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất.
select HOCVIEN . MAHV , HO , TEN , count (DIEM) [SO LAN]
from HOCVIEN inner join KETQUATHI on
HOCVIEN.MAHV=KETQUATHI.MAHV
where DIEM = 9 or DIEM =10
group by HOCVIEN.MAHV , HO , TEN
having count (DIEM) >= ALL ( select count (DIEM)
from KETQUATHI
where DIEM = 9 or DIEM =10
group by MAHV)
--27.	Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất.
select MALOP,HV.MAHV,HO,TEN , count (DIEM) [SO LAN]
from HOCVIEN HV, KETQUATHI
where DIEM between 9 and 10 and HV.MAHV=KETQUATHI.MAHV
group by MALOP,HV.MAHV,HO,TEN
having count (DIEM) >=ALL (select count (distinct DIEM)
from KETQUATHI, HOCVIEN HV2
where DIEM between 9 and 10 and
HV2.MAHV=KETQUATHI.MAHV
and HV2.MALOP=HV.MALOP
group by MALOP)
--28.	Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT DISTINCT G.MAGV,G.HOTEN,D.HOCKY,D.NAM,COUNT(DISTINCT D.MAMH) SO_MON_DAY, COUNT( D.MALOP) SO_LOP_DAY
FROM GIAOVIEN G,GIANGDAY D
GROUP BY G.MAGV,G.HOTEN,D.HOCKY,D.NAM
ORDER BY D.HOCKY,D.NAM ASC
--29.	Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT GD.HOCKY, GD.NAM, GD.MAGV, COUNT(GD.MAMH) AS SOMON
FROM GIANGDAY GD
GROUP BY GD.HOCKY, GD.NAM, GD.MAGV, GD.MAMH
HAVING COUNT(GD.MAMH) >= ALL(
SELECT COUNT(GD1.MAMH)
FROM GIANGDAY GD1
GROUP BY GD1.HOCKY, GD1.NAM, GD1.MAGV, GD1.MAMH)

--30.	Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT M.MAMH,M.TENMH
FROM MONHOC M ,KETQUATHI K
WHERE K.LANTHI =1 AND K.KQUA='Khong Dat'
GROUP BY M.MAMH,M.TENMH
--31.	Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT KETQUATHI.MAHV, H.HO , H.TEN , COUNT(KETQUATHI.MAMH)  SO_MON
FROM KETQUATHI
INNER JOIN HOCVIEN H ON KETQUATHI.MAHV=H.MAHV
WHERE LANTHI=1
GROUP BY KETQUATHI.MAHV, H.HO, H.TEN
HAVING COUNT(KETQUATHI.MAMH)= (SELECT SLDAT
FROM (SELECT MAHV, COUNT(KQUA) AS SLDAT
FROM KETQUATHI
WHERE LANTHI=1 AND KQUA='Dat'
GROUP BY MAHV) AS KQDAT
WHERE KETQUATHI.MAHV=KQDAT.MAHV)
--32.	* Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT KETQUATHI.MAHV, H.HO , H.TEN , COUNT(KETQUATHI.MAMH)  SO_MON,MAX(LANTHI) LAN_THI_SAU_CUNG 
FROM KETQUATHI INNER JOIN HOCVIEN H ON KETQUATHI.MAHV=H.MAHV
GROUP BY KETQUATHI.MAHV, H.HO, H.TEN
HAVING COUNT(KETQUATHI.MAMH)= (SELECT SLDAT
FROM (SELECT MAHV, COUNT(KQUA) AS SLDAT
FROM KETQUATHI
WHERE  KQUA='Dat' AND LANTHI IN(1,3) 
GROUP BY MAHV) AS KQDAT
WHERE KETQUATHI.MAHV=KQDAT.MAHV)
--33.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi thứ 1).
SELECT KETQUATHI.MAHV, H.HO , H.TEN , COUNT(KETQUATHI.MAMH)  SO_MON
FROM KETQUATHI
INNER JOIN HOCVIEN H ON KETQUATHI.MAHV=H.MAHV
WHERE LANTHI=1
GROUP BY KETQUATHI.MAHV, H.HO, H.TEN
HAVING COUNT(KETQUATHI.MAMH)= (SELECT SLDAT
FROM (SELECT MAHV, COUNT(KQUA) AS SLDAT
FROM KETQUATHI
WHERE LANTHI=1 AND KQUA='Dat'
GROUP BY MAHV) AS KQDAT
WHERE KETQUATHI.MAHV=KQDAT.MAHV)
--34.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi sau cùng).
SELECT KETQUATHI.MAHV, H.HO , H.TEN , COUNT(KETQUATHI.MAMH)  SO_MON,MAX(LANTHI) LAN_THI_SAU_CUNG 
FROM KETQUATHI INNER JOIN HOCVIEN H ON KETQUATHI.MAHV=H.MAHV
GROUP BY KETQUATHI.MAHV, H.HO, H.TEN
HAVING COUNT(KETQUATHI.MAMH)= (SELECT SLDAT
FROM (SELECT MAHV, COUNT(KQUA) AS SLDAT
FROM KETQUATHI
WHERE  KQUA='Dat' AND LANTHI IN(1,3) 
GROUP BY MAHV) AS KQDAT
WHERE KETQUATHI.MAHV=KQDAT.MAHV)
--35.	** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
SELECT MAMH,MAX(DIEM) MAX_DIEM_THI,MAX(LANTHI) LAN_THI_SAU_CUNG 
FROM KETQUATHI K  GROUP BY MAMH
SELECT DISTINCT MAHV,HO,TEN 
FROM HOCVIEN H  
WHERE EXISTS (SELECT MAMH,MAHV,MAX(DIEM) MAX_DIEM_THI,MAX(LANTHI) LAN_THI_SAU_CUNG 
FROM KETQUATHI K  WHERE K.MAHV=H.MAHV  GROUP BY MAMH,MAHV HAVING MAX(DIEM)>=9.5)
 

					--Thuc Hanh Buoi 5--
--9.	Lớp trưởng của một lớp phải là học viên của lớp đó.
CREATE TRIGGER KT_Hoc_Vien ON HOCVIEN
FOR INSERT 
AS 
BEGIN
	DECLARE @MaHV char(4),@MaLop char(3)
	SELECT @MaHV=MAHV,@MaLop=MALOP
	FROM inserted
	SELECT @MaLop=MALOP
	FROM LOP
	WHERE @MaHV IN (select TRGLOP from LOP) AND LOP.MALOP = @MaLop
END
--10.	Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
CREATE TRIGGER hoc_vi_GV ON GIAOVIEN 
FOR INSERT 
AS
BEGIN 
	DECLARE @HVGV varchar(10), @TruongKhoa char(4), @MaKhoa char(4)
	SELECT @HVGV=HOCVI
	FROM inserted
	SELECT @TruongKhoa=TRGKHOA,@MaKhoa=MAKHOA
	FROM KHOA
	WHERE @MaKhoa=MAKHOA
	IF(@HVGV='TS' OR @HVGV='PTS')
	BEGIN
		print 'XAC NHAN THANH CONG'
	END
	ELSE
	BEGIN
		RAISERROR ('LOI:GIAO VIEN KHONG THUOC HOC VI TS HOAC PTS',16,1)
		ROLLBACK TRANSACTION 
	END
END
--15.	Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.
CREATE TRIGGER Check_MH ON GIANGDAY
FOR INSERT
AS
BEGIN
	DECLARE @Ngay_Thi smalldatetime, @Ngay_KT smalldatetime,@MAMH CHAR(4)
	SELECT @Ngay_KT=DENNGAY,@MAMH=MAMH
	FROM inserted 
	SELECT @Ngay_Thi=NGTHI
	FROM KETQUATHI
	WHERE @MAMH=KETQUATHI.MAMH
	IF(@Ngay_Thi <= @Ngay_KT)
	BEGIN 
		RAISERROR ('LOI !!!',16,1)
		ROLLBACK TRANSACTION 
	END
END
--16.	Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
CREATE TRIGGER hoc_ky ON GIANGDAY
FOR INSERT 
AS
BEGIN
	DECLARE @MaMH char(4),@MaLop char(3),@HK TINYINT,@Nam smallint
	SELECT @MaLop=MALOP,@MaMH=MAMH,@HK=HOCKY,@Nam=NAM
	FROM inserted
	GROUP BY MALOP,MAMH ,HOCKY,NAM
	HAVING COUNT(@MaMH) <=3
	if(COUNT(@MaMH) >3)
		Begin 
			RAISERROR ('LOI:KHONG THUC THI DUOC',16,1)
			ROLLBACK TRANSACTION
		END
END

--17.	Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
CREATE TRIGGER SI_SO_LOP ON LOP
FOR INSERT 
AS
BEGIN
	DECLARE @SiSo Tinyint,@MaLop char(3),@TL CHAR(5),@MaHV char(4)
	SELECT @SiSo=SISO , @MaLop =MALOP , @TL=TRGLOP
	FROM inserted
	SELECT @MaHV=MAHV
	FROM HOCVIEN
	WHERE HOCVIEN.MALOP=@MaLop 
	GROUP BY MALOP,MAHV
	HAVING COUNT(MAHV) = @SiSo
	IF(COUNT(@MaHV) != @SiSo)
		BEGIN
			RAISERROR ('LOI: GIA TRI KHONG HOP LE !!',16,1)
			ROLLBACK TRANSACTION
		END
END
--18.	Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”).
Create Trigger Check_DK ON DIEUKIEN
FOR INSERT 
AS
BEGIN
	DECLARE @MaMH char(4),@MaMH_Truoc char(4) 
	SELECT @MaMH = MAMH,@MaMH_Truoc=MAMH_TRUOC
	FROM inserted
	SELECT @MaMH=D1.MAMH ,@MaMH_Truoc=D1.MAMH_TRUOC
	FROM DIEUKIEN D1
	WHERE (D1.MAMH != @MaMH) AND (D1.MAMH_TRUOC !=@MaMH_Truoc) AND (D1.MAMH !=@MaMH_Truoc) AND (D1.MAMH_TRUOC !=@MaMH)
	IF((@MaMH=@MaMH) AND (@MaMH=@MaMH_Truoc) AND (@MaMH_Truoc=@MaMH))
		BEGIN
			RAISERROR ('LOI !!',16,1)
			ROLLBACK TRANSACTION 
		END
END
--19.	Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau.
CREATE TRIGGER KT_GV ON GIAOVIEN
FOR INSERT
AS
BEGIN
	DECLARE @HV varchar(10), @HH varchar(10), @HS numeric(4,2),@ML money,@HV1 varchar(10), @HH1 varchar(10), @HS1 numeric(4,2),@ML1 money
	SELECT @HV=HOCVI,@HH=HOCHAM,@HS=HESO,@ML=MUCLUONG
	FROM inserted
	SELECT @HV1=HOCVI,@HH1=HOCHAM,@HS1=HESO,@ML1=MUCLUONG
	FROM GIAOVIEN G1
	IF(@HV1 !=@HV AND @HH !=@HH1 AND @HS != @HS1) 
		BEGIN 
			RAISERROR ('GIAO VIEN VIEN KHONG CUNG MUC LUONG',16,1)
			ROLLBACK TRANSACTION
		END
	ELSE 
		BEGIN 
			UPDATE GIAOVIEN SET @ML = @ML1 
		END
END
--20.	Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5.
create trigger Thi_Diem ON KETQUATHI
FOR INSERT 
AS
BEGIN
	DECLARE @LT TINYINT, @Diem numeric(4,2),@MaHV char(4),@MaMH varchar(10)
	SELECT @LT=LANTHI,@Diem=DIEM,@MaMH=MAMH
	FROM inserted
	SELECT @MaHV=MAHV
	FROM HOCVIEN
	WHERE @MaHV=MAHV AND @LT >1 AND @Diem < 5
	if(@LT <=1 AND @Diem >= 5)
		BEGIN
			RAISERROR ('LOI: THI SINH KHONG DUOC THI LAI VI DA QUA MON',16,1)
			ROLLBACK TRANSACTION
		END
END
--21.	Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học).
create trigger N_THI ON KETQUATHI
FOR INSERT 
AS
BEGIN
	DECLARE @NgayThi smalldatetime ,@LanThi tinyint,@MaHV char(4),@MaMH varchar(10),@NgayThi2 smalldatetime ,@LanThi2 tinyint,@MaHV2 char(4),@MaMH2 varchar(10)
	SELECT @NgayThi = NGTHI,@LanThi=LANTHI,@MaHV=MAHV,@MaMH=MAMH
	FROM inserted
	SELECT @NgayThi2 =K1.NGTHI,@LanThi2=K1.LANTHI,@MaHV2=K1.MAHV,@MaMH2=K1.MAMH
	FROM KETQUATHI K1
	WHERE @LanThi >=1 AND @LanThi2 > 1 AND @MaHV=@MaHV2 AND @MaMH=@MaMH2 AND @LanThi < @LanThi2 AND @NgayThi <@NgayThi2
	IF(@LanThi2 < @LanThi AND @NgayThi > @NgayThi2 )
		BEGIN
			RAISERROR('LOI:LENH SAI KHONG DUOC THUC HIEN',16,1)
			ROLLBACK TRANSACTION
		END
	ELSE
		UPDATE KETQUATHI SET  @LanThi2 = @LanThi + 1 
		UPDATE KETQUATHI SET @NgayThi2=@NgayThi +1
END
--22.	Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau khi học xong những môn học phải học trước mới được học những môn liền sau).
CREATE TRIGGER SORT_TKB  ON GIANGDAY
FOR INSERT 
AS
BEGIN
	DECLARE @MaMH varchar(10),@MaMH_Truoc varchar(10),@MaGV char(4),@HK tinyint, @Nam smallint,@TuNgay smalldatetime,@DenNgay smalldatetime
	SELECT @MaMH=MAMH,@MaGV=MAGV,@HK=HOCKY,@Nam=NAM,@TuNgay=TUNGAY,@DenNgay=DENNGAY
	FROM inserted
	SELECT @MaMH=MAMH,@MaMH_Truoc=MAMH_TRUOC
	FROM DIEUKIEN
	WHERE @MaMH=DIEUKIEN.MAMH
	IF(@MaMH_Truoc > @MaMH )
		BEGIN
			PRINT 'TRUE !'
		END
	ELSE 
		BEGIN
			RAISERROR ('LOI:KHONG THUC THI VI KHONG DUNG DIEU KIEN',16,1)
			ROLLBACK TRANSACTION
		END
END
--23.	Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
CREATE TRIGGER PC_GD ON GIANGDAY
FOR INSERT 
AS 
BEGIN
	DECLARE @MaMH varchar(10), @MaGV char(4),@MaKhoa varchar(4)
	SELECT @MaMH =MAMH,@MaGV=@MaGV
	FROM inserted
	SELECT @MaKhoa=MAKHOA
	FROM KHOA
	WHERE EXISTS (SELECT MAGV FROM GIAOVIEN WHERE EXISTS(SELECT MAKHOA FROM MONHOC WHERE MONHOC.MAKHOA=KHOA.MAKHOA )) 
END