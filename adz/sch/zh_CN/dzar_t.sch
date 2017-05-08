/* 
================================================================================
檔案代號:dzar_t
檔案名稱:行業資料同步清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzar_t
(
dzar001       varchar2(20)      ,/* 行業程式代號 */
dzar002       varchar2(10)      ,/* 同步類型 */
dzar003       varchar2(15)      ,/* 資源池表格 */
dzar004       varchar2(60)      ,/* 識別碼 */
dzar005       number(10)      ,/* 識別碼版次 */
dzar006       varchar2(1)      ,/* 使用標示 */
dzar007       varchar2(10)      ,/* 生失效 */
dzar008       varchar2(10)      ,/* no use */
dzar009       varchar2(10)      ,/* no use */
dzar010       varchar2(10)      ,/* no use */
dzarownid       varchar2(20)      ,/* 資料所有者 */
dzarowndp       varchar2(10)      ,/* 資料所屬部門 */
dzarcrtid       varchar2(20)      ,/* 資料建立者 */
dzarcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzarcrtdt       timestamp(0)      ,/* 資料創建日 */
dzarmodid       varchar2(20)      ,/* 資料修改者 */
dzarmoddt       timestamp(0)      ,/* 最近修改日 */
dzar011       clob      ,/* 行業程式內容 */
dzar012       clob      /* 標準程式內容 */
);
alter table dzar_t add constraint dzar_pk primary key (dzar001,dzar003,dzar004) enable validate;

create unique index dzar_pk on dzar_t (dzar001,dzar003,dzar004);

grant select on dzar_t to tiptop;
grant update on dzar_t to tiptop;
grant delete on dzar_t to tiptop;
grant insert on dzar_t to tiptop;

exit;
