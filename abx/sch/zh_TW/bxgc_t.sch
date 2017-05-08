/* 
================================================================================
檔案代號:bxgc_t
檔案名稱:保稅盤點折合資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxgc_t
(
bxgcent       number(5)      ,/* 企業編號 */
bxgcsite       varchar2(10)      ,/* 營運據點 */
bxgc000       varchar2(1)      ,/* 類別 */
bxgc001       varchar2(20)      ,/* 標籤編號 */
bxgc002       number(10,0)      ,/* 序號 */
bxgc003       varchar2(40)      ,/* 料件編號 */
bxgc004       number(5,0)      ,/* 年度 */
bxgc005       number(20,6)      ,/* 單位用量 */
bxgc006       number(20,6)      ,/* 摺合數量(庫存單位) */
bxgc007       varchar2(1)      /* 區分 */
);
alter table bxgc_t add constraint bxgc_pk primary key (bxgcent,bxgcsite,bxgc000,bxgc001,bxgc002,bxgc003,bxgc004) enable validate;

create unique index bxgc_pk on bxgc_t (bxgcent,bxgcsite,bxgc000,bxgc001,bxgc002,bxgc003,bxgc004);

grant select on bxgc_t to tiptop;
grant update on bxgc_t to tiptop;
grant delete on bxgc_t to tiptop;
grant insert on bxgc_t to tiptop;

exit;
