/* 
================================================================================
檔案代號:debe_t
檔案名稱:門店庫區款別統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debe_t
(
debeent       number(5)      ,/* 企業編號 */
debesite       varchar2(10)      ,/* 營運據點 */
debe001       varchar2(10)      ,/* 層級類型 */
debe002       date      ,/* 統計日期 */
debe003       number(5,0)      ,/* 會計週 */
debe004       number(5,0)      ,/* 會計期 */
debe005       varchar2(10)      ,/* 庫區編號 */
debe006       varchar2(10)      ,/* 庫區類型 */
debe007       varchar2(10)      ,/* 存貨管理方式 */
debe008       varchar2(10)      ,/* 庫區業態 */
debe009       varchar2(10)      ,/* 品類編號 */
debe010       varchar2(20)      ,/* 專櫃編號 */
debe011       varchar2(10)      ,/* 稅別 */
debe012       varchar2(10)      ,/* 款別編號 */
debe013       varchar2(10)      ,/* 款別分類 */
debe014       number(20,6)      /* 實收金額 */
);
alter table debe_t add constraint debe_pk primary key (debeent,debesite,debe002,debe005,debe009,debe010,debe011,debe012) enable validate;

create unique index debe_pk on debe_t (debeent,debesite,debe002,debe005,debe009,debe010,debe011,debe012);

grant select on debe_t to tiptop;
grant update on debe_t to tiptop;
grant delete on debe_t to tiptop;
grant insert on debe_t to tiptop;

exit;
