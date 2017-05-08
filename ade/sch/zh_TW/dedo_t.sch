/* 
================================================================================
檔案代號:dedo_t
檔案名稱:門店會員消費統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedo_t
(
dedoent       number(5)      ,/* 企業編號 */
dedosite       varchar2(10)      ,/* 營運據點 */
dedo001       varchar2(10)      ,/* 層級類型 */
dedo005       varchar2(10)      ,/* 會員卡種 */
dedo006       varchar2(10)      ,/* 會員等級 */
dedo007       number(20,6)      ,/* 銷售數量 */
dedo008       number(20,6)      ,/* 銷售成本 */
dedo009       number(20,6)      ,/* 進價金額 */
dedo010       number(20,6)      ,/* 原價金額 */
dedo011       number(20,6)      ,/* 未稅金額 */
dedo012       number(20,6)      ,/* 應收金額 */
dedo013       number(20,6)      ,/* 毛利 */
dedo014       number(20,6)      ,/* 毛利率 */
dedo015       number(22,2)      ,/* 會員積分 */
dedo016       number(20,6)      ,/* 客單數 */
dedo017       number(20,6)      ,/* 抵扣券金額 */
dedo018       number(20,6)      ,/* 會員折扣金額 */
dedo019       number(20,6)      ,/* 實收金額 */
dedo020       number(5,0)      ,/* 統計年度 */
dedo021       number(5,0)      ,/* 統計月份 */
dedo022       number(20,6)      /* 客單價 */
);
alter table dedo_t add constraint dedo_pk primary key (dedoent,dedosite,dedo005,dedo006,dedo020,dedo021) enable validate;

create unique index dedo_pk on dedo_t (dedoent,dedosite,dedo005,dedo006,dedo020,dedo021);

grant select on dedo_t to tiptop;
grant update on dedo_t to tiptop;
grant delete on dedo_t to tiptop;
grant insert on dedo_t to tiptop;

exit;
