/* 
================================================================================
檔案代號:dzgm
檔案名稱:報表元件與內容版次對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzgm
(
dzgm001       varchar2(20)      ,/* 報表元件代號 */
dzgm002       varchar2(15)      ,/* 版次 */
dzgm003       varchar2(60)      ,/* 識別碼 */
dzgm004       varchar2(15)      ,/* 識別碼版次 */
dzgm005       varchar2(10)      ,/* 識別碼類型 */
dzgm006       varchar2(1)      ,/* 使用標示 */
dzgm007       varchar2(1)      ,/* 內容引用否 */
dzgm008       varchar2(20)      ,/* ERP版本 */
dzgmownid       varchar2(10)      ,/* 資料所有者 */
dzgmowndp       varchar2(10)      ,/* 資料所屬部門 */
dzgmcrtid       varchar2(10)      ,/* 資料建立者 */
dzgmcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzgmcrtdt       date      ,/* 資料創建日 */
dzgmmodid       varchar2(10)      ,/* 資料修改者 */
dzgmmoddt       date      ,/* 最近修改日 */
dzgmstus       varchar2(10)      /* 狀態碼 */
);
alter table dzgm add constraint dzgm_pk primary key (dzgm001,dzgm002,dzgm003) enable validate;


grant select on dzgm to tiptop;
grant update on dzgm to tiptop;
grant delete on dzgm to tiptop;
grant insert on dzgm to tiptop;

exit;
