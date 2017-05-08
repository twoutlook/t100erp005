/* 
================================================================================
檔案代號:prdt_t
檔案名稱:促銷規則滿額滿量條件資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdt_t
(
prdtent       number(5)      ,/* 企業編號 */
prdtunit       varchar2(10)      ,/* 制定組織 */
prdtsite       varchar2(10)      ,/* 營運組織 */
prdt001       varchar2(30)      ,/* 規則編號 */
prdt002       number(10,0)      ,/* 組別 */
prdt003       varchar2(10)      ,/* 條件類型 */
prdt004       number(10,0)      ,/* 滿額/滿量 */
prdt005       number(10,0)      ,/* 基數 */
prdt006       number(10,0)      ,/* 幅度 */
prdt007       varchar2(10)      ,/* 商品條件 */
prdtstus       varchar2(10)      /* 有效否 */
);
alter table prdt_t add constraint prdt_pk primary key (prdtent,prdt001,prdt002) enable validate;


grant select on prdt_t to tiptop;
grant update on prdt_t to tiptop;
grant delete on prdt_t to tiptop;
grant insert on prdt_t to tiptop;

exit;
