create database  QLGIAOHANG
USE QLGIAOHANG
create table DV
( MADV char(50),
TENDV NVARCHAR(50),
constraint pk_dv PRIMARY KEY(MADV)
)
CREATE TABLE DH_GH
(
MADH_GH VARCHAR(50),
MAKH VARCHAR(50),
MATV_GH VARCHAR(50),
MADV CHAR(50),
MAKV VARCHAR(10),
TEN_NG_NHAN NVARCHAR(50),
DC_GH NVARCHAR(50),
SDT_NG_NHAN CHAR(50),
MA_KHOANG_TG_GH CHAR(50),
NGAY_GH DATE, 
PTTT nvarchar(50),
TT_PHEDUYET bit,
TT_GH nvarchar(50),
CONSTRAINT pk_dh PRIMARY KEY(MADH_GH)
)
CREATE TABLE KHACHHANG
(MAKH VARCHAR(50),
MAKV VARCHAR(10),
TENKH NVARCHAR(50),
TENCH NVARCHAR(50),
SODT_KH CHAR(50), 
EMAIL CHAR(50),
DC_NHANHANG NVARCHAR(50),
CONSTRAINT pk_KHACHHANG PRIMARY KEY(MAKH)
)
CREATE TABLE CTDH 
(MADH_GH VARCHAR(50),
TENSPGIAO NVARCHAR(50),
SOLUONG FLOAT,
TRONGLUONG varchar(10),
MALMH CHAR(50),
TIENTH FLOAT,
CONSTRAINT pk_ctdh PRIMARY KEY(MADH_GH,TENSPGIAO)
)
CREATE TABLE LMH
(
MALMH CHAR(50),
TENLMH NVARCHAR(50),
CONSTRAINT pk_LMH PRIMARY KEY(MALMH)
)
CREATE TABLE TV_GH(
MATV_GH VARCHAR(50),
TENTV_GH NVARCHAR(50), 
NGAYSINH DATE, 
GT BIT, 
SDT_TV CHAR(50),
DC_TV NVARCHAR(50),
CONSTRAINT pk_tv PRIMARY KEY(MATV_GH)
)

CREATE TABLE DK_GH (
MATV_GH VARCHAR(50),
MA_KHOANG_TG_GH CHAR(50),
CONSTRAINT pk_dkgh PRIMARY KEY(MATV_GH,MA_KHOANG_TG_GH)
)
CREATE TABLE KTG ( 
MA_KHOANG_TG_GH CHAR(50),
MOTA CHAR(50),
CONSTRAINT pk_KTG PRIMARY KEY(MA_KHOANG_TG_GH) 
)

CREATE TABLE KV 
(
MAKV VARCHAR(10),
TENKV NVARCHAR(50),
CONSTRAINT pk_KV PRIMARY KEY(MAKV) 
)

---Bài 1: Tạo ràng buộc:
a. Phương thức thanh toán nhận 2 giá trị: Chuyển khoản, tiền mặt
b. Số lượng >=1
c. Trạng thái giao hàng nhận 3 giá trị, nhận hàng, không nghe điện thoại, không
nhận
d. Nhập dữ liệu cho các bảng trên.
a.

alter table DH_GH
add constraint chk_DHGH check(PTTT in('chuyển khoản','tiền mặt'))
b.
alter table CTDH 
add constraint chk_ctdh CHECK (SOLUONG >=1)
c.
alter table DH_GH 
add constraint chk_DHGH1 check( TT_GH in('nhận hàng','không nghe máy','không nhận'))


