/* 
================================================================================
檔案代號:dedh_t
檔案名稱:門店庫區款別統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedh_t
(
dedhent       number(5)      ,/* 企業代碼 */
dedhsite       varchar2(10)      ,/* 營運據點 */
dedh001       varchar2(10)      ,/* 層級類型 */
dedh005       varchar2(10)      ,/* 庫區編號 */
dedh006       varchar2(10)      ,/* 庫區類型 */
dedh007       varchar2(10)      ,/* 存貨管理方式 */
dedh008       varchar2(10)      ,/* 庫區業態 */
dedh009       varchar2(10)      ,/* 品類編號 */
dedh010       varchar2(20)      ,/* 專櫃編號 */
dedh011       varchar2(10)      ,/* 稅別 */
dedh012       varchar2(10)      ,/* 款別編號 */
dedh013       varchar2(10)      ,/* 款別分類 */
dedh014       number(20,6)      ,/* 實收金額 */
dedh015       number(5,0)      ,/* 統計年度 */
dedh016       number(5,0)      /* 統計月份 */
);
alter table dedh_t add constraint dedh_pk primary key (dedhent,dedhsite,dedh005,dedh009,dedh010,dedh011,dedh012,dedh015,dedh016) enable validate;

create unique index dedh_pk on dedh_t (dedhent,dedhsite,dedh005,dedh009,dedh010,dedh011,dedh012,dedh015,dedh016);

grant select on dedh_t to tiptop;
grant update on dedh_t to tiptop;
grant delete on dedh_t to tiptop;
grant insert on dedh_t to tiptop;

exit;
