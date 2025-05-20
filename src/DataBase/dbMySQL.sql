-- DROP table NguoiDung;
-- Tao bang NguoiDung
CREATE TABLE NguoiDung(
    ID_ND INT,
    Email VARCHAR(50) NOT NULL,
    Matkhau VARCHAR(20) NOT NULL,
    VerifyCode VARCHAR(10) DEFAULT NULL,
    Trangthai VARCHAR(10) DEFAULT '',
    Vaitro VARCHAR(20)
);

-- Them rang buoc
ALTER TABLE NguoiDung
    ADD CONSTRAINT ND_Vaitro_Ten CHECK (Vaitro IN ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly'));

-- Them khoa chinh
ALTER TABLE NguoiDung
    ADD PRIMARY KEY (ID_ND);
    
-- Tao bang NhanVien
-- drop table NhanVien;
CREATE TABLE NhanVien(
    ID_NV INT,
    TenNV VARCHAR(50) NOT NULL,
    NgayVL DATE NOT NULL,
    SDT VARCHAR(50) NOT NULL,
    Chucvu VARCHAR(50),
    ID_ND INT DEFAULT NULL,
    ID_NQL INT,
    Tinhtrang VARCHAR(20)
);

-- Them rang buoc cho bang NhanVien
ALTER TABLE NhanVien
    ADD CONSTRAINT NV_Chucvu_Thuoc CHECK (Chucvu IN ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly'));

ALTER TABLE NhanVien
    ADD CONSTRAINT NV_Tinhtrang_Thuoc CHECK (Tinhtrang IN ('Dang lam viec','Da nghi viec'));

-- Them khoa chinh
ALTER TABLE NhanVien
    ADD PRIMARY KEY (ID_NV);

-- Them khoa ngoai
ALTER TABLE NhanVien
    ADD CONSTRAINT NV_fk_idND FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND);

ALTER TABLE NhanVien
    ADD CONSTRAINT NV_fk_idNQL FOREIGN KEY (ID_NQL) REFERENCES NhanVien(ID_NV);
 
-- Tao bang KhachHang
-- drop table KhachHang;
CREATE TABLE KhachHang(
    ID_KH INT,
    TenKH VARCHAR(50) NOT NULL, 
    Ngaythamgia DATE NOT NULL, 
    Doanhso BIGINT DEFAULT 0, 
    Diemtichluy SMALLINT DEFAULT 0,
    ID_ND INT NOT NULL
);

-- Them khoa chinh
ALTER TABLE KhachHang
    ADD PRIMARY KEY (ID_KH);
    
-- Them khoa ngoai
ALTER TABLE KhachHang
    ADD CONSTRAINT KH_fk_idND FOREIGN KEY (ID_ND) REFERENCES NguoiDung(ID_ND);

-- Tao bang MonAn
-- drop table MonAn;
CREATE TABLE MonAn(
    ID_MonAn INT,
    TenMon VARCHAR(50) NOT NULL, 
    DonGia INT NOT NULL,
    Loai VARCHAR(50),
    TrangThai VARCHAR(30)
);

-- Them rang buoc
ALTER TABLE MonAn
    ADD CONSTRAINT MA_Loai_Ten CHECK (Loai IN ('Aries','Taurus','Gemini','Cancer','Leo','Virgo',
                                             'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'));

ALTER TABLE MonAn
    ADD CONSTRAINT MA_TrangThai_Thuoc CHECK (TrangThai IN('Dang kinh doanh','Ngung kinh doanh'));

-- Them khoa chinh
ALTER TABLE MonAn
    ADD PRIMARY KEY (ID_MonAn);

-- Tao bang Ban
-- drop table Ban;
CREATE TABLE Ban(
    ID_Ban INT,
    TenBan VARCHAR(50) NOT NULL, 
    Vitri VARCHAR(50) NOT NULL, 
    Trangthai VARCHAR(50)
);

-- Them rang buoc
ALTER TABLE Ban
    ADD CONSTRAINT Ban_Trangthai_Ten CHECK (Trangthai IN ('Con trong','Dang dung bua','Da dat truoc'));

-- Them khoa chinh
ALTER TABLE Ban
    ADD PRIMARY KEY (ID_Ban);

-- Tao bang Voucher
-- drop table Voucher;
CREATE TABLE Voucher(
    Code_Voucher VARCHAR(10) NOT NULL,
    Mota VARCHAR(50) NOT NULL,
    Phantram SMALLINT,
    LoaiMA VARCHAR(50),
    SoLuong SMALLINT,
    Diem INT
);

-- Them rang buoc
ALTER TABLE Voucher
    ADD CONSTRAINT V_Phantram_NNULL CHECK (Phantram > 0 AND Phantram <= 100);

ALTER TABLE Voucher
    ADD CONSTRAINT V_LoaiMA_Thuoc CHECK (LoaiMA IN ('All','Aries','Taurus','Gemini','Cancer','Leo','Virgo',
                                                 'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'));

-- Them khoa chinh
ALTER TABLE Voucher
    ADD PRIMARY KEY (Code_Voucher);
    
-- Tao bang HoaDon
-- drop table HoaDon;
CREATE TABLE HoaDon(
    ID_HoaDon INT,
    ID_KH INT,
    ID_Ban INT,
    NgayHD DATE NOT NULL,
    TienMonAn INT,
    Code_Voucher VARCHAR(10),
    TienGiam INT,
    Tongtien BIGINT,
    Trangthai VARCHAR(50)
);

-- Them rang buoc
ALTER TABLE HoaDon
    ADD CONSTRAINT HD_TrangThai CHECK (Trangthai IN ('Chua thanh toan','Da thanh toan'));

-- Them khoa chinh
ALTER TABLE HoaDon
    ADD PRIMARY KEY (ID_HoaDon);

-- Them khoa ngoai
ALTER TABLE HoaDon
    ADD CONSTRAINT HD_fk_idKH FOREIGN KEY (ID_KH) REFERENCES KhachHang(ID_KH);

ALTER TABLE HoaDon
    ADD CONSTRAINT HD_fk_idBan FOREIGN KEY (ID_Ban) REFERENCES Ban(ID_Ban);

-- Tao bang CTHD
-- drop table CTHD;
CREATE TABLE CTHD(
    ID_HoaDon INT,
    ID_MonAn INT,
    SoLuong SMALLINT NOT NULL,
    Thanhtien BIGINT
);

-- Them khoa chinh
ALTER TABLE CTHD
    ADD PRIMARY KEY (ID_HoaDon, ID_MonAn);

-- Them khoa ngoai
ALTER TABLE CTHD
    ADD CONSTRAINT CTHD_fk_idHD FOREIGN KEY (ID_HoaDon) REFERENCES HoaDon(ID_HoaDon);

ALTER TABLE CTHD
    ADD CONSTRAINT CTHD_fk_idMonAn FOREIGN KEY (ID_MonAn) REFERENCES MonAn(ID_MonAn);

-- Tao bang Nguyenlieu
-- drop table NguyenLieu;
CREATE TABLE NguyenLieu(
    ID_NL INT,
    TenNL VARCHAR(50) NOT NULL, 
    Dongia INT NOT NULL, 
    Donvitinh VARCHAR(50)
);

-- Them rang buoc
ALTER TABLE NguyenLieu
    ADD CONSTRAINT NL_DVT_Thuoc CHECK (Donvitinh IN ('g','kg','ml','l'));

-- Them khoa chinh
ALTER TABLE NguyenLieu
    ADD PRIMARY KEY (ID_NL);

-- Tao bang Kho
-- drop table Kho;
CREATE TABLE Kho(
    ID_NL INT,
    SLTon SMALLINT DEFAULT 0
);

-- Them khoa chinh
ALTER TABLE Kho
    ADD PRIMARY KEY (ID_NL);

-- Them khoa ngoai
ALTER TABLE Kho
    ADD CONSTRAINT Kho_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);

