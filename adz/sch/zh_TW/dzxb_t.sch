/* 
================================================================================
檔案代號:dzxb_t
檔案名稱:代碼設計點設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzxb_t
(
dzxbstus       varchar2(10)      ,/* 狀態碼 */
dzxb001       varchar2(20)      ,/* 代碼編號 */
dzxb002       varchar2(60)      ,/* 代碼設計點 */
dzxb003       varchar2(15)      ,/* 設計點版次 */
dzxb004       varchar2(1)      ,/* 使用標示 */
dzxb098       clob      ,/* 設計點內容 */
dzxb005       varchar2(1)      ,/* 是否引用標準程式 */
dzxb006       varchar2(15)      ,/* 引用版次 */
dzxbownid       varchar2(10)      ,/* 資料所有者 */
dzxbowndp       varchar2(10)      ,/* 資料所屬部門 */
dzxbcrtid       varchar2(10)      ,/* 資料建立者 */
dzxbcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzxbcrtdt       date      ,/* 資料創建日 */
dzxbmodid       varchar2(10)      ,/* 資料修改者 */
dzxbmoddt       date      ,/* 最近修改日 */
dzxb007       varchar2(1)      /* 下方的硬結構代碼整段註解 */
);
alter table dzxb_t add constraint dzxb_pk primary key (dzxb001,dzxb002,dzxb003,dzxb004) enable validate;


grant select on dzxb_t to tiptop;
grant update on dzxb_t to tiptop;
grant delete on dzxb_t to tiptop;
grant insert on dzxb_t to tiptop;

exit;
