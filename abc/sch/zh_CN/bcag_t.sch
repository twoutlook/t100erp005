/* 
================================================================================
檔案代號:bcag_t
檔案名稱:條碼變革歷程紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcag_t
(
bcagent       number(5)      ,/* 企業代碼 */
bcagsite       varchar2(10)      ,/* 營運據點 */
bcagdocno       varchar2(20)      ,/* 單號 */
bcagseq       number(10,0)      ,/* 項次 */
bcagseq1       number(10,0)      ,/* 項次1 */
bcag001       number(10,0)      ,/* 變更序 */
bcag002       varchar2(20)      ,/* 變更欄位 */
bcag003       varchar2(10)      ,/* 變更類型 */
bcag004       varchar2(255)      ,/* 變更前內容 */
bcag005       varchar2(255)      ,/* 變更後內容 */
bcag006       varchar2(80)      ,/* 最後變更時間 */
bcag007       varchar2(500)      /* 欄位說明SQL */
);
alter table bcag_t add constraint bcag_pk primary key (bcagent,bcagdocno,bcagseq,bcagseq1,bcag001,bcag002) enable validate;

create unique index bcag_pk on bcag_t (bcagent,bcagdocno,bcagseq,bcagseq1,bcag001,bcag002);

grant select on bcag_t to tiptop;
grant update on bcag_t to tiptop;
grant delete on bcag_t to tiptop;
grant insert on bcag_t to tiptop;

exit;
