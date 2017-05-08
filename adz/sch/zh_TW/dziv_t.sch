/* 
================================================================================
檔案代號:dziv_t
檔案名稱:中介表格視觀表資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dziv_t
(
dziv001       varchar2(20)      ,/* 視觀表ID */
dziv002       varchar2(255)      ,/* 欲建立視觀表Schema */
dziv003       varchar2(10)      ,/* 標準或客製 */
dziv004       clob      ,/* 視觀表Scripts */
dziv005       varchar2(1)      ,/* 視觀表狀態 */
dzivcrtid       varchar2(20)      ,/* 資料建立者 */
dzivcrtdt       timestamp(0)      ,/* 資料創建日 */
dzivmodid       varchar2(20)      ,/* 資料修改者 */
dzivmoddt       timestamp(0)      ,/* 最近修改日 */
dziv006       varchar2(1)      /* 出貨識別 */
);
alter table dziv_t add constraint dziv_pk primary key (dziv001,dziv002,dziv003) enable validate;

create unique index dziv_pk on dziv_t (dziv001,dziv002,dziv003);

grant select on dziv_t to tiptop;
grant update on dziv_t to tiptop;
grant delete on dziv_t to tiptop;
grant insert on dziv_t to tiptop;

exit;
