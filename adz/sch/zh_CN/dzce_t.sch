/* 
================================================================================
檔案代號:dzce_t
檔案名稱:校驗帶值參數設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzce_t
(
dzcestus       varchar2(10)      ,/* 狀態碼 */
dzce001       varchar2(20)      ,/* 校驗帶值識別碼 */
dzce002       number(10,0)      ,/* 參數順序 */
dzce003       varchar2(1)      ,/* 客製 */
dzce004       varchar2(20)      ,/* 參數名稱 */
dzce005       varchar2(80)      ,/* No Use */
dzce006       varchar2(20)      ,/* No Use */
dzce007       varchar2(10)      ,/* No Use */
dzceownid       varchar2(20)      ,/* 資料所有者 */
dzceowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcecrtid       varchar2(20)      ,/* 資料建立者 */
dzcecrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcecrtdt       timestamp(0)      ,/* 資料創建日 */
dzcemodid       varchar2(20)      ,/* 資料修改者 */
dzcemoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzce_t add constraint dzce_pk primary key (dzce001,dzce002,dzce003) enable validate;

create unique index dzce_pk on dzce_t (dzce001,dzce002,dzce003);

grant select on dzce_t to tiptop;
grant update on dzce_t to tiptop;
grant delete on dzce_t to tiptop;
grant insert on dzce_t to tiptop;

exit;
