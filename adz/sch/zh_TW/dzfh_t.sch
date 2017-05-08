/* 
================================================================================
檔案代號:dzfh_t
檔案名稱:UI樣版設定資訊
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfh_t
(
dzfhstus       varchar2(10)      ,/* 狀態碼 */
dzfh001       varchar2(20)      ,/* UI樣版檔類型 */
dzfh002       varchar2(20)      ,/* 設定類型 */
dzfh003       varchar2(20)      ,/* page點名稱 */
dzfh004       varchar2(20)      ,/* container的tag類型 */
dzfh005       varchar2(20)      ,/* container的tag名稱 */
dzfh006       varchar2(20)      ,/* 插入欄位順序的tag類型 */
dzfh007       varchar2(20)      ,/* 插入欄位順序的tag名稱 */
dzfh008       varchar2(1)      ,/* 子節點是否需刪除 */
dzfh009       varchar2(1)      ,/* 是否為唯一子節點 */
dzfh010       varchar2(1)      ,/* 是否不需處理共用欄位 */
dzfhownid       varchar2(20)      ,/* 資料所有者 */
dzfhowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfhcrtid       varchar2(20)      ,/* 資料建立者 */
dzfhcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfhcrtdt       timestamp(0)      ,/* 資料創建日 */
dzfhmodid       varchar2(20)      ,/* 資料修改者 */
dzfhmoddt       timestamp(0)      ,/* 最近修改日 */
dzfhcnfid       varchar2(20)      ,/* 資料確認者 */
dzfhcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzfh_t add constraint dzfh_pk primary key (dzfh001,dzfh002,dzfh003) enable validate;

create unique index dzfh_pk on dzfh_t (dzfh001,dzfh002,dzfh003);

grant select on dzfh_t to tiptop;
grant update on dzfh_t to tiptop;
grant delete on dzfh_t to tiptop;
grant insert on dzfh_t to tiptop;

exit;
