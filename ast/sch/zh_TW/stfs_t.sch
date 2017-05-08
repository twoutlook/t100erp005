/* 
================================================================================
檔案代號:stfs_t
檔案名稱:聯營合同模板適用據點設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfs_t
(
stfsent       number(5)      ,/* 企業代碼 */
stfssite       varchar2(10)      ,/* 營運據點 */
stfsunit       varchar2(10)      ,/* 應用組織 */
stfs001       varchar2(20)      ,/* 模板編號 */
stfs002       varchar2(10)      ,/* 門店編號 */
stfsstus       varchar2(10)      /* 狀態碼 */
);
alter table stfs_t add constraint stfs_pk primary key (stfsent,stfs001,stfs002) enable validate;

create unique index stfs_pk on stfs_t (stfsent,stfs001,stfs002);

grant select on stfs_t to tiptop;
grant update on stfs_t to tiptop;
grant delete on stfs_t to tiptop;
grant insert on stfs_t to tiptop;

exit;
