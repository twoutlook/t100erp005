/* 
================================================================================
檔案代號:xcas_t
檔案名稱:每月成本差異分攤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xcas_t
(
xcasent       number(5)      ,/* 企業編號 */
xcasld       varchar2(5)      ,/* 帳別 */
xcascomp       varchar2(10)      ,/* 法人 */
xcas001       number(5,0)      ,/* 年度 */
xcas002       number(5,0)      ,/* 期別 */
xcas003       varchar2(10)      ,/* 類型編號 */
xcas004       varchar2(24)      ,/* 科目編號 */
xcas005       varchar2(80)      ,/* 摘要 */
xcas006       varchar2(1)      ,/* 借/貸 */
xcas007       number(20,6)      /* 金額 */
);
alter table xcas_t add constraint xcas_pk primary key (xcasent,xcasld,xcas001,xcas002,xcas003,xcas004) enable validate;

create unique index xcas_pk on xcas_t (xcasent,xcasld,xcas001,xcas002,xcas003,xcas004);

grant select on xcas_t to tiptop;
grant update on xcas_t to tiptop;
grant delete on xcas_t to tiptop;
grant insert on xcas_t to tiptop;

exit;