-- Tao bang PhieuNK
-- drop table PhieuNK;
CREATE TABLE PhieuNK(
    ID_NK INT,
    ID_NV INT,
    NgayNK DATE NOT NULL,
    Tongtien BIGINT DEFAULT 0
);

-- Them khoa chinh
ALTER TABLE PhieuNK
    ADD PRIMARY KEY (ID_NK);

-- Them khoa ngoai
ALTER TABLE PhieuNK
    ADD CONSTRAINT PNK_fk_idNV FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV);

-- Them bang CTNK
-- drop table CTNK;
CREATE TABLE CTNK(
    ID_NK INT,
    ID_NL INT,
    SoLuong SMALLINT NOT NULL,
    Thanhtien BIGINT
);

-- Them khoa chinh
ALTER TABLE CTNK
    ADD PRIMARY KEY (ID_NK, ID_NL);
    
-- Them khoa ngoai
ALTER TABLE CTNK
    ADD CONSTRAINT CTNK_fk_idNK FOREIGN KEY (ID_NK) REFERENCES PhieuNK(ID_NK);

ALTER TABLE CTNK
    ADD CONSTRAINT CTNK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);

-- Tao bang PhieuXK
-- drop table PhieuXK;
CREATE TABLE PhieuXK(
    ID_XK INT,
    ID_NV INT,
    NgayXK DATE NOT NULL
);

-- Them khoa chinh
ALTER TABLE PhieuXK
    ADD PRIMARY KEY (ID_XK);

-- Them khoa ngoai
ALTER TABLE PhieuXK
    ADD CONSTRAINT PXK_fk_idNV FOREIGN KEY (ID_NV) REFERENCES NhanVien(ID_NV);

-- Them bang CTXK
-- drop table CTXK;
CREATE TABLE CTXK(
    ID_XK INT,
    ID_NL INT,
    SoLuong SMALLINT NOT NULL
);

-- Them khoa chinh
ALTER TABLE CTXK
    ADD PRIMARY KEY (ID_XK, ID_NL);

-- Them khoa ngoai
ALTER TABLE CTXK
    ADD CONSTRAINT CTNK_fk_idXK FOREIGN KEY (ID_XK) REFERENCES PhieuXK(ID_XK);

ALTER TABLE CTXK
    ADD CONSTRAINT CTXK_fk_idNL FOREIGN KEY (ID_NL) REFERENCES NguyenLieu(ID_NL);

