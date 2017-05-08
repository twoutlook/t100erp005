/* 
================================================================================
檔案代號:dzdu_t
檔案名稱:樣板調整需求紀錄與成品對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdu_t
(
dzduownid       varchar2(20)      ,/* 資料所有者 */
dzduowndp       varchar2(10)      ,/* 資料所屬部門 */
dzducrtid       varchar2(20)      ,/* 資料建立者 */
dzducrtdp       varchar2(10)      ,/* 資料建立部門 */
dzducrtdt       timestamp(0)      ,/* 資料創建日 */
dzdumodid       varchar2(20)      ,/* 資料修改者 */
dzdumoddt       timestamp(0)      ,/* 最近修改日 */
dzdustus       varchar2(10)      ,/* 狀態碼 */
dzdu001       number(10,0)      ,/* 需求編號 */
dzdu002       varchar2(500)      ,/* 需求說明 */
dzdu003       varchar2(80)      ,/* 影響樣板 */
dzdu004       varchar2(1)      ,/* 影響產生器 */
dzdu005       date      ,/* 預定完成日期 */
dzdu006       varchar2(500)      ,/* 進度描述 */
dzdu007       varchar2(80)      ,/* 需求人 */
dzdu008       varchar2(1)      ,/* 評估狀況 */
dzdu009       varchar2(80)      /* 評估人 */
);
alter table dzdu_t add constraint dzdu_pk primary key (dzdu001) enable validate;

create unique index dzdu_pk on dzdu_t (dzdu001);

grant select on dzdu_t to tiptop;
grant update on dzdu_t to tiptop;
grant delete on dzdu_t to tiptop;
grant insert on dzdu_t to tiptop;

exit;
