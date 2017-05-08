/* 
================================================================================
檔案代號:wscc_t
檔案名稱:記錄ETL發生的錯誤
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wscc_t
(
wscc001       varchar2(40)      ,/* JOB ID 編號 */
wscc002       number(5,0)      ,/* 序號 */
wsccent       number(5)      ,/* 企業編碼 */
wscc003       varchar2(40)      ,/* 錯誤代碼 */
wscc004       varchar2(255)      /* 錯誤訊息 */
);
alter table wscc_t add constraint wscc_pk primary key (wscc001,wscc002,wsccent) enable validate;

create unique index wscc_pk on wscc_t (wscc001,wscc002,wsccent);

grant select on wscc_t to tiptop;
grant update on wscc_t to tiptop;
grant delete on wscc_t to tiptop;
grant insert on wscc_t to tiptop;

exit;
