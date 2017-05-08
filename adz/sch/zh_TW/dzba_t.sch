/* 
================================================================================
檔案代號:dzba_t
檔案名稱:代碼與內容版本對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzba_t
(
dzbastus       varchar2(10)      ,/* 狀態碼 */
dzba001       varchar2(20)      ,/* 代碼編號 */
dzba002       number(10)      ,/* 代碼版次 */
dzba003       varchar2(60)      ,/* 代碼設計點 */
dzba004       number(10)      ,/* 設計點版次 */
dzba005       varchar2(1)      ,/* 使用標示 */
dzbaownid       varchar2(20)      ,/* 資料所有者 */
dzbaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzbacrtid       varchar2(20)      ,/* 資料建立者 */
dzbacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzbacrtdt       timestamp(0)      ,/* 資料創建日 */
dzbamodid       varchar2(20)      ,/* 資料修改者 */
dzbamoddt       timestamp(0)      ,/* 最近修改日 */
dzba006       number(5,0)      ,/* 函式順序 */
dzba007       varchar2(1)      ,/* 程式引用否 */
dzba008       varchar2(20)      ,/* 產品版本 */
dzba009       varchar2(1)      ,/* 下方的硬結構代碼整段註解 */
dzba010       varchar2(1)      ,/* 客製 */
dzba011       varchar2(40)      ,/* 客戶代號 */
dzba012       varchar2(1)      /* no use */
);
alter table dzba_t add constraint dzba_pk primary key (dzba001,dzba002,dzba003,dzba010) enable validate;

create unique index dzba_pk on dzba_t (dzba001,dzba002,dzba003,dzba010);

grant select on dzba_t to tiptop;
grant update on dzba_t to tiptop;
grant delete on dzba_t to tiptop;
grant insert on dzba_t to tiptop;

exit;