-- Tao Trigger
-- Khach hang chi duoc co toi da mot hoa don co trang thai Chua thanh toan
DELIMITER //
CREATE TRIGGER Tg_SLHD_CTT
BEFORE INSERT ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM HoaDon
    WHERE ID_KH = NEW.ID_KH AND TrangThai = 'Chua thanh toan';
    
    IF v_count > 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Moi khach hang chi duoc co toi da mot hoa don co trang thai chua thanh toan';
    END IF;
END//
DELIMITER ;

-- Trigger Thanh tien o CTHD bang SoLuong x Dongia cua mon an do
DELIMITER //
CREATE TRIGGER Tg_CTHD_Thanhtien
BEFORE INSERT ON CTHD
FOR EACH ROW
BEGIN
    DECLARE gia INT;
    
    SELECT DonGia INTO gia
    FROM MonAn
    WHERE MonAn.ID_MonAn = NEW.ID_MonAn;
    
    SET NEW.ThanhTien = NEW.SoLuong * gia;
END//
DELIMITER ;

-- Trigger Tien mon an o Hoa Don bang tong thanh tien o CTHD
DELIMITER //
CREATE TRIGGER Tg_HD_TienMonAn_Insert
AFTER INSERT ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET TienMonAn = TienMonAn + NEW.ThanhTien 
    WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_HD_TienMonAn_Update
AFTER UPDATE ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET TienMonAn = TienMonAn + NEW.ThanhTien - OLD.ThanhTien 
    WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_HD_TienMonAn_Delete
AFTER DELETE ON CTHD
FOR EACH ROW
BEGIN
    UPDATE HoaDon 
    SET TienMonAn = TienMonAn - OLD.ThanhTien 
    WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
END//
DELIMITER ;

-- Trigger Tien giam o Hoa Don
DELIMITER //
CREATE TRIGGER Tg_HD_TienGiam_Insert
AFTER INSERT ON CTHD
FOR EACH ROW
BEGIN
    DECLARE v_code VARCHAR(10);
    DECLARE v_loaiMA VARCHAR(50);
    DECLARE MA_Loai VARCHAR(50);
    
    SET v_code = NULL;
    
    SELECT HoaDon.Code_Voucher, Voucher.LoaiMA 
    INTO v_code, v_LoaiMA
    FROM HoaDon
    LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
    WHERE ID_HoaDon = NEW.ID_HoaDon;
    
    SELECT Loai INTO MA_Loai
    FROM MonAn 
    WHERE ID_MonAn = NEW.ID_MonAn;
    
    IF (v_code IS NOT NULL) THEN
        IF (v_LoaiMA = 'All' OR v_LoaiMA = MA_Loai) THEN 
            UPDATE HoaDon 
            SET TienGiam = TienGiam + Tinhtiengiam(NEW.ThanhTien, v_code) 
            WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
        END IF;
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_HD_TienGiam_Update
AFTER UPDATE ON CTHD
FOR EACH ROW
BEGIN
    DECLARE v_code VARCHAR(10);
    DECLARE v_loaiMA VARCHAR(50);
    DECLARE MA_Loai VARCHAR(50);
    
    SET v_code = NULL;
    
    SELECT HoaDon.Code_Voucher, Voucher.LoaiMA 
    INTO v_code, v_LoaiMA
    FROM HoaDon
    LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
    WHERE ID_HoaDon = NEW.ID_HoaDon;
    
    SELECT Loai INTO MA_Loai
    FROM MonAn 
    WHERE ID_MonAn = NEW.ID_MonAn;
    
    IF (v_code IS NOT NULL) THEN
        IF (v_LoaiMA = 'All' OR v_LoaiMA = MA_Loai) THEN 
            UPDATE HoaDon 
            SET TienGiam = TienGiam + Tinhtiengiam(NEW.ThanhTien, v_code) - Tinhtiengiam(OLD.ThanhTien, v_code) 
            WHERE HoaDon.ID_HoaDon = NEW.ID_HoaDon;
        END IF;
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_HD_TienGiam_Delete
AFTER DELETE ON CTHD
FOR EACH ROW
BEGIN
    DECLARE v_code VARCHAR(10);
    DECLARE v_loaiMA VARCHAR(50);
    DECLARE MA_Loai VARCHAR(50);
    
    SET v_code = NULL;
    
    SELECT HoaDon.Code_Voucher, Voucher.LoaiMA 
    INTO v_code, v_LoaiMA
    FROM HoaDon
    LEFT JOIN Voucher ON Voucher.Code_Voucher = HoaDon.Code_Voucher
    WHERE ID_HoaDon = OLD.ID_HoaDon;
    
    SELECT Loai INTO MA_Loai
    FROM MonAn 
    WHERE ID_MonAn = OLD.ID_MonAn;
    
    IF (v_code IS NOT NULL) THEN
        IF (v_LoaiMA = 'All' OR v_LoaiMA = MA_Loai) THEN 
            UPDATE HoaDon 
            SET TienGiam = TienGiam - Tinhtiengiam(OLD.ThanhTien, v_code) 
            WHERE HoaDon.ID_HoaDon = OLD.ID_HoaDon;
        END IF;
    END IF;
END//
DELIMITER ;

-- Tong tien o Hoa Don = Tien mon an - Tien giam
DELIMITER //
CREATE TRIGGER Tg_HD_Tongtien
AFTER UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.TienMonAn != OLD.TienMonAn OR NEW.TienGiam != OLD.TienGiam THEN
        UPDATE HoaDon 
        SET Tongtien = TienMonAn - TienGiam
        WHERE ID_HoaDon = NEW.ID_HoaDon;
    END IF;
