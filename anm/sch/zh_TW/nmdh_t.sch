/* 
================================================================================
檔案代號:nmdh_t
檔案名稱:XML資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmdh_t
(
nmdh001       varchar2(20)      ,/* 流水號 */
nmdh002       varchar2(40)      ,/* 父節點名稱 */
nmdh003       varchar2(500)      ,/* 父節點值 */
nmdh004       varchar2(40)      ,/* 子節點名稱 */
nmdh005       varchar2(500)      ,/* 子節點值 */
nmdh006       varchar2(20)      ,/* 對應ERP欄位名 */
nmdh007       varchar2(15)      /* 對應ERP表名 */
);
alter table nmdh_t add constraint nmdh_pk primary key (nmdh001,nmdh002,nmdh003,nmdh004,nmdh005) enable validate;

create unique index nmdh_pk on nmdh_t (nmdh001,nmdh002,nmdh003,nmdh004,nmdh005);

grant select on nmdh_t to tiptop;
grant update on nmdh_t to tiptop;
grant delete on nmdh_t to tiptop;
grant insert on nmdh_t to tiptop;

exit;
