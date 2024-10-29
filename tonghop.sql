--1. Liệt kê những khách hàng có địa chỉ ở quy nhơn
use QLBANHANG
select * from khachhang
where diachi= N'Quy Nhơn'
--2. Liệt kê những đơn hàng có trị giá >100000 và nhỏ hơn 300000
select * from hoadon 
where trigia > 100000 and trigia < 300000
--3. Liệt kê những nhân viên có thâm nên công tác 20 năm và có họ bắt đầu bằng chữ N
select * from nhanvien
select manv,hoten,datediff(year,ngaylamviec,GETDATE) AS 'NAM THAM NIEN' from nhanvien
where datediff(year,ngaylamviec,GETDATE) >10 and hoten = N'N%'
---4. Liệt kê những sản phẩm có số lượng bán >50
select * from CTHD 
where soluong>50
--5. Liệt kê những khách hàng mua nước hoa thông tin gồm họ tên, địa chỉ, số hd, tên sản phẩm
select * from khachhang
select * from hoadon
select * from sanpham
select * from CTHD
select * from nhanvien
select hd.soHD,kh.hoten,kh.diachi,sp.tensp from khachhang as kh,hoadon as hd,sanpham as sp
where kh.Makh=hd.makh and tensp like N'NƯỚC HOA'
--6. Liệt kê những sản phẩm có số lượng bán >10 và nhỏ hơn 20
select soluong from CTHD
where soluong > 10 and soluong <20
--7. Cho biết khách hàng kh01 mua mấy đơn hàng
select count(soHD) from hoadon
where makh like 'KH01'
--8. Cho biết những nhân viên bán được 2 hóa đơn
select sohd,manv from hoadon
group by soHD,manv
having count(sohd) =2
--9. Cho biết số lần bán của sản phẩm sp01
select count(masp) as 'số lần bán'  from CTHD
where masp like 'SP01'
--10.Cho biết mặt hàng nào bán số lượng nhiều nhất
select top 1 max(c.soluong) as 'số lượng cao nhất',tensp  from cthd as c,sanpham as sp
where c.masp=sp.masp
group by tensp
order by max(c.soluong) desc
--11.Cho biết sản phẩm nào xuất nhiều lần nhất.
select top 1 c.masp,sp.tensp, sum(c.soluong) as N'Tổng số lượng bán nhiều nhất' from cthd as c join sanpham as sp
on c.masp= sp.masp
group by c.masp,tensp
order by sum(c.soluong) desc
--12.Cho biết khách hàng nào chưa mua hàng
select makh from khachhang
where makh not in (select makh from hoadon)
--13.Cho biết những khách hàng nào mua nhiều hóa đơn nhất.
select makh,count(sohd) as 'số lượng hóa đơn' from hoadon
group by makh
--14.Cập nhật dữ liệu trên trường Gia giảm 10% so với giá hiện tại, chỉ cập nhật
--giá cho những sản phẩm có số lần bán nhỏ hơn 3.
update dbo.CTHD
set giaban=giaban*0.9
where soluong in (select soluong from cthd where soluong<3)
--15.Liệt kê thông tin chi tiết về các đơn hàng của các khách hàng mà từ này
--10/12/2022 đến nay không mua hàng nữa.
select * from hoadon
where (ngayhd)< '2022-12-10'
--16.Truy vấn tạo bảng Nhanvientot, dữ liệu lấy từ bảng nhanvien, gồm 20% số
--Nhân viên có từ 2 đơn hàng trở lên.
select * into nhanvientot from nhanvien
where manv in (select top 2 manv from hoadon group by manv having count(*) >=2 )
select * from nhanvientot
--17.Thống kế số lượng bán của mỗi sản phẩm nếu tổng số lượng >100 thì xuất ra
--bán đắt ngược lại thì bình thường
create function tksl (@masp varchar(5))
returns nvarchar(20)
as
begin
declare @tongsl int
declare @trangthaiban nvarchar(20)
select @tongsl= sum(soluong) from cthd 
where masp= @masp
if (@tongsl > 400)
set @trangthaiban = N'Bán đắt'
else
set @trangthaiban =N'Bán bình thường'
return @trangthaiban
end
go
select dbo.tksl ('SP01') as N'trạng thái'
drop function dbo.tksl
--18.Tỷ lệ % của tổng số lượng bán so với số lượng hiện có của từng sản phẩm
create function tiletong(@masp varchar (10))
returns float
as
begin
declare @tongslban int
select @tongslban = sum(soluong) from cthd
where masp=@masp
group by masp
declare @soluongnhap int
select @soluongnhap= soluong from sanpham
where masp= @masp
declare @slhienco float
set @slhienco= @soluongnhap - @tongslban
return @slhienco /@tongslban *100
end
--19.Xóa những bản ghi có số lượng bán <15 và bán trong tháng 2
 delete from cthd 
 where sohd in (select sohd from hoadon where month(ngayHD)=2) and soluong <15

