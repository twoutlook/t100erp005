/* 
================================================================================
檔案代號:rmdb_t
檔案名稱:RMA覆出單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmdb_t
(
rmdbent       number(5)      ,/* 企業編號 */
rmdbsite       varchar2(10)      ,/* 營運據點 */
rmdbdocno       varchar2(20)      ,/* 單據單號 */
rmdbseq       number(10,0)      ,/* 項次 */
rmdb001       varchar2(20)      ,/* RMA單號 */
rmdb002       number(10,0)      ,/* RMA項次 */
rmdb003       varchar2(40)      ,/* 料號 */
rmdb004       varchar2(256)      ,/* 產品特徵 */
rmdb005       varchar2(10)      ,/* 單位 */
rmdb006       number(20,6)      ,/* 覆出數量 */
rmdb007       varchar2(10)      ,/* 庫位 */
rmdb008       varchar2(10)      ,/* 儲位 */
rmdb009       varchar2(30)      ,/* 批號 */
rmdb010       varchar2(30)      ,/* 庫存特徵 */
rmdb011       varchar2(255)      ,/* 備註 */
rmdb012       varchar2(1)      ,/* 多庫儲批出貨 */
rmdb013       number(20,6)      ,/* 計價數量 */
rmdb014       varchar2(10)      ,/* 覆出類型 */
rmdb015       number(20,6)      ,/* 單價 */
rmdb016       number(20,6)      ,/* 未稅金額 */
rmdb017       number(20,6)      /* 含稅金額 */
);
alter table rmdb_t add constraint rmdb_pk primary key (rmdbent,rmdbdocno,rmdbseq) enable validate;

create unique index rmdb_pk on rmdb_t (rmdbent,rmdbdocno,rmdbseq);

grant select on rmdb_t to tiptop;
grant update on rmdb_t to tiptop;
grant delete on rmdb_t to tiptop;
grant insert on rmdb_t to tiptop;

exit;