--tạo khóa ngoại liên kết bảng 
alter table DH_GH 
add constraint fk_DHGH FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
alter table DH_GH 
add constraint fk_DHGH1 foreign key(MADV) REFERENCES DV(MADV)
alter table CTDH 
add constraint fk_CTDHR  foreign key(MADH_GH) references DH_GH(MADH_GH)
alter table DH_GH 
add constraint fk_DHGaH3 foreign key(MA_KHOANG_TG_GH) references KTG(MA_KHOANG_TG_GH)
alter table CTDH 
add constraint fk_CTDH1 foreign key(MALMH) references LMH(MALMH)
alter table DK_GH 
add constraint fk_DKGH foreign key(MATV_GH) references TV_GH(MATV_GH)
alter table DH_GH 
add constraint fk_DHGH4 foreign key(MATV_GH) references TV_GH(MATV_GH)
alter table KHACHHANG 
add constraint fk_KH foreign key(MAKV) references KV(MAKV)
ALTER TABLE DH_GH 
ADD CONSTRAINT FK_DHGH5 FOREIGN KEY(MAKV) REFERENCES KV(MAKV)
d.
insert into DH_GH(MADH_GH,MAKH,MATV_GH,MADV,MAKV,TEN_NG_NHAN,DC_GH,SDT_NG_NHAN,MA_KHOANG_TG_GH,NGAY_GH,PTTT,TT_PHEDUYET,TT_GH) 
VALUES 
('SP01','KH01','TV01','DV1','KV77',N'BÙI THANH PHONG',N'118 lÝ TỰ TRỌNG,LÊ LỢI,QUY NHƠN','0865115727','TGGH01','2024/05/10',N'tiền mặt','1',N'đã nhận'),
('SP02','KH02','TV03','DV1','KV77',N'TRẦN NGỌC TOÀN',N'239 ĐỐNG ĐA,QUI NHƠN','0999329009','TGGH02','2024/02/19','chuyển khoản','1',N'đã nhận'),
('SP03','KH03','TV07','DV1','KV77',N'NGUYỄN XUÂN HINH',N'270 LÊ HỒNG PHONG,QUI NHƠN','02939102203','TGGH03','2024/04/02',N'tiền mặt','1',N'đã nhận'),
('SP04','KH04','TV07','DV2','KV77',N'ĐẶNG NHẬT HÀO',N'23 ĐỐNG ĐA,QUI NHƠN','0939108841','TGGH04','2024/01/15',N'tiền mặt','1',N'không nhận'),
('SP05','KH05','TV07','DV1','KV77','DAVID JOHNATHAN',N'88 ĐỐNG ĐA,QUI NHƠN','0332384849','TGGH05','2023/10/30',N'tiền mặt','1',N'không nghe máy'),
('SP06','KH06','TV06','DV1','KV77',N'NGUYỄN KHÁNH HUY',N'79 LÊ HỒNG PHONG,QUI NHƠN','0983817381','TGGH06','2024/05/19','tiền mặt','0',NULL),
('SP07','KH07','TV07','DV1','KV77',N'KIỀU VŨ DUY',N'29 TRẦN CAO VÂN,QUI NHƠN','0984417283','TGGH07','2024/04/18','tiền mặt','1',N'đã nhận'),
('SP08','KH08','TV03','DV1','KV77',N'TRẦN MỸ ANH',N'55 ĐỐNG ĐA,QUI NHƠN','0128908313','TGGH08','2024/01/13',N'chuyển khoản','1',N'không nghe máy'),
('SP09','KH09','TV07','DV2','KV77',N'TRẦN THỊ Ý NHI',N'59 ĐỐNG ĐA,QUI NHƠN','0827381214','TGGH09','2024/05/2','tiền mặt','1','đã nhận'),
('SP10','KH10','TV01','DV1','KV77',N'LÊ KHỞI MY',N'1111 NGUYỄN THÁI HỌC,QUI NHƠN','0934198031','TGGH10','2024/04/29','tiền mặt','1','đã nhận'),
('SP11','KH11','TV03','DV1','KV77',N'NGUYỄN QUANG HẢI',N'04 NGÔ MÂY,QUI NHƠN','0638109231','TGGH11','2024/05/19','tiền mặt','0',NULL),
('SP12','KH12','TV04','DV1','KV77',N'LÊ THỊ AN',N'55 TÂY SƠN,QUI NHƠN','0120210219','TGGH12','2022/03/10','tiền mặt','1','không nhận')
insert into TV_GH(MATV_GH,TENTV_GH,NGAYSINH,GT,SDT_TV,DC_TV)
VALUES ('TV01',N'TRẦN VĂN HỢI','1998/05/11','1','0911820299',N'128 PHAN BỘI CHÂU,QUI NHƠN'),
('TV02',N'TRẦN QUANG THÁI','1999/03/18','1','0933018729',N'AN DƯƠNG VƯƠNG,QUI NHƠN'),
('TV03',N'NGUYỄN QUỐC BẢO','2001/02/11','1','0865890166',N'TRẦN PHÚ,QUI NHƠN'),
('TV04',N'LÊ MINH TRÍ','2003/08/24','1','0979390871',N'LÝ THÁI TỔ,QUI NHƠN'),
('TV05',N'HUỲNH NHẬT HUY','2001/10/30','1','0987481235',N'NGUYỄN THÁI HỌC,QUI NHƠN'),
('TV06',N'TRẦN THANH THỤ','1992/10/30','1','0981293182',N'LÊ ĐẠI HÀNH,QUI NHƠN'),
('TV07',N'LÊ XUÂN THỦY','1999/09/06','0','0282738101',N'TRẦN CAO VÂN,QUI NHƠN'),
('TV08',N'NGUYỄN THỊ THU','2000/01/11','0','0979377224',N'ĐỐNG ĐA,QUI NHƠN')

