/* 
================================================================================
檔案代號:qcaol_t
檔案名稱:品質檢驗判定結果檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table qcaol_t
(
qcaolent       number(5)      ,/* 企業編號 */
qcaol001       varchar2(5)      ,/* 參照表號 */
qcaol002       varchar2(10)      ,/* 判定結果編號 */
qcaol003       varchar2(6)      ,/* 語言別 */
qcaol004       varchar2(500)      ,/* 說明 */
qcaol005       varchar2(10)      /* 助記碼 */
);
alter table qcaol_t add constraint qcaol_pk primary key (qcaolent,qcaol001,qcaol002,qcaol003) enable validate;

create  index qcaol_01 on qcaol_t (qcaol005);
create unique index qcaol_pk on qcaol_t (qcaolent,qcaol001,qcaol002,qcaol003);

grant select on qcaol_t to tiptop;
grant update on qcaol_t to tiptop;
grant delete on qcaol_t to tiptop;
grant insert on qcaol_t to tiptop;

exit;
