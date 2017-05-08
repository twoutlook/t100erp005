/* 
================================================================================
檔案代號:wsba_t
檔案名稱:BPM單據簽核記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsba_t
(
wsba001       varchar2(10)      ,/* 營運據點 */
wsba002       varchar2(10)      ,/* 單據性質 */
wsba003       varchar2(500)      ,/* 單據組合Key */
wsba004       varchar2(100)      ,/* BPM簽核流程代號 */
wsba005       varchar2(100)      ,/* BPM簽核流程序號 */
wsba006       varchar2(40)      ,/* 簽核時間 */
wsba007       varchar2(1)      ,/* 簽核狀態 */
wsba008       varchar2(500)      /* 簽核意見 */
);
alter table wsba_t add constraint wsba_pk primary key (wsba001,wsba002,wsba003,wsba005,wsba007) enable validate;

create unique index wsba_pk on wsba_t (wsba001,wsba002,wsba003,wsba005,wsba007);

grant select on wsba_t to tiptop;
grant update on wsba_t to tiptop;
grant delete on wsba_t to tiptop;
grant insert on wsba_t to tiptop;

exit;