insert into DK_GH(MATV_GH,MA_KHOANG_TG_GH) VALUES 
('TV01','TGGH1'),
('TV03','TGGH2'),
('TV07','TGGH3'),
('TV07','TGGH4'),
('TV07','TGGH5'),
('TV07','TGGH7'),
('TV03','TGGH8'),
('TV07','TGGH9'),
('TV01','TGGH10'),
('TV04','TGGH12')
insert into LMH(MALMH,TENLMH) VALUES
('MH1','COCA COLA'),
('MH2','TA TAY LOAI NHO'),
('MH3','KEM CHONG NANG'),
('MH4','COMBO GA CHIEN GION,TRA SUA SIZE S'),
('MH5','TRUYEN CHU SIEU HAY'),
('MH6','QUAT MINI'),
('MH7','NUOC HOA'),
('MH8','AO KHOAC GUCCI'),
('MH9','TRANH TO MAU NUOC'),
('MH10','BONG DA RUOT DAC'),
('MH11','CHÂN GA SOT THAI,COMBO KHOAI TAY CHIEN CANH GA'),
('MH12','GIAY DA BONG')
insert into DV(MADV,TENDV)  
VALUES('DV1',N'GIAO HÀNG NHANH'),('DV2',N'GIAO HÀNG TIẾT KIỆM')
insert into KHACHHANG(MAKH,MAKV,TENKH,TENCH,SODT_KH,EMAIL,DC_NHANHANG) 
VALUES('KH01','KV77',N'BÙI THANH PHONG',null,'0865115727','bphu5933@gmail.com',N'118 LÝ TỰ TRỌNG,QUI NHƠN'),
('KH02','KV77',N'TRẦN NGỌC TOÀN',NULL,'0999329009','toantt@gmail.com',N'239 NGÔ MÂY,QUI NHƠN'),
('KH03','KV77',N'NGUYỄN XUÂN HINH',NULL,'02939102203','hinhcute@gmail.com',N'270 LÊ HỒNG PHONG,QUI NHƠN'),
('KH04','KV77',N'ĐẶNG NHẬT HÀO','GM SHOP','0939108841','haowibu@gmail.com',N'23 NGÔ MÂY,QUI NHƠN'),
('KH05','KV77','DAVID JOHNATHAN','GYMER SHOP QN','0332384849','johnspain11@gmail.com',N'88 NGÔ MÂY,QUI NHƠN'),
('KH06','KV77',N'NGUYỄN KHÁNH HUY','nenonoffical','0983817381','khanhhuy05@gmail.com',N'79 LÊ HỒNG PHONG,QUI NHƠN'),
('KH07','KV77',N'KIỀU VŨ DUY','lemon store','0984417283','kieuduy2005@gmail.com',N'29 TRẦN CAO VÂN,QUI NHƠN'),
('KH08','KV77',N'TRẦN MỸ ANH','offical store','0128908313','myanh99@gmail.com',N'55 NGÔ MÂY,QUI NHƠN'),
('KH09','KV77',N'TRẦN THỊ Ý NHI','x','0827381214','tranynhi2000@gmail.com',N'59 ĐỐNG ĐA,QUI NHƠN'),
('KH10','KV77',N'LÊ KHỞI MY','temmeshop','0934198031','khoimi11@gmail.com',N'1111 NGUYỄN THÁI HỌC,QUI NHƠN'),
('KH11','KV77',N'NGUYỄN QUANG HẢI','fms','0638109231','quanghaisieusaovn@gmail.com',N'04 AN DƯƠNG VƯƠNG,QUI NHƠN'),
('KH12','kV77',N'LÊ THỊ AN','efotshop','0120210219','tienlinh2010@gmail.com',N'55 TÂY SƠN,QUI NHƠN')
insert into KTG(MA_KHOANG_TG_GH,MOTA) 
VALUES
('TGGH1','GIAO HANG NHANH NHA SHOP'),
('TGGH2','NO COMMENT'),
('TGGH3','NO COMMENT'),
('TGGH4',N'GIAO HÀNG NHIỆT'),
('TGGH5','NO COMMENT'),
('TGGH7',N'ĐÁNH GIÁ 5 SAO'),
('TGGH8',N'CHƯA HÀI LÒNG'),
('TGGH9',N'ỔN'),
('TGGH10','NO COMMENT'),
('TGGH12','NO COMMENT')

