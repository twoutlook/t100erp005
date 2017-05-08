/* 
================================================================================
檔案代號:dzyb_t
檔案名稱:作業名稱相關表格
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzyb_t
(
dzyb001       varchar2(20)      ,/* 作業名稱 */
dzyb002       varchar2(15)      ,/* 資料表名稱 */
dzyb003       varchar2(1)      ,/* 主表否 */
dzyb004       varchar2(20)      ,/* 主要資料條件欄位 */
dzyb005       varchar2(20)      ,/* 創建日欄位名稱 */
dzyb006       varchar2(20)      ,/* 修改日欄位名稱 */
dzyb007       varchar2(1)      ,/* no use */
dzyb008       varchar2(100)      ,/* 次要資料條件欄位 */
dzyb009       varchar2(20)      /* no use */
);
alter table dzyb_t add constraint dzyb_pk primary key (dzyb001,dzyb002) enable validate;

create unique index dzyb_pk on dzyb_t (dzyb001,dzyb002);

grant select on dzyb_t to tiptop;
grant update on dzyb_t to tiptop;
grant delete on dzyb_t to tiptop;
grant insert on dzyb_t to tiptop;

exit;
