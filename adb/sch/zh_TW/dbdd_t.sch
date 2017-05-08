/* 
================================================================================
檔案代號:dbdd_t
檔案名稱:寄銷核銷異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table dbdd_t
(
dbddent       number(5)      ,/* 企業編號 */
dbddsite       varchar2(10)      ,/* 營運據點 */
dbdd001       varchar2(10)      ,/* 客戶編號 */
dbdd002       varchar2(10)      ,/* 收貨客戶編號 */
dbdd003       varchar2(20)      ,/* 出貨單號 */
dbdd004       number(10,0)      ,/* 出貨單項次 */
dbdd005       number(10,0)      ,/* 核銷序 */
dbdd006       varchar2(20)      ,/* 合同編號 */
dbdd007       varchar2(40)      ,/* 產品編號 */
dbdd008       varchar2(256)      ,/* 產品特徵 */
dbdd009       varchar2(20)      ,/* 寄銷異動單號 */
dbdd010       number(10,0)      ,/* 寄銷異動項次 */
dbdd011       varchar2(10)      ,/* 寄銷異動類別 */
dbdd012       number(20,6)      ,/* 寄銷異動數量 */
dbdd013       varchar2(10)      ,/* 寄銷銷售單位 */
dbdd014       varchar2(20)      ,/* 正式出貨單號 */
dbdd015       number(10,0)      /* 正式出貨單項次 */
);
alter table dbdd_t add constraint dbdd_pk primary key (dbddent,dbddsite,dbdd001,dbdd002,dbdd003,dbdd004,dbdd005) enable validate;

create unique index dbdd_pk on dbdd_t (dbddent,dbddsite,dbdd001,dbdd002,dbdd003,dbdd004,dbdd005);

grant select on dbdd_t to tiptop;
grant update on dbdd_t to tiptop;
grant delete on dbdd_t to tiptop;
grant insert on dbdd_t to tiptop;

exit;
