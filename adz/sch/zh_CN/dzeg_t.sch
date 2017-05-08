/* 
================================================================================
檔案代號:dzeg_t
檔案名稱:資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzeg_t
(
dzegstus       varchar2(10)      ,/* 狀態碼 */
dzeg001       varchar2(6)      ,/* 語言別 */
dzeg002       varchar2(40)      ,/* 物件類型 */
dzeg003       varchar2(40)      ,/* 物件代號 */
dzeg004       varchar2(255)      ,/* 物件名稱 */
dzeg005       varchar2(500)      ,/* 物件說明 */
dzegownid       varchar2(20)      ,/* 資料所有者 */
dzegowndp       varchar2(10)      ,/* 資料所屬部門 */
dzegcrtid       varchar2(20)      ,/* 資料建立者 */
dzegcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzegcrtdt       timestamp(0)      ,/* 資料創建日 */
dzegmodid       varchar2(20)      ,/* 資料修改者 */
dzegmoddt       timestamp(0)      ,/* 最近修改日 */
dzegcnfid       varchar2(20)      ,/* 資料確認者 */
dzegcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzeg_t add constraint dzeg_pk primary key (dzeg001,dzeg002,dzeg003) enable validate;

create unique index dzeg_pk on dzeg_t (dzeg001,dzeg002,dzeg003);

grant select on dzeg_t to tiptop;
grant update on dzeg_t to tiptop;
grant delete on dzeg_t to tiptop;
grant insert on dzeg_t to tiptop;

exit;
