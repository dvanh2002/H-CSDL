--Tao co so du lieu cho he thong
CREATE TABLE KHACHHANG
(
MaKH VARCHAR2(20) PRIMARY KEY,
TenKH VARCHAR2(20),
GioiTinh VARCHAR2(3),
CMND CHAR(9),
SDT VARCHAR2(10),
CONSTRAINT "KHACHHANG_CHK_GIOITINH"CHECK(GioiTinh='Nam'or GioiTinh='Nu')
);
CREATE TABLE DICHVU
(
MaDV VARCHAR2(20) PRIMARY KEY,
TenDV VARCHAR2(20) NOT NULL,
DonGia FLOAT
);
CREATE TABLE LOAIPHONG
(
MaLP VARCHAR2(20) PRIMARY KEY,
LP VARCHAR2(20) NOT NULL,
GiaPhong FLOAT
);
CREATE TABLE PHONG
(
MaPhong VARCHAR2(20) PRIMARY KEY,
MaLP VARCHAR2(20) NOT NULL,
TinhTrang NUMBER,
CONSTRAINT PHONG_FK FOREIGN KEY (MaLP) REFERENCES LOAIPHONG(MaLP),
CONSTRAINT PHONG_CHK1 CHECK(TinhTrang=1 or TinhTrang=0)
);
CREATE TABLE PHIEUTHUEPHONG
(
MaKH VARCHAR2(20) NOT NULL,
MaSoPhieu VARCHAR2(20) PRIMARY KEY,
MaPhong VARCHAR2(20) NOT NULL,
NgayThue DATE,
NgayTra DATE,
TrangThai NUMBER,
CONSTRAINT PHIEUTHUEPHONG_FK FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong),
CONSTRAINT PHIEUTHUEPHONG_KH FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
CONSTRAINT "PHIEUTHUEPHONG_CHK_TTRANGTHAI" CHECK(TrangThai=0 or TrangThai=1)
);
CREATE TABLE CTDICHVU
(
MaSoPhieu VARCHAR2(20) NOT NULL,
MaDV VARCHAR2(20) NOT NULL,
NgaySD DATE,
SoLuong NUMBER,
CONSTRAINT CTDICHVU_PK PRIMARY KEY (MaSoPhieu, MaDV),
CONSTRAINT CTDICHVU_FK2 FOREIGN KEY (MaSoPhieu) REFERENCES PHIEUTHUEPHONG(MaSoPhieu),
CONSTRAINT CTDICHVU_FK3 FOREIGN KEY (MaDV) REFERENCES DICHVU(MaDV)
);
CREATE TABLE HOADON
(
MaHD VARCHAR2(20) PRIMARY KEY,
MaSoPhieu VARCHAR2(20) NOT NULL,
NgayLap DATE,
TienPhong FLOAT,
TienDV FLOAT,
CONSTRAINT HOADON_FK FOREIGN KEY (MaSoPhieu) REFERENCES PHIEUTHUEPHONG(MaSoPhieu)
);

--them du lieu vao bang
INSERT ALL 
INTO KHACHHANG VALUES ('1','DANG VIET ANH','Nam','184571528','0354789415')
INTO KHACHHANG VALUES ('2','NGUYEN DINH ANH','Nam','184571284','0354787415')
INTO KHACHHANG VALUES ('3','NGUYEN THI VAN ANH','Nu','184415284','0354789815')
INTO KHACHHANG VALUES ('4','TA NGOC CUONG','Nam','184571289','0954789415')
INTO KHACHHANG VALUES ('5','NGUYEN DUC CHUNG','Nam','184715284','0954787415')
SELECT * FROM DUAL;

INSERT ALL 
INTO DICHVU VALUES ('DV01','GIAT LA QUAN AO','100000')
INTO DICHVU VALUES ('DV02','SPA','500000')
INTO DICHVU VALUES ('DV03','DON PHONG','150000')
INTO DICHVU VALUES ('DV04','KARAOKE','3500000')
INTO DICHVU VALUES ('DV05','BE BOI','100000')
SELECT * FROM DUAL;

