/* 
================================================================================
檔案代號:dzel_t
檔案名稱:欄位類別定義主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzel_t
(
dzelstus       varchar2(10)      ,/* 狀態碼 */
dzel001       varchar2(80)      ,/* 欄位類別定義代號 */
dzel002       varchar2(255)      ,/* 欄位類別定義名稱 */
dzel003       varchar2(10)      ,/* 模組代號 */
dzel004       varchar2(500)      ,/* 用途描述 */
dzel005       varchar2(1)      ,/* 是否為群組 */
dzel006       varchar2(1)      ,/* 是否啟動 */
dzel007       varchar2(1)      ,/* 是否為功能性表格 */
dzel008       varchar2(20)      ,/* 附屬表格代表碼 */
dzel009       number(10,0)      ,/* 排列序號 */
dzelownid       varchar2(20)      ,/* 資料所有者 */
dzelowndp       varchar2(10)      ,/* 資料所屬部門 */
dzelcrtid       varchar2(20)      ,/* 資料建立者 */
dzelcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzelcrtdt       timestamp(0)      ,/* 資料創建日 */
dzelmodid       varchar2(20)      ,/* 資料修改者 */
dzelmoddt       timestamp(0)      ,/* 最近修改日 */
dzelcnfid       varchar2(20)      ,/* 資料確認者 */
dzelcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzel_t add constraint dzel_pk primary key (dzel001) enable validate;

create unique index dzel_pk on dzel_t (dzel001);

grant select on dzel_t to tiptop;
grant update on dzel_t to tiptop;
grant delete on dzel_t to tiptop;
grant insert on dzel_t to tiptop;

exit;