END//
DELIMITER ;

-- Khi cap nhat Code_Voucher o HoaDon
DELIMITER //
CREATE TRIGGER Tg_HD_DoiVoucher
BEFORE UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE TongtienLoaiMonAnduocgiam INT;
    DECLARE v_Diemdoi INT;
    DECLARE v_Phantram INT;
    DECLARE v_LoaiMA VARCHAR(50);
    
    IF (NEW.Code_Voucher IS NOT NULL AND OLD.Code_Voucher != NEW.Code_Voucher) THEN
        SELECT Diem, Phantram, LoaiMA
        INTO v_Diemdoi, v_Phantram, v_LoaiMA
        FROM Voucher
        WHERE Code_Voucher = NEW.Code_Voucher;
        
        CALL KH_TruDTL(NEW.ID_KH, v_diemdoi);
        CALL Voucher_GiamSL(NEW.Code_Voucher);
        
        IF (v_LoaiMA = 'All') THEN
            SET TongtienLoaiMonAnduocgiam = NEW.TienMonAn;
        ELSE 
            SELECT SUM(Thanhtien)
            INTO TongtienLoaiMonAnduocgiam
            FROM CTHD 
            JOIN MonAn ON MonAn.ID_MonAn = CTHD.ID_MonAn
            WHERE ID_HoaDon = NEW.ID_HoaDon AND LOAI = v_LoaiMA;
        END IF;
        
        SET NEW.Tiengiam = ROUND(TongtienLoaiMonAnduocgiam * v_Phantram / 100);
        SET NEW.Tongtien = NEW.Tienmonan - NEW.Tiengiam;
    ELSEIF (NEW.Code_Voucher IS NULL AND OLD.Code_Voucher IS NOT NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Voucher khong ton tai';
    END IF;
END//
DELIMITER ;

-- Trigger Doanh so va Diem tich luy cua Khach hang
DELIMITER //
CREATE TRIGGER Tg_KH_DoanhsovaDTL
AFTER UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.Trangthai = 'Da thanh toan' AND OLD.Trangthai = 'Chua thanh toan' THEN
        UPDATE KhachHang 
        SET Doanhso = Doanhso + NEW.Tongtien 
        WHERE ID_KH = NEW.ID_KH;
        
        UPDATE KhachHang 
        SET Diemtichluy = Diemtichluy + ROUND(NEW.Tongtien * 0.00005)
        WHERE ID_KH = NEW.ID_KH;
    END IF;
END//
DELIMITER ;

-- Trigger trang thai ban
DELIMITER //
CREATE TRIGGER Tg_TrangthaiBan
AFTER UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    IF NEW.Trangthai = 'Chua thanh toan' AND OLD.Trangthai != 'Chua thanh toan' THEN 
        UPDATE Ban SET Trangthai = 'Dang dung bua' WHERE ID_Ban = NEW.ID_Ban;
    ELSEIF NEW.Trangthai = 'Da thanh toan' AND OLD.Trangthai = 'Chua thanh toan' THEN 
        UPDATE Ban SET Trangthai = 'Con trong' WHERE ID_Ban = NEW.ID_Ban;
    END IF; 
END//
DELIMITER ;

-- Trigger Thanh tien o CTNK
DELIMITER //
CREATE TRIGGER Tg_CTNK_Thanhtien
BEFORE INSERT ON CTNK
FOR EACH ROW
BEGIN
    DECLARE gia INT;
    
    SELECT DonGia INTO gia
    FROM NguyenLieu
    WHERE NguyenLieu.ID_NL = NEW.ID_NL;
    
    SET NEW.ThanhTien = NEW.SoLuong * gia;
END//
DELIMITER ;

-- Trigger Tong tien o PhieuNK
DELIMITER //
CREATE TRIGGER Tg_PNK_Tongtien_Insert
AFTER INSERT ON CTNK
FOR EACH ROW
BEGIN
    UPDATE PhieuNK 
    SET Tongtien = Tongtien + NEW.ThanhTien 
    WHERE PhieuNK.ID_NK = NEW.ID_NK;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_PNK_Tongtien_Update
AFTER UPDATE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE PhieuNK 
    SET Tongtien = Tongtien + NEW.ThanhTien - OLD.ThanhTien 
    WHERE PhieuNK.ID_NK = NEW.ID_NK;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_PNK_Tongtien_Delete
AFTER DELETE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE PhieuNK 
    SET Tongtien = Tongtien - OLD.ThanhTien 
    WHERE PhieuNK.ID_NK = OLD.ID_NK;
END//
DELIMITER ;

-- Trigger khi them CTNK tang So luong ton cua nguyen lieu trong kho
DELIMITER //
CREATE TRIGGER Tg_Kho_ThemSLTon_Insert
AFTER INSERT ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho 
    SET SLTon = SLTon + NEW.SoLuong 
    WHERE Kho.ID_NL = NEW.ID_NL;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_Kho_ThemSLTon_Update
AFTER UPDATE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho 
    SET SLTon = SLTon + NEW.SoLuong - OLD.SoLuong 
    WHERE Kho.ID_NL = NEW.ID_NL;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_Kho_ThemSLTon_Delete
AFTER DELETE ON CTNK
FOR EACH ROW
BEGIN
    UPDATE Kho 
    SET SLTon = SLTon - OLD.SoLuong 
    WHERE Kho.ID_NL = OLD.ID_NL;
END//
DELIMITER ;

-- Trigger khi them CTXK giam So luong ton cua nguyen lieu trong kho
DELIMITER //
CREATE TRIGGER Tg_Kho_GiamSLTon_Insert
AFTER INSERT ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho 
    SET SLTon = SLTon - NEW.SoLuong 
    WHERE Kho.ID_NL = NEW.ID_NL;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_Kho_GiamSLTon_Update
AFTER UPDATE ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho 
    SET SLTon = SLTon - NEW.SoLuong + OLD.SoLuong 
    WHERE Kho.ID_NL = NEW.ID_NL;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER Tg_Kho_GiamSLTon_Delete
AFTER DELETE ON CTXK
FOR EACH ROW
BEGIN
    UPDATE Kho 
    SET SLTon = SLTon + OLD.SoLuong 
    WHERE Kho.ID_NL = OLD.ID_NL;
END//
DELIMITER ;

-- Trigger khi them mot Nguyen Lieu moi, them NL do vao Kho
DELIMITER //
CREATE TRIGGER Tg_Kho_ThemNL
AFTER INSERT ON NguyenLieu
FOR EACH ROW
BEGIN
    INSERT INTO Kho(ID_NL) VALUES(NEW.ID_NL);
END//
DELIMITER ;

-- Procedure them mot khach hang moi voi cac thong tin tenKH, NgayTG va ID_ND
DELIMITER //
CREATE PROCEDURE KH_ThemKH(
    IN tenKH VARCHAR(50), 
    IN NgayTG DATE,
    IN ID_ND INT
)
BEGIN
    DECLARE v_ID_KH INT;
    
    -- Them ma KH tiep theo
    SELECT MIN(ID_KH)+1 INTO v_ID_KH
    FROM KHACHHANG
    WHERE ID_KH + 1 NOT IN(SELECT ID_KH FROM KHACHHANG);
    
    INSERT INTO KhachHang(ID_KH, TenKH, Ngaythamgia, ID_ND) 
    VALUES (v_ID_KH, tenKH, NgayTG, ID_ND);
    
END//
DELIMITER ;

-- Procudure them mot nhan vien moi
DELIMITER //
CREATE PROCEDURE NV_ThemNV(
    IN tenNV VARCHAR(50), 
    IN NgayVL DATE, 
    IN SDT VARCHAR(50),
    IN Chucvu VARCHAR(50),
    IN ID_NQL INT, 
    IN Tinhtrang VARCHAR(20)
)
BEGIN
    DECLARE v_ID_NV INT;
    
    -- Them ma NV tiep theo
    SELECT MIN(ID_NV)+1 INTO v_ID_NV
    FROM NHANVIEN
    WHERE ID_NV + 1 NOT IN(SELECT ID_NV FROM NHANVIEN);
    
    INSERT INTO NhanVien(ID_NV, TenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang) 
    VALUES (v_ID_NV, tenNV, NgayVL, SDT, Chucvu, ID_NQL, Tinhtrang);
END//
DELIMITER ;

-- Procudure xoa mot NHANVIEN voi idNV
DELIMITER //
CREATE PROCEDURE NV_XoaNV(IN idNV INT)
BEGIN
    DECLARE v_count INT;
    DECLARE idNQL INT;
    
    SELECT COUNT(ID_NV), ID_NQL
    INTO v_count, idNQL
    FROM NHANVIEN
    WHERE ID_NV = idNV;
    
    IF (v_count > 0) THEN
        IF (idNV = idNQL) THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Khong the xoa QUAN LY';
        ELSE
            DELETE FROM CTNK 
            WHERE ID_NK IN (SELECT ID_NK FROM PHIEUNK WHERE ID_NV = idNV);
            
            DELETE FROM CTXK 
            WHERE ID_XK IN (SELECT ID_XK FROM PHIEUXK WHERE ID_NV = idNV);
            
            DELETE FROM PHIEUNK WHERE ID_NV = idNV;
            DELETE FROM PHIEUXK WHERE ID_NV = idNV;
            DELETE FROM NHANVIEN WHERE ID_NV = idNV;
        END IF;
    ELSE 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nhan vien khong ton tai';
    END IF;
END//
DELIMITER ;

-- Procudure xoa mot KHACHHANG voi idKH
DELIMITER //
CREATE PROCEDURE KH_XoaKH(IN idKH INT)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*)
    INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = idKH;
    
    IF (v_count > 0) THEN
        DELETE FROM CTHD 
        WHERE ID_HoaDon IN (SELECT ID_HoaDon FROM HOADON WHERE ID_KH = idKH);
        
        DELETE FROM HOADON WHERE ID_KH = idKH;
        DELETE FROM KHACHHANG WHERE ID_KH = idKH;
    ELSE 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    END IF;
