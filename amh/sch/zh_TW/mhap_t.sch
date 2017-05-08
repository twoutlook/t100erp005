/* 
================================================================================
檔案代號:mhap_t
檔案名稱:非庫存物料領用
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mhap_t
(
mhapent       number(5)      ,/* 企業代碼 */
mhapsite       varchar2(10)      ,/* 營運據點 */
mhapunit       varchar2(10)      ,/* 應用組織 */
mhapdocno       varchar2(20)      ,/* 單據編號 */
mhap001       date      ,/* 單據日期 */
mhap002       varchar2(1)      ,/* 領用類型 */
mhap003       varchar2(10)      ,/* 申請部門 */
mhap004       varchar2(20)      ,/* 申請人員 */
mhap005       varchar2(40)      ,/* 管理品類 */
mhap006       varchar2(40)      ,/* 商品編號 */
mhap007       number(20,6)      ,/* 數量 */
mhap008       number(20,6)      ,/* 費用單價 */
mhap009       number(20,6)      ,/* 費用金額 */
mhap010       varchar2(10)      ,/* 費用對象 */
mhapstus       varchar2(10)      ,/* 狀態碼 */
mhap011       varchar2(1)      ,/* 生成費用單否 */
mhap012       varchar2(20)      ,/* 費用單號 */
mhap013       varchar2(10)      ,/* 費用編號 */
mhap014       varchar2(255)      ,/* 備註 */
mhapownid       varchar2(20)      ,/* 資料所屬者 */
mhapowndp       varchar2(10)      ,/* 資料所屬部門 */
mhapcrtid       varchar2(20)      ,/* 資料建立者 */
mhapcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhapcrtdt       timestamp(0)      ,/* 資料創建日 */
mhapmodid       varchar2(20)      ,/* 資料修改者 */
mhapmoddt       timestamp(0)      ,/* 最近修改日 */
mhapcnfid       varchar2(20)      ,/* 資料確認者 */
mhapcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table mhap_t add constraint mhap_pk primary key (mhapent,mhapdocno) enable validate;

create unique index mhap_pk on mhap_t (mhapent,mhapdocno);

grant select on mhap_t to tiptop;
grant update on mhap_t to tiptop;
grant delete on mhap_t to tiptop;
grant insert on mhap_t to tiptop;

exit;
