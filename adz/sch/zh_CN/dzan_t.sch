/* 
================================================================================
檔案代號:dzan_t
檔案名稱:產生規格及程式介面
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzan_t
(
dzan001       varchar2(20)      ,/* 建構代號 */
dzan002       varchar2(10)      ,/* 建構版號 */
dzan003       number(10)      ,/* 規格版號 */
dzan004       number(10)      ,/* 代碼版號 */
dzan005       varchar2(10)      ,/* 建構類型 */
dzan006       varchar2(10)      ,/* 模組 */
dzan007       varchar2(10)      ,/* 產品代號 */
dzan008       varchar2(10)      ,/* 產品版本 */
dzan009       varchar2(40)      ,/* 客戶代號 */
dzan010       varchar2(1)      ,/* 識別標示 */
dzan011       varchar2(40)      ,/* GUID */
dzan012       varchar2(10)      ,/* 角色 */
dzan013       varchar2(10)      ,/* 儲存類別 */
dzan014       timestamp(0)      ,/* 建立日期 */
dzan015       varchar2(1)      /* 處理碼 */
);
alter table dzan_t add constraint dzan_pk primary key (dzan011,dzan012,dzan013) enable validate;

create unique index dzan_pk on dzan_t (dzan011,dzan012,dzan013);

grant select on dzan_t to tiptop;
grant update on dzan_t to tiptop;
grant delete on dzan_t to tiptop;
grant insert on dzan_t to tiptop;

exit;
