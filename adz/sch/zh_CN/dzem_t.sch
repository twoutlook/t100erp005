/* 
================================================================================
檔案代號:dzem_t
檔案名稱:SA分鏡規格匯入介面檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzem_t
(
dzem001       varchar2(20)      ,/* 規格編號 */
dzem002       varchar2(60)      ,/* 識別碼 */
dzem003       varchar2(30)      ,/* 識別碼類型 */
dzemownid       varchar2(20)      ,/* 資料所有者 */
dzemowndp       varchar2(10)      ,/* 資料所屬部門 */
dzemcrtid       varchar2(20)      ,/* 資料建立者 */
dzemcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzemcrtdt       timestamp(0)      ,/* 資料創建日 */
dzemmodid       varchar2(20)      ,/* 資料修改者 */
dzemmoddt       timestamp(0)      ,/* 最近修改日 */
dzem099       clob      /* 規格描述 */
);
alter table dzem_t add constraint dzem_pk primary key (dzem001,dzem002) enable validate;

create unique index dzem_pk on dzem_t (dzem001,dzem002);

grant select on dzem_t to tiptop;
grant update on dzem_t to tiptop;
grant delete on dzem_t to tiptop;
grant insert on dzem_t to tiptop;

exit;
