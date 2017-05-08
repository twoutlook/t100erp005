/* 
================================================================================
檔案代號:dzfv_t
檔案名稱:畫面結構設計主檔底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfv_t
(
dzfv001       varchar2(20)      ,/* 設計工具版號 */
dzfv002       varchar2(20)      ,/* 資料所有者 */
dzfv003       varchar2(40)      ,/* 結構代號 */
dzfv004       varchar2(20)      ,/* 畫面代號 */
dzfv005       varchar2(1)      ,/* 主/子程式 */
dzfv006       varchar2(10)      ,/* 單頭資料 */
dzfv007       varchar2(20)      ,/* 單頭框架 */
dzfv008       number(5,0)      ,/* 換行數量 */
dzfv009       varchar2(20)      ,/* 單身切割框架 */
dzfv010       varchar2(20)      ,/* 單身框架 */
dzfv011       varchar2(1)      ,/* 單身串查 */
dzfv012       varchar2(1)      ,/* 子程式進入模式 */
dzfv013       varchar2(1)      ,/* 空框架程式碼 */
dzfv014       varchar2(1)      ,/* 空框架畫面檔 */
dzfv015       varchar2(10)      /* 樹狀結構類別 */
);
alter table dzfv_t add constraint dzfv_pk primary key (dzfv001,dzfv002,dzfv004) enable validate;

create unique index dzfv_pk on dzfv_t (dzfv001,dzfv002,dzfv004);

grant select on dzfv_t to tiptop;
grant update on dzfv_t to tiptop;
grant delete on dzfv_t to tiptop;
grant insert on dzfv_t to tiptop;

exit;