INSERT ALL 
INTO LOAIPHONG VALUES ('VIP1','THUONG','1000000')
INTO LOAIPHONG VALUES ('VIP2','TOT','1500000')
INTO LOAIPHONG VALUES ('VIP3','CAOCAP','3000000')
SELECT * FROM DUAL;

INSERT ALL 
INTO PHONG VALUES ('P101','VIP1','0')
INTO PHONG VALUES ('P102','VIP2','0')
INTO PHONG VALUES ('P103','VIP2','0')
INTO PHONG VALUES ('P104','VIP3','0')
INTO PHONG VALUES ('P105','VIP1','0')
SELECT * FROM DUAL;

INSERT ALL 
INTO PHIEUTHUEPHONG VALUES ('1','MSP001','P101',to_date('01-8-2022','DD,MM,YYYY'),to_date('05-8-2022','DD,MM,YYYY'),'1')
INTO PHIEUTHUEPHONG VALUES ('2','MSP002','P201',to_date('01-8-2022','DD,MM,YYYY'),to_date('03-8-2022','DD,MM,YYYY'),'1')
INTO PHIEUTHUEPHONG VALUES ('3','MSP003','P205',to_date('02-8-2022','DD,MM,YYYY'),to_date('04-8-2022','DD,MM,YYYY'),'1')
INTO PHIEUTHUEPHONG VALUES ('4','MSP004','P202',to_date('02-8-2022','DD,MM,YYYY'),to_date('03-8-2022','DD,MM,YYYY'),'1')
INTO PHIEUTHUEPHONG VALUES ('5','MSP005','P108',to_date('03-8-2022','DD,MM,YYYY'),to_date('05-8-2022','DD,MM,YYYY'),'1')
SELECT * FROM DUAL;

INSERT ALL 
INTO CTDICHVU VALUES ('MSP001','DV01',to_date('02-8-2022','DD-MM-YYYY'),'1')
INTO CTDICHVU VALUES ('MSP002','DV02',to_date('03-8-2022','DD-MM-YYYY'),'1')
INTO CTDICHVU VALUES ('MSP003','DV03',to_date('02-8-2022','DD-MM-YYYY'),'1')
INTO CTDICHVU VALUES ('MSP004','DV04',to_date('02-8-2022','DD-MM-YYYY'),'1')
INTO CTDICHVU VALUES ('MSP005','DV05',to_date('04-8-2022','DD-MM-YYYY'),'1')
SELECT * FROM DUAL;

INSERT ALL 
INTO HOADON VALUES ('HD01','MSP001',to_date('05-08-2022', 'DD-MM-YYYY'),'4000000','100000')
INTO HOADON VALUES ('HD02','MSP002',to_date('03-8-2022', 'DD-MM-YYYY'),'3000000','5000000')
INTO HOADON VALUES ('HD03','MSP003',to_date('04-8-2022', 'DD-MM-YYYY'),'3000000','150000')
INTO HOADON VALUES ('HD04','MSP004',to_date('03-8-2022', 'DD-MM-YYYY'),'3000000','3500000')
INTO HOADON VALUES ('HD05','MSP005',to_date('05-8-2022', 'DD-MM-YYYY'),'2000000','100000')
SELECT * FROM DUAL;

--chen du lieu vao bang
CREATE PROCEDURE Chen_du_lieu_KHACHHANG
(MaKH VARCHAR2, TenKH VARCHAR2, GioiTinh VARCHAR2, CMND CHAR, SDT VARCHAR2)
IS
BEGIN
INSERT INTO KHACHHANG VALUES (MaKH, TenKH, GioiTinh, CMND, SDT);
END Chen_du_lieu_KHACHHANG;
EXEC Chen_du_lieu_KHACHHANG('6','LE VAN LAI','Nam','184571578','0354779415');
EXEC Chen_du_lieu_KHACHHANG('7','NGUYEN THI HANG','Nu','184572578','0355779415');
EXEC Chen_du_lieu_KHACHHANG('8','LE THI VAN ANH','Nu','184451578','0356779415');
EXEC Chen_du_lieu_KHACHHANG('9','NGUYEN VAN ANH','Nam','184579878','0352779415');
EXEC Chen_du_lieu_KHACHHANG('10','QUACH THANH VAN','Nam','184571578','0394779415');
EXEC Chen_du_lieu_KHACHHANG('11','LAI VAN HUNG','Nam','185671578','0344779415');
EXEC Chen_du_lieu_KHACHHANG('12','DINH CONG NAM','Nam','184534578','0374779415');
EXEC Chen_du_lieu_KHACHHANG('13','LE THI TUYET NHI','Nu','179571578','0334779415');
EXEC Chen_du_lieu_KHACHHANG('14','VU THI NGOC MAI','Nu','184576678','0394279415');
EXEC Chen_du_lieu_KHACHHANG('15','NGUYEN VAN AN','Nam','184503578','0384779415');

