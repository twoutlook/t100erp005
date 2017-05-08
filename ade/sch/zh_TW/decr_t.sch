/* 
================================================================================
檔案代號:decr_t
檔案名稱:門店會員消費統計週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decr_t
(
decrent       number(5)      ,/* 企業編號 */
decrsite       varchar2(10)      ,/* 營運據點 */
decr001       varchar2(10)      ,/* 層級類型 */
decr005       varchar2(10)      ,/* 會員卡種 */
decr006       varchar2(10)      ,/* 會員等級 */
decr007       number(20,6)      ,/* 銷售數量 */
decr008       number(20,6)      ,/* 銷售成本 */
decr009       number(20,6)      ,/* 進價金額 */
decr010       number(20,6)      ,/* 原價金額 */
decr011       number(20,6)      ,/* 未稅金額 */
decr012       number(20,6)      ,/* 應收金額 */
decr013       number(20,6)      ,/* 毛利 */
decr014       number(20,6)      ,/* 毛利率 */
decr015       number(22,2)      ,/* 會員積分 */
decr016       number(20,6)      ,/* 客單數 */
decr017       number(20,6)      ,/* 抵扣券金額 */
decr018       number(20,6)      ,/* 會員折扣金額 */
decr019       number(20,6)      ,/* 實收金額 */
decr020       number(10,0)      ,/* 統計年度月份 */
decr021       number(5,0)      ,/* 統計週期 */
decr022       number(20,6)      /* 客單價 */
);
alter table decr_t add constraint decr_pk primary key (decrent,decrsite,decr005,decr006,decr020,decr021) enable validate;

create unique index decr_pk on decr_t (decrent,decrsite,decr005,decr006,decr020,decr021);

grant select on decr_t to tiptop;
grant update on decr_t to tiptop;
grant delete on decr_t to tiptop;
grant insert on decr_t to tiptop;

exit;
