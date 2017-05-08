/* 
================================================================================
檔案代號:dzfc_t
檔案名稱:畫面樣版架構表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfc_t
(
dzfcstus       varchar2(10)      ,/* 狀態碼 */
dzfc001       varchar2(20)      ,/* 畫面樣版類型 */
dzfc002       number(5,0)      ,/* 編號(流水號) */
dzfc003       number(5,0)      ,/* 父節點編號 */
dzfc004       number(5,0)      ,/* 順序(同階層中的排序) */
dzfc005       varchar2(10)      ,/* 節點類型 */
dzfc006       varchar2(20)      ,/* 4fd tag 類型 */
dzfc007       varchar2(20)      ,/* 4fd tag name */
dzfc008       varchar2(10)      ,/* 可插入的子節點類型 */
dzfc009       varchar2(1)      ,/* 共用欄位排版 */
dzfc010       varchar2(20)      ,/* 可插入欄位的子節點4fd tag 類型 */
dzfc011       varchar2(20)      ,/* 可插入欄位的子節點4fd tag name */
dzfcownid       varchar2(20)      ,/* 資料所有者 */
dzfcowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfccrtid       varchar2(20)      ,/* 資料建立者 */
dzfccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfccrtdt       timestamp(0)      ,/* 資料創建日 */
dzfcmodid       varchar2(20)      ,/* 資料修改者 */
dzfcmoddt       timestamp(0)      ,/* 最近修改日 */
dzfccnfid       varchar2(20)      ,/* 資料確認者 */
dzfccnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzfc_t add constraint dzfc_pk primary key (dzfc001,dzfc002) enable validate;

create unique index dzfc_pk on dzfc_t (dzfc001,dzfc002);

grant select on dzfc_t to tiptop;
grant update on dzfc_t to tiptop;
grant delete on dzfc_t to tiptop;
grant insert on dzfc_t to tiptop;

exit;