INSERT INTO KV(MAKV,TENKV) 
VALUES('KV77',N'BÌNH ĐỊNH')
INSERT INTO CTDH(MADH_GH,TENSPGIAO,SOLUONG,MALMH,TIENTH,TRONGLUONG) VALUES
('SP01',N'TRUYỆN CHỮ SIÊU HAY','03','MH5',200000,'1KG'),
('SP02',N'ÁO KHOÁC GUCCI','01','MH8',430000,'2KG'),
('SP03','COCA COLA','75','MH1',1023000,'7KG'),
('SP04',N'ÁO KHOÁC GUCCI','01','MH8',430000,'2KG'),
('SP05',N'TẠ TAY LOẠI NHỎ','04','MH2',160000,'12KG'),
('SP06',N'BÓNG DA RUỘT ĐẶC','01','MH10',230000,'800G'),
('SP07',N'COMBO GÀ CHIÊN GIÒN,TRÀ SỮA SIZE S','02','MH4',637000,'800G'),
('SP08',N'NƯỚC HOA','01','MH7',128000,'100G'),
('SP09',N'CHÂN GÀ SỐT THÁI,COMBO KHOAI TÂY CHIÊN CÁNH GÀ','04','MH11',230000,'3KG'),
('SP10',N'KEM CHỐNG NẮNG','01','MH3',90000,'150G'),
('SP11',N'TRANH TÔ MÀU NƯỚC','02','MH9',60000,'600G'),
('SP12',N'GIÀY ĐÁ BÓNG','01','MH12',105000,'400G')
--Câu 1: Xóa những khách hàng có tên là “Lê Thị An”.
select * from khachhang
delete from khachhang 
where tenkh=N'Lê Thị An'
--Câu 2: Cập nhật những khách hàng đang thường trú ở khu vực “Ngô mây” thành khu vực “Đống Đa”.
update dbo.KHACHHANG
set DC_NHANHANG=N'ĐỐNG ĐA'
where dc_NHANHANG =N'NGÔ MÂY'
--Câu 3: Xóa những khách hàng có địa chỉ ở đường “An Dương Vương”
delete from khachhang
where dc_nhanhang=N'An Dương Vương'
--Câu 4: Xóa những khách hàng có trạng thái giao hàng là:”Không nhận”
select * from DH_GH
delete from DH_GH
where TT_GH=N'không nhận'
--Câu 1: Liệt kê những thành viên (shipper) có họ tên bắt đầu là ký tự ‘Tr’
select * from TV_GH
where TENTV_GH like N'TR%'
--Câu 2: Liệt kê những đơn hàng có Ngày Giao Hàng nằm trong năm 2022 và có khu vực giao hàng là “Ngô Mây”.
select MADH_GH from DH_GH
where year(NGAY_GH) =2022 and DC_GH= N'NGÔ MÂY'
Câu 3: Liệt kê MaDHG, MaTV, Ngày giao hàng, tên thành viên giao hàng,
PhuongThucThanhToan của tất cả những đơn hàng có trạng thái là “Da giao hang”.
Kết quả hiển thị được sắp xếp tăng dần theo NgayGiaoHang và giảm dần theo
PhuongThucThanhToan
select MADH_GH,MATV_GH,NGAY_GH,TEN_NG_NHAN,PTTT from dh_gh
where TT_GH=N'Nhận Hàng'
order by NGAY_GH asc, PTTT DESC
--Câu 4: Liệt kê những thành viên có giới tính là “Nam” và chưa từng được giao hàng lần nào.
select TV.MATV_GH from TV_GH as TV left join DH_GH as DH
on TV.MATV_GH = DH.MATV_GH
where DH.MATV_GH is null and TV.GT='1'
--Câu 5: Liệt kê họ tên của những khách hàng đang có trong hệ thống. Nếu họ tên trùng nhau thì chỉ hiển thị 1 lần. Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau
select tenkh from khachhang
group by tenkh
Câu 8: Liệt kê MaKH, TenKH, địa chỉ nhận hang, MaDHG,
PhuongThucThanhToan, TrangThaiGiaoHang của tất cả các khách hàng đang có
trong hệ thống
select makh,ten_ng_nhan,dc_gh,pttt,tt_gh from dh_gh
Câu 9: Liệt kê những thành viên giao hàng có giới tính là “Nu” và từng giao hàng
cho 10 khách hàng khác nhau ở khu vực giao hàng là “Đống Đa”
select * from tv_gh
select * from dh_gh
select distinct tv.tentv_gh as N'Tên thành viên' from tv_gh as tv join dh_gh as dh
on tv.matv_gh=dh.matv_gh
where tv.gt='0' and dh.dc_gh=N'Đống Đa' and tv.matv_gh
in (select matv_gh from dh_gh group by makh,matv_gh having count(*)= 1 )
Câu 10: Liệt kê những khách hàng đã từng yêu cầu giao hàng tại khu vực “Lê Hồng
Phong” và
chưa từng được một thành viên giao hàng nào có giới tính là “Nam” nhận giao hàng
select kh.makh,kh.tenkh from khachhang as kh join dh_gh as dh
on kh.makh=dh.makh
join tv_gh as tv
on tv.matv_gh=dh.matv_gh
where kh.dc_nhanhang=N'Lê Hồng Phong' and tv.gt='1' and tv.matv_gh in (select matv_gh from dh_gh)
Câu 11: Cho biết những đơn hàng có tổng số lượng hàng giao >50
select c.madh_gh,c.tenspgiao from dh_gh as dh join ctdh as c
on dh.madh_gh=c.madh_gh
group by c.madh_gh,c.tenspgiao
having sum(soluong) >50
Câu 12:Cho biết tháng 4 có bao nhiêu đơn hàng.
select * from dh_gh
select count(*) as N'Tổng số đơn hàng của tháng 4' from dh_gh
where month(ngay_gh)=4
group by month(ngay_gh)
--THỦ TỤC 
Câu 1: Viết thủ tục đếm xem nhân viên A nào đó giao được bao nhiêu lần trong
tháng này (nhân viên A là mã nhân viên giao hàng là tham số đầu vào)
select * from tv_gh
select * from dh_gh
create procedure prcnhanvien (@matv varchar(5))
as
begin
select count(*) as N'Số đơn mà nhân viên đã giao hàng' from tv_gh as tv join dh_gh as dh
on tv.matv_gh=dh.matv_gh
where @matv=tv.matv_gh
group by dh.matv_gh
end
exec prcnhanvien 'tv04'
Câu 2: Viết thủ tục tính tổng số lượng hàng giao cho 1 mã loại hàng giao nào đó.
select * from cthd
create procedure prctongsoluong (@mahanggiao varchar(5))
as
begin
select sum(soluong) as 'Tổng số lượng hàng đã giao' from cthd
where @mahanggiao=madh_gh
group by madh_gh
end
exec prctongsoluong 'DH01' 
Câu 3: Viết thủ tục cho biết số đơn hàng mỗi nhân viên giao được trong năm 2022
select * from dh_gh
create procedure prosodonhang as
begin
select matv_gh,count(*) as N'tổng số đơn hàng mà nhân viên đó đã giao trong năm 2022' from dh_gh
where year(ngay_gh)= 2022
group by matv_gh
end
exec prosodonhang
--HÀM
Câu 1: Viết hàm trả về tổng số lượng của 1 hóa đơn
create function funtongsoluong (@mahoadon varchar(5))
returns int
as
begin
return (select sum(soluong) from cthd where madh_gh =@mahoadon group by madh_gh)
end
select dbo.funtongsoluong ('DH01') as N'tổng số đơn hàng'
Câu 2: Viết hàm trả về một bảng gồm những thông tin, MADHG, ngày giao hàng,
nhân viên giao hàng, trạng thái giao hàng.
create function funthongtin ()
returns table
as
return (select madh_gh, ngay_gh,matv_gh,tt_gh from dh_gh)
select * from funthongtin()
Câu 3: Viết hàm trả về 1 bảng gồm những thông tin MADHG, ngày giao hàng, nhân
viên giao hàng, khảng thời gian giao hàng.
create function funthongtin3 ()
returns table
as
return (select dh.madh_gh, dh.ngay_gh,dh.matv_gh,dh.ma_khoang_tg_gh,k.mota from dh_gh as dh join ktg as k
on dh.ma_khoang_tg_gh=k.ma_khoang_tg_gh)
select * from funthongtin3()
--trigger
--Câu 1: Viết Trigger thực hiện công việc chỉ thêm dữ liệu cho bản CTHD khi mã giao hàng có trong bảng LMH nếu không có thì thông báo không có mã loại hàng này.
create trigger trigadd on cthd
for insert
as
begin
declare @magiaohang varchar(5)
select @magiaohang= malmh from inserted
if (@magiaohang not in (select malmh from lmh))
begin
rollback tran
print(N'Không được thêm mã dữ liệu vào cthd khi mã lmh không tồn tại trong bảng lmh')
end
end

--Câu 2: Viết Trigger thực hiện công việc sửa số lượng thành 50 trong bảng CTHD cho đơn hàng “DH01”
create trigger triggsua on cthd
for update, insert,delete
as
begin
declare @soluong int
select @soluong=soluong from cthd
where madh_gh='DH01'
if (@soluong != 50) 
begin
update cthd
set soluong =50
where madh_gh='DH01'
print(N'Đã update toàn bộ số lượng DH01 thành 50')
end
end
---test câu trigger
update cthd
set soluong =22
where madh_gh='DH01'