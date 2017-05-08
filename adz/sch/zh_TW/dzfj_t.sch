/* 
================================================================================
檔案代號:dzfj_t
檔案名稱:畫面元件組合檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfj_t
(
dzfj001       varchar2(20)      ,/* 結構代號 */
dzfj002       number(10)      ,/* 規格版次 */
dzfj003       varchar2(40)      ,/* 元件組代碼 */
dzfj004       number(5,0)      ,/* 順序 */
dzfj005       varchar2(40)      ,/* 包含元件代碼 */
dzfj006       varchar2(20)      ,/* 節點類型 */
dzfj007       varchar2(20)      ,/* 所屬結構類型 */
dzfj008       varchar2(40)      ,/* 所屬結構代碼 */
dzfj009       varchar2(40)      ,/* 所屬結構標籤代碼 */
dzfj010       varchar2(40)      ,/* 欄位標籤代碼 */
dzfj011       varchar2(40)      ,/* 參考欄位控件代號 */
dzfj012       varchar2(1)      ,/* 是否為參考欄位 */
dzfj013       number(5,0)      ,/* 元件X軸位置 */
dzfj014       number(5,0)      ,/* 元件Y軸位置 */
dzfj015       number(5,0)      ,/* 元件寬度 */
dzfj016       number(5,0)      ,/* 元件高度 */
dzfj017       varchar2(1)      ,/* 客製 */
dzfj018       varchar2(40)      ,/* 客戶代號 */
dzfjstus       varchar2(10)      /* 狀態碼 */
);
alter table dzfj_t add constraint dzfj_pk primary key (dzfj001,dzfj002,dzfj003,dzfj004,dzfj017) enable validate;

create unique index dzfj_pk on dzfj_t (dzfj001,dzfj002,dzfj003,dzfj004,dzfj017);

grant select on dzfj_t to tiptop;
grant update on dzfj_t to tiptop;
grant delete on dzfj_t to tiptop;
grant insert on dzfj_t to tiptop;

exit;
