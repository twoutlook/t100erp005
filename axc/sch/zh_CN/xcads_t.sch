/* 
================================================================================
檔案代號:xcads_t
檔案名稱:成本BOM主檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table xcads_t
(
xcadsent       number(5)      ,/* 企業編號 */
xcadssite       varchar2(10)      ,/* 營運據點 */
xcads001       varchar2(10)      ,/* 版本 */
xcads002       varchar2(40)      ,/* 主鍵料號 */
xcads003       varchar2(40)      ,/* 元件料號 */
xcads004       varchar2(40)      ,/* 提速值 */
xcads005       number(5,0)      /* 階層 */
);
alter table xcads_t add constraint xcads_pk primary key (xcadsent,xcadssite,xcads001,xcads002,xcads003,xcads004) enable validate;

create unique index xcads_pk on xcads_t (xcadsent,xcadssite,xcads001,xcads002,xcads003,xcads004);

grant select on xcads_t to tiptop;
grant update on xcads_t to tiptop;
grant delete on xcads_t to tiptop;
grant insert on xcads_t to tiptop;

exit;
