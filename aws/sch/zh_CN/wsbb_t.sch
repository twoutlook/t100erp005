/* 
================================================================================
檔案代號:wsbb_t
檔案名稱:BPM流程資訊記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsbb_t
(
wsbb001       varchar2(10)      ,/* 營運據點 */
wsbb002       varchar2(10)      ,/* 單據性質 */
wsbb003       varchar2(500)      ,/* 單據組合Key */
wsbb004       varchar2(100)      ,/* BPM工作流程代號 */
wsbb005       varchar2(100)      ,/* BPM工作流程序號 */
wsbb006       varchar2(100)      ,/* 對應前流程序號 */
wsbb007       varchar2(40)      /* 流程發起時間 */
);
alter table wsbb_t add constraint wsbb_pk primary key (wsbb001,wsbb002,wsbb003,wsbb005) enable validate;

create unique index wsbb_pk on wsbb_t (wsbb001,wsbb002,wsbb003,wsbb005);

grant select on wsbb_t to tiptop;
grant update on wsbb_t to tiptop;
grant delete on wsbb_t to tiptop;
grant insert on wsbb_t to tiptop;

exit;