END//
DELIMITER ;

-- Procedure xem thong tin KHACHHANG
DELIMITER //
CREATE PROCEDURE KH_XemTT(IN idKH INT)
BEGIN
    DECLARE v_TenKH VARCHAR(50);
    DECLARE v_Ngaythamgia DATE;
    DECLARE v_Doanhso INT;
    DECLARE v_Diemtichluy INT;
    DECLARE v_ID_ND INT;
    
    SELECT TenKH, Ngaythamgia, Doanhso, Diemtichluy, ID_ND
    INTO v_TenKH, v_Ngaythamgia, v_Doanhso, v_Diemtichluy, v_ID_ND
    FROM KHACHHANG 
    WHERE ID_KH = idKH;
    
    IF v_TenKH IS NOT NULL THEN
        SELECT 
            CONCAT('Ma khach hang: ', idKH) AS ThongTin,
            CONCAT('Ten khach hang: ', v_TenKH) AS TenKH,
            CONCAT('Ngay tham gia: ', DATE_FORMAT(v_Ngaythamgia, '%d-%m-%Y')) AS NgayThamGia,
            CONCAT('Doanh so: ', v_Doanhso) AS DoanhSo,
            CONCAT('Diem tich luy: ', v_Diemtichluy) AS DiemTichLuy,
            CONCAT('Ma nguoi dung: ', v_ID_ND) AS MaNguoiDung;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    END IF;