CREATE PROCEDURE Chen_du_lieu_DICHVU
(MaDV VARCHAR2, TenDV VARCHAR2, DonGia FLOAT)
IS
BEGIN
INSERT INTO DICHVU VALUES (MaDV, TenDV, DonGia);
END Chen_du_lieu_DICHVU;
EXEC Chen_du_lieu_DICHVU('DV06','PHONG GYM','150000');
EXEC Chen_du_lieu_DICHVU('DV07','SAN BONG DA','650000');
EXEC Chen_du_lieu_DICHVU('DV08','THEU XE MAY','500000');
EXEC Chen_du_lieu_DICHVU('DV09','THUE OTO','1500000');

CREATE PROCEDURE Chen_du_lieu_PHONG
(MaPhong VARCHAR2, MaLP VARCHAR2, TinhTrang NUMBER)
IS
BEGIN
INSERT INTO PHONG VALUES (MaPhong, MaLP, TinhTrang);
END Chen_du_lieu_PHONG;
EXEC Chen_du_lieu_PHONG('P106','VIP1','0');
EXEC Chen_du_lieu_PHONG('P107','VIP1','0');
EXEC Chen_du_lieu_PHONG('P108','VIP3','0');
EXEC Chen_du_lieu_PHONG('P109','VIP1','0');
EXEC Chen_du_lieu_PHONG('P201','VIP1','0');
EXEC Chen_du_lieu_PHONG('P202','VIP2','0');
EXEC Chen_du_lieu_PHONG('P203','VIP1','0');
EXEC Chen_du_lieu_PHONG('P204','VIP1','0');
EXEC Chen_du_lieu_PHONG('P205','VIP2','0');
EXEC Chen_du_lieu_PHONG('P206','VIP1','0');
EXEC Chen_du_lieu_PHONG('P207','VIP3','0');
EXEC Chen_du_lieu_PHONG('P208','VIP1','0');
EXEC Chen_du_lieu_PHONG('P209','VIP1','0');
EXEC Chen_du_lieu_PHONG('P301','VIP1','0');
EXEC Chen_du_lieu_PHONG('P302','VIP1','0');
EXEC Chen_du_lieu_PHONG('P303','VIP1','0');
EXEC Chen_du_lieu_PHONG('P304','VIP2','0');
EXEC Chen_du_lieu_PHONG('P305','VIP2','0');
EXEC Chen_du_lieu_PHONG('P306','VIP3','0');
EXEC Chen_du_lieu_PHONG('P307','VIP3','0');
EXEC Chen_du_lieu_PHONG('P308','VIP2','0');
EXEC Chen_du_lieu_PHONG('P309','VIP2','0');

