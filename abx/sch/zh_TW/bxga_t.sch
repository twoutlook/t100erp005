/* 
================================================================================
檔案代號:bxga_t
檔案名稱:保稅庫存盤點資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxga_t
(
bxgaent       number(5)      ,/* 企業編號 */
bxgasite       varchar2(10)      ,/* 營運據點 */
bxgadocno       varchar2(20)      ,/* 標籤編號 */
bxgadocdt       date      ,/* 盤點日期 */
bxga000       number(5,0)      ,/* 盤點年度 */
bxga001       varchar2(40)      ,/* 料件編號 */
bxga002       varchar2(10)      ,/* 庫位編號 */
bxga003       varchar2(10)      ,/* 儲位編號 */
bxga004       varchar2(30)      ,/* 批號 */
bxga005       varchar2(10)      ,/* 庫存單位 */
bxga006       number(20,6)      ,/* 盤點數量 */
bxga007       varchar2(1)      ,/* 驗收區否 */
bxga008       varchar2(20)      ,/* 盤點人員 */
bxga009       varchar2(10)      ,/* 盤點部門 */
bxga010       varchar2(20)      ,/* 來源盤點卡號 */
bxga011       number(10,0)      ,/* 來源盤點卡號項次 */
bxga012       varchar2(255)      /* 備註 */
);
alter table bxga_t add constraint bxga_pk primary key (bxgaent,bxgadocno) enable validate;

create unique index bxga_pk on bxga_t (bxgaent,bxgadocno);

grant select on bxga_t to tiptop;
grant update on bxga_t to tiptop;
grant delete on bxga_t to tiptop;
grant insert on bxga_t to tiptop;

exit;