END//
DELIMITER ;

-- Procedure xem thong tin NHANVIEN
DELIMITER //
CREATE PROCEDURE NV_XemTT(IN idNV INT)
BEGIN
    DECLARE v_TenNV VARCHAR(50);
    DECLARE v_NgayVL DATE;
    DECLARE v_SDT VARCHAR(50);
    DECLARE v_Chucvu VARCHAR(50);
    DECLARE v_ID_NQL INT;
    
    SELECT TenNV, NgayVL, SDT, Chucvu, ID_NQL
    INTO v_TenNV, v_NgayVL, v_SDT, v_Chucvu, v_ID_NQL  
    FROM NHANVIEN 
    WHERE ID_NV = idNV;
    
    IF v_TenNV IS NOT NULL THEN
        SELECT 
            CONCAT('Ma nhan vien: ', idNV) AS ThongTin,
            CONCAT('Ten nhan vien: ', v_TenNV) AS TenNV,
            CONCAT('Ngay vao lam: ', DATE_FORMAT(v_NgayVL, '%d-%m-%Y')) AS NgayVaoLam,
            CONCAT('Chuc vu: ', v_Chucvu) AS ChucVu,
            CONCAT('Ma nguoi quan ly: ', v_ID_NQL) AS MaNguoiQuanLy;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nhan vien khong ton tai';
    END IF;
END//
DELIMITER ;

-- Procedure liet ke danh sach hoa don tu ngay A den ngay B
DELIMITER //
CREATE PROCEDURE DS_HoaDon_tuAdenB(IN fromA DATE, IN toB DATE)
BEGIN
    SELECT 
        ID_HOADON,
        ID_KH,
        ID_BAN,
        NGAYHD,
        TIENMONAN,
        TIENGIAM,
        TONGTIEN,
        TRANGTHAI
    FROM HOADON 
    WHERE NGAYHD BETWEEN fromA AND (toB + INTERVAL 1 DAY);
END//
DELIMITER ;

-- Procedure liet ke danh sach phieu nhap kho tu ngay A den ngay B
DELIMITER //
CREATE PROCEDURE DS_PhieuNK_tuAdenB(IN fromA DATE, IN toB DATE)
BEGIN
    SELECT 
        ID_NK,
        ID_NV,
        NGAYNK,
        TONGTIEN
    FROM PHIEUNK 
    WHERE NGAYNK BETWEEN fromA AND (toB + INTERVAL 1 DAY);
END//
DELIMITER ;

-- Procedure liet ke danh sach phieu xuat kho tu ngay A den ngay B
DELIMITER //
CREATE PROCEDURE DS_PhieuXK_tuAdenB(IN fromA DATE, IN toB DATE)
BEGIN
    SELECT 
        ID_XK,
        ID_NV,
        NGAYXK
    FROM PHIEUXK 
    WHERE NGAYXK BETWEEN fromA AND (toB + INTERVAL 1 DAY);
END//
DELIMITER ;

-- Procedure xem chi tiet hoa don cua 1 hoa don
DELIMITER //
CREATE PROCEDURE HD_XemCTHD(IN idHD INT)
BEGIN
    SELECT 
        ID_MONAN,
        SOLUONG,
        THANHTIEN
    FROM CTHD 
    WHERE ID_HOADON = idHD;
END//
DELIMITER ;

-- Procedure giam So Luong cua Voucher di 1 khi KH doi Voucher
DELIMITER //
CREATE PROCEDURE Voucher_GiamSL(IN code VARCHAR(10))
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*)
    INTO v_count
    FROM Voucher
    WHERE Code_Voucher = code;
    
    IF (v_count > 0) THEN
        UPDATE Voucher SET SoLuong = SoLuong - 1 WHERE Code_Voucher = code;
    ELSE 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Voucher khong ton tai';
    END IF;
END//
DELIMITER ;

-- Procedure giam Diem tich luy cua KH khi doi Voucher
DELIMITER //
CREATE PROCEDURE KH_TruDTL(IN ID INT, IN diemdoi INT)
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*)
    INTO v_count
    FROM KHACHHANG
    WHERE ID_KH = ID;
    
    IF (v_count > 0) THEN
        UPDATE KHACHHANG SET Diemtichluy = Diemtichluy - diemdoi WHERE ID_KH = ID;
    ELSE 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Khach hang khong ton tai';
    END IF;
