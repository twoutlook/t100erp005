/* 
================================================================================
檔案代號:dzbd_t
檔案名稱:section設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzbd_t
(
dzbdstus       varchar2(10)      ,/* no use */
dzbd001       varchar2(20)      ,/* 代碼編號 */
dzbd002       varchar2(60)      ,/* section編號 */
dzbd003       number(10)      ,/* section版次 */
dzbd004       varchar2(1)      ,/* 使用標示 */
dzbd098       clob      ,/* section內容 */
dzbdownid       varchar2(20)      ,/* 資料所有者 */
dzbdowndp       varchar2(10)      ,/* 資料所屬部門 */
dzbdcrtid       varchar2(20)      ,/* 資料建立者 */
dzbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzbdcrtdt       timestamp(0)      ,/* 資料創建日 */
dzbdmodid       varchar2(20)      ,/* 資料修改者 */
dzbdmoddt       timestamp(0)      ,/* 最近修改日 */
dzbd005       varchar2(40)      /* 客戶代號 */
);
alter table dzbd_t add constraint dzbd_pk primary key (dzbd001,dzbd002,dzbd003,dzbd004) enable validate;

create unique index dzbd_pk on dzbd_t (dzbd001,dzbd002,dzbd003,dzbd004);

grant select on dzbd_t to tiptop;
grant update on dzbd_t to tiptop;
grant delete on dzbd_t to tiptop;
grant insert on dzbd_t to tiptop;

exit;
