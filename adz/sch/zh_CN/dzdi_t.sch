/* 
================================================================================
檔案代號:dzdi_t
檔案名稱:名稱多語言對照檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdi_t
(
dzdi001       varchar2(15)      ,/* 檔案編號 */
dzdi002       varchar2(20)      ,/* 欄位代碼 */
dzdi003       varchar2(500)      ,/* KEY值序列 */
dzdi004       varchar2(6)      ,/* 語言別 */
dzdi005       varchar2(500)      ,/* 各語言別下的名稱 */
dzdiownid       varchar2(20)      ,/* 資料所有者 */
dzdiowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdicrtid       varchar2(20)      ,/* 資料建立者 */
dzdicrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdicrtdt       timestamp(0)      ,/* 資料創建日 */
dzdimodid       varchar2(20)      ,/* 資料修改者 */
dzdimoddt       timestamp(0)      ,/* 最近修改日 */
dzdicnfid       varchar2(20)      ,/* 資料確認者 */
dzdicnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzdi_t add constraint dzdi_pk primary key (dzdi001,dzdi002,dzdi003,dzdi004) enable validate;

create unique index dzdi_pk on dzdi_t (dzdi001,dzdi002,dzdi003,dzdi004);

grant select on dzdi_t to tiptop;
grant update on dzdi_t to tiptop;
grant delete on dzdi_t to tiptop;
grant insert on dzdi_t to tiptop;

exit;
