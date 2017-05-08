/* 
================================================================================
檔案代號:dzcn_t
檔案名稱:複製規格與程式底稿明細2
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcn_t
(
dzcn001       varchar2(10)      ,/* 程式類型 */
dzcn002       varchar2(20)      ,/* 複製來源 */
dzcn003       varchar2(20)      ,/* 複製目標 */
dzcn004       varchar2(1)      ,/* 使用表格欄位轉換 */
dzcn005       varchar2(20)      ,/* 來源表格 */
dzcn006       varchar2(20)      ,/* 來源欄位 */
dzcn007       varchar2(20)      ,/* 對應順序 */
dzcn008       varchar2(20)      ,/* 目標表格 */
dzcn009       varchar2(20)      ,/* 目標欄位 */
dzcncrtid       varchar2(20)      /* 資料建立者 */
);
alter table dzcn_t add constraint dzcn_pk primary key (dzcn001,dzcn002,dzcn003,dzcn004,dzcn005,dzcn006,dzcncrtid) enable validate;

create unique index dzcn_pk on dzcn_t (dzcn001,dzcn002,dzcn003,dzcn004,dzcn005,dzcn006,dzcncrtid);

grant select on dzcn_t to tiptop;
grant update on dzcn_t to tiptop;
grant delete on dzcn_t to tiptop;
grant insert on dzcn_t to tiptop;

exit;
