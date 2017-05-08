/* 
================================================================================
檔案代號:wsfd_t
檔案名稱:模塊服務清單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsfd_t
(
wsfd001       varchar2(10)      ,/* 集成模塊代碼 */
wsfd002       varchar2(40)      ,/* 服務規格編號 */
wsfd003       varchar2(255)      ,/* 服務編碼 */
wsfdstus       varchar2(10)      ,/* 狀態碼 */
wsfdownid       varchar2(20)      ,/* 資料所有者 */
wsfdowndp       varchar2(10)      ,/* 資料所屬部門 */
wsfdcrtid       varchar2(20)      ,/* 資料建立者 */
wsfdcrtdp       varchar2(10)      ,/* 資料建立部門 */
wsfdcrtdt       timestamp(0)      ,/* 資料創建日 */
wsfdmodid       varchar2(20)      ,/* 資料修改者 */
wsfdmoddt       timestamp(0)      /* 最近修改日 */
);
alter table wsfd_t add constraint wsfd_pk primary key (wsfd001,wsfd002) enable validate;

create unique index wsfd_pk on wsfd_t (wsfd001,wsfd002);

grant select on wsfd_t to tiptop;
grant update on wsfd_t to tiptop;
grant delete on wsfd_t to tiptop;
grant insert on wsfd_t to tiptop;

exit;
