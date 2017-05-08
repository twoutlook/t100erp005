/* 
================================================================================
檔案代號:dece_t
檔案名稱:會員卡儲值日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dece_t
(
deceent       number(5)      ,/* 企業編號 */
dece001       varchar2(10)      ,/* 卡種 */
dece002       date      ,/* 異動日期 */
dece003       number(22,2)      ,/* 本日期初儲值 */
dece004       number(22,2)      ,/* 本日新增儲值 */
dece005       number(22,2)      ,/* 本日使用儲值 */
dece006       number(22,2)      ,/* 本日註銷儲值 */
dece007       number(22,2)      ,/* 本日期末儲值 */
dece008       timestamp(0)      ,/* 日結日期 */
dece009       varchar2(20)      /* 日結人員 */
);
alter table dece_t add constraint dece_pk primary key (deceent,dece001,dece002) enable validate;

create unique index dece_pk on dece_t (deceent,dece001,dece002);

grant select on dece_t to tiptop;
grant update on dece_t to tiptop;
grant delete on dece_t to tiptop;
grant insert on dece_t to tiptop;

exit;
