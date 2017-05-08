/* 
================================================================================
檔案代號:dzcm_t
檔案名稱:複製規格與程式底稿明細1
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcm_t
(
dzcm001       varchar2(10)      ,/* 程式類型 */
dzcm002       varchar2(20)      ,/* 複製來源 */
dzcm003       varchar2(20)      ,/* 複製目標 */
dzcm004       varchar2(1)      ,/* 使用表格欄位轉換 */
dzcm005       varchar2(20)      ,/* 來源表格 */
dzcm006       varchar2(20)      ,/* 目標表格 */
dzcmcrtid       varchar2(20)      ,/* 資料建立者 */
dzcm007       varchar2(15)      ,/* 來源上層表格 */
dzcm008       varchar2(1)      ,/* 來源主要表格 */
dzcm009       varchar2(15)      ,/* 目標上層表格 */
dzcm010       varchar2(1)      ,/* 目標主要表格 */
dzcm011       varchar2(20)      /* 對應順序 */
);
alter table dzcm_t add constraint dzcm_pk primary key (dzcm001,dzcm002,dzcm003,dzcm004,dzcm005,dzcmcrtid) enable validate;

create unique index dzcm_pk on dzcm_t (dzcm001,dzcm002,dzcm003,dzcm004,dzcm005,dzcmcrtid);

grant select on dzcm_t to tiptop;
grant update on dzcm_t to tiptop;
grant delete on dzcm_t to tiptop;
grant insert on dzcm_t to tiptop;

exit;