--20.Xóa những đơn hàng có sản phẩm có tên bắt đầu bằng chữ N
select * from CTHD
delete  from cthd
where masp in (select masp from sanpham where tensp like 'N%')
--21.Viết thủ tục Cho biết chi tiết danh sách các đơn hàng của nhân viên x(x tham số đầu vào)
select * from hoadon
go
create proc chitietdsdohang (@manhanvien varchar(5)) 
as
begin
select * from hoadon where manv=@manhanvien
end
go
execute pronhanvienx 'nv001'
--22.Viết thủ tục cho biết danh sách những mặt hàng bán với số lượng thuộc đoạn [a..b] (a, b là tham số đầu vào)
select * from cthd
go
create procedure promathang (@soluonga int, @soluongb int)
as
begin
select * from cthd where soluong between @soluonga and @soluongb
end
go
execute promathang'100','200'
--23.Viết thủ tục in ra chi tiết các sản phẩm có số lượng =20
select * from sanpham
go
create procedure prcsanpham
as
begin
select * from sanpham where soluong =20
end
go
execute prcsanpham
--24.Viết hàm cho biết tổng số lượng bán của mặt hàng x(x là mã sản phâm tham số đầu vào)
select * from cthd
go
create function tongslban (@masp varchar(5))
returns int
as
begin
return (select sum(soluong) as[Tổng số lượng bán] from cthd where masp =@masp group by masp )
end
go
select dbo.tongslban('SP01') as 'Tổng số lượng bán'

--25.Viết hàm cho biết số đơn hàng bán được trong ngày x (x tham số đầu vào)
select * from hoadon
select * from cthd
go
create function hangbandc (@ngay int)
returns int
as
begin
declare @sodonhang int
select @sodonhang=count(*) from hoadon as hd join cthd as c 
on hd.sohd=c.sohd 
where day(hd.ngayhd) =@ngay group by day(hd.ngayhd)
return @sodonhang
end
go
select dbo.hangbandc ('12') as 'Số đơn hàng được bán trong ngày x'
-- 26.Hàm ôn các hàm trong bài tập thực hành
--27.Viết trigger không cho phép nhân viến lập thêm hóa đơn nếu nhân viên đã có 2 đơn hàng trong ngày.
create trigger trignhanvien on cthd
for insert
as
begin
declare @manv_co2donhang varchar(5)
select @manv_co2donhang = hd.manv from hoadon as hd join cthd as c
on c.sohd=hd.sohd 
group by day(hd.ngayhd),manv
having count(*) =2
declare @manvhd varchar(5)
select @manvhd = manv from hoadon
if (@manvhd = @manv_co2donhang)
begin
rollback tran
print(N'Không thể thêm vì nhân viên này đã lập hoá đơn 2 lần trong 1 ngày')
end
end
--28.Viết trigger chỉ cho xóa những sản phẩm bán từ 2 lần trở xuống (bảng Sản phẩm)
create trigger trigsanpham on cthd
after delete
as
begin
declare @a char(10)
select @a=count(*) from deleted
group by masp
if (@a >=2)
begin
rollback transaction
print(N'Không được xoá những sản phẩm đã được bán từ 2 lần trở lên')
end
end
-- 29.Viêt trigger chỉ cho bán số lượng nhỏ hơn số lượng của sản phẩm hiện có trong công ty
create trigger trigban on cthd
for insert
as
begin
declare @addsoluong int
select @addsoluong=soluong from inserted
declare @soluongnhap int
select @soluongnhap=soluong from sanpham
where masp = (select masp from inserted)
declare @soluongdaban int
select @soluongdaban= sum(soluong) from cthd
where masp= (select masp from inserted)
group by masp
declare @soluonghienco int
set @soluonghienco=@soluongnhap-@soluongdaban
if (@addsoluong > @soluonghienco)
begin
rollback tran
print(N'sản phẩm bán phải bé hơn sản phẩm hiện có')
end
end
--30.Viết trigger kiểm soát việc cập nhật thông tin sản phẩm: không cho phép cập nhật thông tin của sản phẩm nếu sản phẩm đó đã được bán.
create trigger trigupdate on sanpham
for update
as
begin
if exists(select masp from cthd
where masp in (select masp from inserted))
begin
rollback tran
print(N'Không cho phép update các sản phẩm đã được bán trong bảng cthd')
end
end
---thu trigger
update sanpham
set soluong=77
where masp='sp02'