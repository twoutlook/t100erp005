/* 
================================================================================
檔案代號:dzfr_t
檔案名稱:畫面結構設計內容檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfr_t
(
dzfr001       number(10)      ,/* 規格版次 */
dzfr002       varchar2(20)      ,/* 畫面代號 */
dzfr003       number(5,0)      ,/* 編號(流水號) */
dzfr004       number(5,0)      ,/* 父節點編號 */
dzfr005       number(5,0)      ,/* 順序(同階層中的排序) */
dzfr006       varchar2(20)      ,/* 4fd tag 類型 */
dzfr007       varchar2(40)      ,/* 4fd tag name */
dzfr008       number(5,0)      ,/* 4fd tag name 編號 */
dzfr009       varchar2(15)      ,/* 資料表代碼 */
dzfr010       varchar2(20)      ,/* 欄位代碼 */
dzfr011       varchar2(1)      ,/* 是否可刪除 */
dzfr012       varchar2(40)      ,/* 4fd tag name前置名稱 */
dzfrownid       varchar2(20)      ,/* 資料所有者 */
dzfrowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfrcrtid       varchar2(20)      ,/* 資料建立者 */
dzfrcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfrcrtdt       timestamp(0)      ,/* 資料創建日 */
dzfrmodid       varchar2(20)      ,/* 資料修改者 */
dzfrmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzfr_t add constraint dzfr_pk primary key (dzfr001,dzfr002,dzfr003) enable validate;

create unique index dzfr_pk on dzfr_t (dzfr001,dzfr002,dzfr003);

grant select on dzfr_t to tiptop;
grant update on dzfr_t to tiptop;
grant delete on dzfr_t to tiptop;
grant insert on dzfr_t to tiptop;

exit;
