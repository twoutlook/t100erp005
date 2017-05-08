/* 
================================================================================
檔案代號:wsea_t
檔案名稱:中間庫設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsea_t
(
wsea001       varchar2(15)      ,/* table代號 */
wsea002       varchar2(1)      ,/* 是否依保留天數設定刪除資料 */
wseastus       varchar2(10)      ,/* 狀態碼 */
wseaownid       varchar2(20)      ,/* 資料所有者 */
wseaowndp       varchar2(10)      ,/* 資料所屬部門 */
wseacrtid       varchar2(20)      ,/* 資料建立者 */
wseacrtdp       varchar2(10)      ,/* 資料建立部門 */
wseacrtdt       timestamp(0)      ,/* 資料創建日 */
wseamodid       varchar2(20)      ,/* 資料修改者 */
wseamoddt       timestamp(0)      ,/* 最近修改日 */
wseacnfid       varchar2(20)      ,/* 資料確認者 */
wseacnfdt       timestamp(0)      /* 資料確認日 */
);
alter table wsea_t add constraint wsea_pk primary key (wsea001) enable validate;

create unique index wsea_pk on wsea_t (wsea001);

grant select on wsea_t to tiptop;
grant update on wsea_t to tiptop;
grant delete on wsea_t to tiptop;
grant insert on wsea_t to tiptop;

exit;
