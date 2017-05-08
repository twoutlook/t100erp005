/* 
================================================================================
檔案代號:prdi_t
檔案名稱:促銷規則申請滿額滿量條件資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdi_t
(
prdient       number(5)      ,/* 企業編號 */
prdiunit       varchar2(10)      ,/* 制定組織 */
prdisite       varchar2(10)      ,/* 營運組織 */
prdidocno       varchar2(20)      ,/* 促銷申請單號 */
prdi001       varchar2(30)      ,/* 規則編號 */
prdi002       number(10,0)      ,/* 組別 */
prdi003       varchar2(10)      ,/* 條件類型 */
prdi004       number(10,0)      ,/* 滿額/滿量 */
prdi005       number(10,0)      ,/* 基數 */
prdi006       number(10,0)      ,/* 幅度 */
prdi007       varchar2(10)      ,/* 商品條件 */
prdiacti       varchar2(10)      /* 有效否 */
);
alter table prdi_t add constraint prdi_pk primary key (prdient,prdidocno,prdi002) enable validate;


grant select on prdi_t to tiptop;
grant update on prdi_t to tiptop;
grant delete on prdi_t to tiptop;
grant insert on prdi_t to tiptop;

exit;
