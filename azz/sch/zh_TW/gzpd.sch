/* 
================================================================================
檔案代號:gzpd
檔案名稱:背景作業執行細項
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gzpd
(
gzpdent       number(5)      ,/* 企業代碼 */
gzpd001       varchar2(20)      ,/* 背景排程作業執行序號 */
gzpd002       varchar2(10)      ,/* 排程編號 */
gzpd003       number(5,0)      ,/* 執行序號 */
gzpd004       varchar2(20)      ,/* 執行作業 */
gzpd005       varchar2(500)      ,/* 傳入參數 */
gzpd006       varchar2(1)      /* 執行狀態 */
);
alter table gzpd add constraint gzpd_pk primary key (gzpdent,gzpd001,gzpd003,gzpd004) enable validate;


grant select on gzpd to tiptop;
grant update on gzpd to tiptop;
grant delete on gzpd to tiptop;
grant insert on gzpd to tiptop;

exit;