END//
DELIMITER ;

-- Function Tinh doanh thu hoa don theo ngay
DELIMITER //
CREATE FUNCTION DoanhThuHD_theoNgay(ngHD DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Doanhthu INT;
    
    SELECT SUM(Tongtien)
    INTO v_Doanhthu
    FROM HOADON 
    WHERE NGAYHD = ngHD;
    
    SET v_Doanhthu = IFNULL(v_Doanhthu, 0);
    RETURN v_Doanhthu;
END//
DELIMITER ;

-- Function Tinh chi phi nhap kho theo ngay
DELIMITER //
CREATE FUNCTION ChiPhiNK_theoNgay(ngNK DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_Chiphi INT;
    
    SELECT SUM(Tongtien)
    INTO v_Chiphi
    FROM PHIEUNK 
    WHERE NGAYNK = ngNK;
    
    SET v_Chiphi = IFNULL(v_Chiphi, 0);
    RETURN v_Chiphi;
END//
DELIMITER ;

-- Function Tinh doanh so trung binh cua x KHACHHANG co doanh so cao nhat
DELIMITER //
CREATE FUNCTION DoanhsoTB_TOPxKH(x INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_avg DECIMAL(10,2);
    
    SELECT AVG(Doanhso)
    INTO v_avg
    FROM (
        SELECT Doanhso 
        FROM KHACHHANG
        ORDER BY Doanhso DESC
        LIMIT x
    ) AS Top_KH;
    
    RETURN v_avg;
END//
DELIMITER ;

-- Function Tinh so luong KHACHANG moi trong thang chi dinh co it nhat mot hoa don tren x vnd
DELIMITER //
CREATE FUNCTION SL_KH_Moi(thang INT, nam INT, trigiaHD INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(ID_KH)
    INTO v_count
    FROM KHACHHANG
    WHERE MONTH(Ngaythamgia) = thang AND YEAR(Ngaythamgia) = nam
    AND EXISTS(
        SELECT *
        FROM HOADON 
        WHERE HOADON.ID_KH = KHACHHANG.ID_KH AND TONGTIEN > trigiaHD
    );
    
    RETURN v_count;
END//
DELIMITER ;

-- Đổi định dạng ngày cho phần thêm dữ liệu
SET sql_mode = '';

-- Them data cho Bang NguoiDung
-- Nhan vien
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (100,'NVHoangViet@gmail.com','123','Verified','Quan Ly');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (101,'NVHoangPhuc@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (102,'NVAnhHong@gmail.com','123','Verified','Nhan Vien Kho');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (103,'NVQuangDinh@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (117,'duc2@gmail.com','123','Verified','Quan Ly');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (118,'duc3@gmail.com','123','Verified','Nhan Vien');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (119,'duc4@gmail.com','123','Verified','Nhan Vien Kho');

-- Khach Hang
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (104,'KHThaoDuong@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (105,'KHTanHieu@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (106,'KHQuocThinh@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (107,'KHNhuMai@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (108,'KHBichHao@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (109,'KHMaiQuynh@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (110,'KHMinhQuang@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (111,'KHThanhHang@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (112,'KHThanhNhan@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (113,'KHPhucNguyen@gmail.com','123','Verified','Khach Hang');
INSERT INTO NguoiDung(ID_ND,Email,MatKhau,Trangthai,Vaitro) VALUES (120,'duc1@gmail.com','123','Verified','Khach Hang');

-- Them data cho bang Nhan Vien
-- Co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (100,'Nguyen Hoang Viet','2023-05-10','0848044725','Quan ly',100,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (101,'Nguyen Hoang Phuc','2023-05-20','0838033334','Tiep tan',101,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (102,'Le Thi Anh Hong','2023-05-19','0838033234','Kho',102,100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (103,'Ho Quang Dinh','2023-05-19','0838033234','Tiep tan',103,100,'Dang lam viec');

-- Khong co tai khoan
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (104,'Ha Thao Duong','2023-05-10','0838033232','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (105,'Nguyen Quoc Thinh','2023-05-11','0838033734','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (106,'Truong Tan Hieu','2023-05-12','0838033834','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (107,'Nguyen Thai Bao','2023-05-10','0838093234','Phuc vu',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (108,'Tran Nhat Khang','2023-05-11','0838133234','Thu ngan',100,'Dang lam viec');
INSERT INTO NhanVien(ID_NV,TenNV,NgayVL,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (109,'Nguyen Ngoc Luong','2023-05-12','0834033234','Bep',100,'Dang lam viec');

-- Them data cho bang KhachHang
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (100,'Ha Thao Duong','2023-05-10',104);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (101,'Truong Tan Hieu','2023-05-10',105);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (102,'Nguyen Quoc Thinh','2023-05-10',106);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (103,'Tran Nhu Mai','2023-05-10',107);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (104,'Nguyen Thi Bich Hao','2023-05-10',108);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (105,'Nguyen Mai Quynh','2023-05-11',109);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (106,'Hoang Minh Quang','2023-05-11',110);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (107,'Nguyen Thanh Hang','2023-05-12',111);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (108,'Nguyen Ngoc Thanh Nhan','2023-05-11',112);
INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (109,'Hoang Thi Phuc Nguyen','2023-05-12',113);

-- Function tính tiền giảm khi thêm CTHD mới
DELIMITER //
CREATE FUNCTION CTHD_Tinhtiengiam(Tongtien INT, Code VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE Tiengiam INT;
    DECLARE v_phantram INT;
    
    SELECT Phantram
    INTO v_Phantram
    FROM Voucher
    WHERE Code_Voucher = Code;
    
    SET Tiengiam = ROUND(Tongtien * v_Phantram / 100);
    RETURN Tiengiam;
END//
DELIMITER ;

-- Thêm data cho bảng Voucher
INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('loQy', '20% off for Aries Menu', 20, 'Aries', 10, 200);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('pCfI', '30% off for Taurus Menu', 30, 'Taurus', 5, 300);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('pApo', '20% off for Gemini Menu', 20, 'Gemini', 10, 200);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('ugQx', '100% off for Virgo Menu', 100, 'Virgo', 3, 500);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('nxVX', '20% off for All Menu', 20, 'All', 5, 300);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('Pwyn', '20% off for Cancer Menu', 20, 'Cancer', 10, 200);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('bjff', '50% off for Leo Menu', 50, 'Leo', 5, 600);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('YPzJ', '20% off for Aquarius Menu', 20, 'Aquarius', 5, 200);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('Y5g0', '30% off for Pisces Menu', 30, 'Pisces', 5, 300);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('7hVO', '60% off for Aries Menu', 60, 'Aries', 0, 1000);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('WHLm', '20% off for Capricorn Menu', 20, 'Capricorn', 0, 200);

INSERT INTO Voucher(Code_Voucher, Mota, Phantram, LoaiMA, SoLuong, Diem) 
VALUES ('GTsC', '20% off for Leo Menu', 20, 'Leo', 0, 200);

-- Thêm data cho bảng HoaDon
INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (101, 100, 100, '2023-01-10', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (102, 104, 102, '2023-01-15', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (103, 105, 103, '2023-01-20', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (104, 101, 101, '2023-02-13', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (105, 103, 120, '2023-02-12', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (106, 104, 100, '2023-03-16', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (107, 107, 103, '2023-03-20', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (108, 108, 101, '2023-04-10', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (109, 100, 100, '2023-04-20', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (110, 103, 101, '2023-05-05', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (111, 106, 102, '2023-05-10', 0, 0, 'Chua thanh toan');

INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) 
VALUES (112, 108, 103, '2023-05-15', 0, 0, 'Chua thanh toan');

-- Phân trang cho code ngắn hơn, thêm các hóa đơn còn lại tương tựb

-- Thêm data cho CTHD 
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,3,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,10,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,1,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,2,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,4,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (103,12,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,30,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,59,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,28,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,88,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,70,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,75,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,78,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,32,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,12,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,12,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,40,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (109,45,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,34,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,43,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,65,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,47,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,49,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,31,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,30,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,32,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (115,80,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,57,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,34,1);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,67,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,66,3);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,34,10);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,35,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,83,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,78,2);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,38,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,39,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,53,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,31,4);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,33,5);
INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,34,6);
UPDATE HOADON SET TrangThai='Da thanh toan';
-- ... (Các hàng còn lại)

-- Cập nhật trạng thái hóa đơn
UPDATE HOADON SET TrangThai = 'Da thanh toan';

--Them data cho bang NguyenLieu
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(100,'Thit ga',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(101,'Thit heo',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(102,'Thit bo',80000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(103,'Tom',100000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(104,'Ca hoi',500000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(105,'Gao',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(106,'Sua tuoi',40000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(107,'Bot mi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(108,'Dau ca hoi',1000000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(109,'Dau dau nanh',150000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(110,'Muoi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(111,'Duong',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(112,'Hanh tay',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(113,'Toi',30000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(114,'Dam',50000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(115,'Thit de',130000,'kg');

--Them data cho PhieuNK
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (100,102,'10-01-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (101,102,'11-02-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (102,102,'12-02-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (103,102,'12-03-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (104,102,'15-03-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (105,102,'12-04-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (106,102,'15-04-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (107,102,'12-05-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (108,102,'15-05-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (109,102,'5-06-2023');
INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (110,102,'7-06-2023');

--Them data cho CTNK
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,100,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,101,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,101,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,103,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,104,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,105,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,106,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,107,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,108,5);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,109,10);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,110,20);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (105,110,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,102,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,115,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,110,35);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,105,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,104,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,103,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,106,30);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,112,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,113,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,114,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,102,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,106,25);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,107,15);
INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,110,20);

--Them data cho PhieuXK
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (100,102,'10-01-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (101,102,'11-02-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (102,102,'12-03-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (103,102,'13-03-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (104,102,'12-04-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (105,102,'13-04-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (106,102,'12-05-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (107,102,'15-05-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (108,102,'20-05-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (109,102,'5-06-2023');
INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (110,102,'10-06-2023');

--Them data cho CTXK
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,100,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,101,7);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,103,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,106,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,109,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,112,10);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,113,8);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,104,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,101,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,102,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,103,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,114,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,105,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,106,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,115,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,110,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,112,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,113,5);
INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,114,5);