CREATE PROCEDURE Chen_du_lieu_PHIEUTHUEPHONG
(MaKH VARCHAR2, MaSoPhieu VARCHAR2, MaPhong VARCHAR2, NgayThue DATE, NgayTra DATE, TrangThai NUMBER)
IS
BEGIN
INSERT INTO PHIEUTHUEPHONG VALUES (MaKH, MaSoPhieu, MaPhong, NgayThue, NgayTra, TrangThai);
END Chen_du_lieu_PHIEUTHUEPHONG;
EXEC Chen_du_lieu_PHIEUTHUEPHONG('6','MSP006','P102',to_date('03-8-2022','DD,MM,YYYY'),to_date('05-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('7','MSP007','P103',to_date('03-8-2022','DD,MM,YYYY'),to_date('04-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('8','MSP008','P203',to_date('03-8-2022','DD,MM,YYYY'),to_date('05-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('9','MSP009','P204',to_date('03-8-2022','DD,MM,YYYY'),to_date('04-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('10','MSP010','P301',to_date('03-8-2022','DD,MM,YYYY'),to_date('05-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('11','MSP011','P309',to_date('03-8-2022','DD,MM,YYYY'),to_date('06-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('12','MSP012','P208',to_date('04-8-2022','DD,MM,YYYY'),to_date('05-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('13','MSP013','P301',to_date('04-8-2022','DD,MM,YYYY'),to_date('06-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('14','MSP014','P302',to_date('04-8-2022','DD,MM,YYYY'),to_date('06-8-2022','DD,MM,YYYY'),'1');
EXEC Chen_du_lieu_PHIEUTHUEPHONG('15','MSP015','P102',to_date('04-8-2022','DD,MM,YYYY'),to_date('07-8-2022','DD,MM,YYYY'),'1');

CREATE PROCEDURE Chen_du_lieu_CTDICHVU
(MaSoPhieu VARCHAR2, MaDV VARCHAR2, NgaySD DATE, SoLuong NUMBER)
IS
BEGIN
INSERT INTO CTDICHVU VALUES (MaSoPhieu, MaDV, NgaySD, SoLuong);
END Chen_du_lieu_CTDICHVU;
EXEC Chen_du_lieu_CTDICHVU('MSP006','DV09',to_date('04-8-2022','DD-MM-YYYY'),'1');
EXEC Chen_du_lieu_CTDICHVU('MSP007','DV08',to_date('03-8-2022','DD-MM-YYYY'),'2');
EXEC Chen_du_lieu_CTDICHVU('MSP008','DV01',to_date('04-8-2022','DD-MM-YYYY'),'1');
EXEC Chen_du_lieu_CTDICHVU('MSP009','DV03',to_date('03-8-2022','DD-MM-YYYY'),'2');
EXEC Chen_du_lieu_CTDICHVU('MSP010','DV05',to_date('04-8-2022','DD-MM-YYYY'),'1');
EXEC Chen_du_lieu_CTDICHVU('MSP011','DV02',to_date('05-8-2022','DD-MM-YYYY'),'2');
EXEC Chen_du_lieu_CTDICHVU('MSP012','DV02',to_date('04-8-2022','DD-MM-YYYY'),'1');
EXEC Chen_du_lieu_CTDICHVU('MSP013','DV05',to_date('05-8-2022','DD-MM-YYYY'),'2');
EXEC Chen_du_lieu_CTDICHVU('MSP014','DV08',to_date('05-8-2022','DD-MM-YYYY'),'1');
EXEC Chen_du_lieu_CTDICHVU('MSP015','DV06',to_date('06-8-2022','DD-MM-YYYY'),'2');

CREATE PROCEDURE Chen_du_lieu_HOADON
(MaHD VARCHAR2, MaSoPhieu VARCHAR2, NgayLap DATE, TienPhong FLOAT, TienDV FLOAT)
IS
BEGIN
INSERT INTO HOADON VALUES (MaHD, MaSoPhieu, NgayLap, TienPhong, TienDV);
END Chen_du_lieu_HOADON;
EXEC Chen_du_lieu_HOADON('HD06','MSP006',to_date('05-08-2022', 'DD-MM-YYYY'),'2000000','1500000');
EXEC Chen_du_lieu_HOADON('HD07','MSP007',to_date('04-08-2022', 'DD-MM-YYYY'),'1000000','1000000');
EXEC Chen_du_lieu_HOADON('HD08','MSP008',to_date('05-08-2022', 'DD-MM-YYYY'),'2000000','100000');
EXEC Chen_du_lieu_HOADON('HD09','MSP009',to_date('04-08-2022', 'DD-MM-YYYY'),'1000000','300000');
EXEC Chen_du_lieu_HOADON('HD10','MSP010',to_date('05-08-2022', 'DD-MM-YYYY'),'2000000','100000');
EXEC Chen_du_lieu_HOADON('HD11','MSP011',to_date('06-08-2022', 'DD-MM-YYYY'),'4500000','1000000');
EXEC Chen_du_lieu_HOADON('HD12','MSP012',to_date('05-08-2022', 'DD-MM-YYYY'),'3000000','500000');
EXEC Chen_du_lieu_HOADON('HD13','MSP013',to_date('06-08-2022', 'DD-MM-YYYY'),'1000000','200000');
EXEC Chen_du_lieu_HOADON('HD14','MSP014',to_date('06-08-2022', 'DD-MM-YYYY'),'20000000','500000');
EXEC Chen_du_lieu_HOADON('HD15','MSP015',to_date('07-08-2022', 'DD-MM-YYYY'),'3000000','300000');

-----------------------------------
--delete bang
DROP TABLE KHACHHANG
DROP TABLE HOADON
DROP TABLE DICHVU
DROP TABLE LOAIPHONG
DROP TABLE PHIEUTHUEPHONG
DROP TABLE PHONG
DROP TABLE CTDICHVU
-----------------------------------
--xoa du lieu khoi bang
TRUNCATE TABLE CTDICHVU
TRUNCATE TABLE DICHVU
TRUNCATE TABLE HOADON
TRUNCATE TABLE PHIEUTHUEPHONG
TRUNCATE TABLE PHONG
TRUNCATE TABLE LOAIPHONG
TRUNCATE TABLE KHACHHANG
----------------------------------
SELECT * FROM KHACHHANG
SELECT * FROM DICHVU
SELECT * FROM LOAIPHONG
SELECT * FROM PHONG
SELECT * FROM PHIEUTHUEPHONG
SELECT * FROM CTDICHVU
SELECT * FROM HOADON
---------------------------------
---1. tim kiem thong tin khach hang
SELECT KHACHHANG.MaKH, KHACHHANG.TenKH, KHACHHANG.GioiTinh, khachhang.cmnd, khachhang.sdt, 
PHIEUTHUEPHONG.MaPhong, phieuthuephong.ngaythue, phieuthuephong.ngaytra
FROM KHACHHANG, PHIEUTHUEPHONG
WHERE khachhang.tenkh = 'VU THI NGOC MAI'
AND khachhang.makh = phieuthuephong.makh;
---tao View chi tiet thue phong
CREATE VIEW CHITIET_THUEPHONG_view(TenKH, CMND, MaPhong, MaSoPhieu, NgayThue, GiaPhong)
AS
SELECT khachhang.tenkh, khachhang.cmnd, phieuthuephong.maphong, phieuthuephong.masophieu, phieuthuephong.ngaythue, loaiphong.giaphong
FROM KHACHHANG, PHIEUTHUEPHONG, PHONG, LOAIPHONG
WHERE khachhang.makh = phieuthuephong.makh
    AND phieuthuephong.maphong = phong.maphong
    AND phong.malp = loaiphong.malp;
---tao view chi tiet d?ch vu
CREATE VIEW CHITIET_DICHVU_PHONG_view(MaPhong, MaSoPhieu, TenDV, NgaySD, SoLuong, DonGia)
AS 
SELECT  phieuthuephong.maphong, phieuthuephong.masophieu, dichvu.tendv, ctdichvu.ngaysd, ctdichvu.soluong, dichvu.dongia
FROM PHIEUTHUEPHONG, DICHVU, CTDICHVU
WHERE ctdichvu.masophieu = phieuthuephong.masophieu
    AND dichvu.madv = ctdichvu.madv;
---dua ra cac loai phong la vip1
SELECT * FROM PHONG 
where malp = 'VIP1'
---dua ra thong tin va den so khach hang la nu
select * from khachhang where GIOITINH = 'Nu';
SELECT COUNT(GioiTinh) FROM KHACHHANG WHERE GioiTinh = 'Nu';
---tinh tong tien phong thu duoc cua khach san
SELECT SUM(TienPhong) FROM HOADON;

------------------------------
DROP VIEW CHITIET_THUEPHONG_view;
SELECT*FROM CHITIET_THUEPHONG_view;
SELECT*FROM CHITIET_DICHVU_PHONG_view;
