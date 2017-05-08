/* 
================================================================================
檔案代號:lopb_t
檔案名稱:背景排程作業執行紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table lopb_t
(
lopbent       number(5)      ,/* 企業代碼 */
lopb000       varchar2(20)      ,/* 背景排程作業執行序號 */
lopb001       varchar2(10)      ,/* 排程編號 */
lopb002       date      ,/* 排程開始時間 */
lopb003       varchar2(1)      /* 排程執行狀態 */
);
alter table lopb_t add constraint lopb_pk primary key (lopbent,lopb000) enable validate;


grant select on lopb_t to tiptop;
grant update on lopb_t to tiptop;
grant delete on lopb_t to tiptop;
grant insert on lopb_t to tiptop;

exit;
