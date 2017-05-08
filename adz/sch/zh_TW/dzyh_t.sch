/* 
================================================================================
檔案代號:dzyh_t
檔案名稱:需求單說明
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzyh_t
(
dzyh001       varchar2(80)      ,/* 匯入包編號 */
dzyh002       varchar2(10)      ,/* 需求類型 */
dzyh003       varchar2(20)      ,/* 需求單號 */
dzyh004       number(5,0)      ,/* 項次 */
dzyh005       varchar2(500)      ,/* 需求描述 */
dzyh006       varchar2(500)      ,/* 處理描述 */
dzyh007       varchar2(500)      /* 問題與說明 */
);
alter table dzyh_t add constraint dzyh_pk primary key (dzyh001) enable validate;

create unique index dzyh_pk on dzyh_t (dzyh001);

grant select on dzyh_t to tiptop;
grant update on dzyh_t to tiptop;
grant delete on dzyh_t to tiptop;
grant insert on dzyh_t to tiptop;

exit;
