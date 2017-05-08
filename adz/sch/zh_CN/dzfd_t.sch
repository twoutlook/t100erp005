/* 
================================================================================
檔案代號:dzfd_t
檔案名稱:畫面樹狀結構設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfd_t
(
dzfdstus       varchar2(10)      ,/* 狀態碼 */
dzfd001       varchar2(20)      ,/* 程式代號 */
dzfd002       number(10)      ,/* 設計點版本 */
dzfd003       number(10)      ,/* 設計器版本 */
dzfd004       number(5,0)      ,/* 設計資料版本計數 */
dzfd005       varchar2(1)      ,/* 是否為初始樣版內容 */
dzfd006       number(5,0)      ,/* 編號 */
dzfd007       number(5,0)      ,/* 父節點編號 */
dzfd008       number(5,0)      ,/* 順序 */
dzfd009       varchar2(10)      ,/* 節點類型 */
dzfd010       varchar2(20)      ,/* 4fd tag 類型 */
dzfd011       varchar2(20)      ,/* 4fd tag name */
dzfd012       varchar2(10)      ,/* 可插入的子節點類型 */
dzfd013       varchar2(1)      ,/* 共用欄位排版 */
dzfd014       varchar2(20)      ,/* 可插入欄位的子節點4fd tag 類型 */
dzfd015       varchar2(20)      ,/* 可插入欄位的子節點4fd tag name */
dzfd016       varchar2(15)      ,/* 資料表代碼 */
dzfd017       varchar2(20)      ,/* 欄位代碼 */
dzfd018       varchar2(255)      ,/* 畫面元件多語言名稱,設計時的名稱 */
dzfdownid       varchar2(20)      ,/* 資料所有者 */
dzfdowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfdcrtid       varchar2(20)      ,/* 資料建立者 */
dzfdcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfdcrtdt       timestamp(0)      ,/* 資料創建日 */
dzfdmodid       varchar2(20)      ,/* 資料修改者 */
dzfdmoddt       timestamp(0)      ,/* 最近修改日 */
dzfdcnfid       varchar2(20)      ,/* 資料確認者 */
dzfdcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzfd_t add constraint dzfd_pk primary key (dzfd001,dzfd002,dzfd003,dzfd004,dzfd006) enable validate;

create unique index dzfd_pk on dzfd_t (dzfd001,dzfd002,dzfd003,dzfd004,dzfd006);

grant select on dzfd_t to tiptop;
grant update on dzfd_t to tiptop;
grant delete on dzfd_t to tiptop;
grant insert on dzfd_t to tiptop;

exit;
