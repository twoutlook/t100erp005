/* 
================================================================================
檔案代號:oobn
檔案名稱:單據流程設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oobn
(
oobnent       number(5)      ,/* 企業編號 */
oobn001       varchar2(10)      ,/* 流程編號 */
oobn002       varchar2(5)      ,/* 前置單別 */
oobn003       varchar2(5)      /* 後置單別 */
);
alter table oobn add constraint oobn_pk primary key (oobnent,oobn001,oobn002,oobn003) enable validate;


grant select on oobn to tiptop;
grant update on oobn to tiptop;
grant delete on oobn to tiptop;
grant insert on oobn to tiptop;

exit;
