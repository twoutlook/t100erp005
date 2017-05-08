/* 
================================================================================
檔案代號:lopc_t
檔案名稱:背景作業執行細項
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table lopc_t
(
lopcent       number(5)      ,/* 企業代碼 */
lopc001       varchar2(20)      ,/* 背景排程作業執行序號 */
lopc002       varchar2(10)      ,/* 排程編號 */
lopc003       number(5,0)      ,/* 執行序號 */
lopc004       varchar2(20)      ,/* 執行作業 */
lopc005       varchar2(500)      ,/* 傳入參數 */
lopc006       varchar2(1)      /* 執行狀態 */
);
alter table lopc_t add constraint lopc_pk primary key (lopcent,lopc001,lopc003,lopc004) enable validate;


grant select on lopc_t to tiptop;
grant update on lopc_t to tiptop;
grant delete on lopc_t to tiptop;
grant insert on lopc_t to tiptop;

exit;
