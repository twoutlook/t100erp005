/* 
================================================================================
檔案代號:wsab_t
檔案名稱:BPM簽核流程關聯設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsab_t
(
wsabent       number(5)      ,/* 企業編號 */
wsab001       varchar2(20)      ,/* 單據性質 */
wsab002       varchar2(5)      ,/* 參照表編號 */
wsab003       varchar2(5)      ,/* 單據別編號 */
wsab004       varchar2(10)      ,/* 營運據點 */
wsab005       varchar2(100)      ,/* 參考簽核模版 */
wsab006       varchar2(100)      ,/* 簽核流程代號 */
wsab007       varchar2(1)      /* 啟用工作流程 */
);
alter table wsab_t add constraint wsab_pk primary key (wsabent,wsab001,wsab002,wsab003,wsab004) enable validate;

create unique index wsab_pk on wsab_t (wsabent,wsab001,wsab002,wsab003,wsab004);

grant select on wsab_t to tiptop;
grant update on wsab_t to tiptop;
grant delete on wsab_t to tiptop;
grant insert on wsab_t to tiptop;

exit;
