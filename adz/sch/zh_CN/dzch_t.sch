/* 
================================================================================
檔案代號:dzch_t
檔案名稱:校驗帶值判斷存在資料的值與錯誤訊息之對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzch_t
(
dzchstus       varchar2(10)      ,/* 狀態碼 */
dzch001       varchar2(20)      ,/* 校驗帶值識別碼 */
dzch002       number(10,0)      ,/* 判斷順序 */
dzch003       varchar2(2000)      ,/* 判斷條件 */
dzch004       varchar2(20)      ,/* 對應訊息代號 */
dzchownid       varchar2(20)      ,/* 資料所有者 */
dzchowndp       varchar2(10)      ,/* 資料所屬部門 */
dzchcrtid       varchar2(20)      ,/* 資料建立者 */
dzchcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzchcrtdt       timestamp(0)      ,/* 資料創建日 */
dzchmodid       varchar2(20)      ,/* 資料修改者 */
dzchmoddt       timestamp(0)      ,/* 最近修改日 */
dzch005       varchar2(1)      /* 客製 */
);
alter table dzch_t add constraint dzch_pk primary key (dzch001,dzch002,dzch005) enable validate;

create unique index dzch_pk on dzch_t (dzch001,dzch002,dzch005);

grant select on dzch_t to tiptop;
grant update on dzch_t to tiptop;
grant delete on dzch_t to tiptop;
grant insert on dzch_t to tiptop;

exit;
