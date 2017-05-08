/* 
================================================================================
檔案代號:dzye_t
檔案名稱:設計資料執行結果記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzye_t
(
dzye001       varchar2(80)      ,/* 匯入包編號 */
dzye002       varchar2(20)      ,/* 程式代碼 */
dzye003       varchar2(1)      ,/* 建構類型 */
dzye004       varchar2(255)      ,/* 已執行項目 */
dzye005       varchar2(4)      ,/* 模組 */
dzye006       varchar2(1)      ,/* Hard Code qry */
dzye007       varchar2(80)      ,/* 錯誤訊息(簡單) */
dzye008       varchar2(20)      ,/* PID */
dzye009       number(10)      ,/* 目的建構版次 */
dzye010       number(10)      ,/* 目的規格版次 */
dzye011       number(10)      ,/* 目的程式版次 */
dzye012       varchar2(1)      ,/* 目的程式客製否 */
dzye013       number(5,0)      ,/* 順序 */
dzye014       number(10)      ,/* 來源建構版次 */
dzye015       varchar2(1)      ,/* 執行merge否 */
dzye016       varchar2(80)      ,/* 執行階段 */
dzye017       timestamp(0)      ,/* 執行日期 */
dzye018       varchar2(4000)      ,/* 錯誤訊息(完整) */
dzye019       varchar2(1)      ,/* 來源程式客制否 */
dzye020       number(10)      ,/* 來源規格版次 */
dzye021       number(10)      ,/* 來源程式版次 */
dzye022       varchar2(1)      ,/* 目的程式簽出否 */
dzye023       varchar2(1)      ,/* patch狀態 */
dzye024       varchar2(20)      /* 執行使用者 */
);
alter table dzye_t add constraint dzye_pk primary key (dzye001,dzye002) enable validate;

create unique index dzye_pk on dzye_t (dzye001,dzye002);

grant select on dzye_t to tiptop;
grant update on dzye_t to tiptop;
grant delete on dzye_t to tiptop;
grant insert on dzye_t to tiptop;

exit;
