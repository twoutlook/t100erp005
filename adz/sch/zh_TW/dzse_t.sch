/* 
================================================================================
檔案代號:dzse_t
檔案名稱:Section異動原因資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzse_t
(
dzse001       varchar2(20)      ,/* 程式代號 */
dzse002       varchar2(1000)      ,/* 異動原因 */
dzseownid       varchar2(20)      ,/* 資料所有者 */
dzseowndp       varchar2(10)      ,/* 資料所屬部門 */
dzsecrtid       varchar2(20)      ,/* 資料建立者 */
dzsecrtdp       varchar2(10)      ,/* 資料建立部門 */
dzsecrtdt       timestamp(0)      ,/* 資料創建日 */
dzsemodid       varchar2(20)      ,/* 資料修改者 */
dzsemoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzse_t add constraint dzse_pk primary key (dzse001) enable validate;

create unique index dzse_pk on dzse_t (dzse001);

grant select on dzse_t to tiptop;
grant update on dzse_t to tiptop;
grant delete on dzse_t to tiptop;
grant insert on dzse_t to tiptop;

exit;
