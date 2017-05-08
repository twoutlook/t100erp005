/* 
================================================================================
檔案代號:debs_t
檔案名稱:門店管理品類日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debs_t
(
debsent       number(5)      ,/* 企業編號 */
debssite       varchar2(10)      ,/* 營運據點 */
debs001       varchar2(10)      ,/* 層級類型 */
debs002       date      ,/* 統計日期 */
debs003       number(5,0)      ,/* 會計週 */
debs004       number(5,0)      ,/* 會計期 */
debs005       varchar2(10)      ,/* 品類編號 */
debs006       varchar2(20)      ,/* 品牌 */
debs007       varchar2(10)      ,/* 主供應商 */
debs008       varchar2(10)      ,/* 結算方式 */
debs009       varchar2(10)      ,/* 稅別編號 */
debs010       number(20,6)      ,/* 稅額 */
debs011       number(20,6)      ,/* 銷售數量 */
debs012       number(20,6)      ,/* 銷售成本 */
debs013       number(20,6)      ,/* 進價金額 */
debs014       number(20,6)      ,/* 原價金額 */
debs015       number(20,6)      ,/* 未稅金額 */
debs016       number(20,6)      ,/* 應收金額 */
debs017       number(20,6)      ,/* 毛利 */
debs018       number(20,6)      ,/* 毛利率 */
debs019       number(20,6)      ,/* 客單數 */
debs020       number(20,6)      ,/* 促銷銷售數量 */
debs021       number(20,6)      ,/* 促銷應收金額 */
debs022       number(20,6)      ,/* 打折金額 */
debs023       number(20,6)      ,/* 變價金額 */
debs024       number(20,6)      ,/* 退貨金額 */
debs025       number(20,6)      ,/* 後台銷售數量 */
debs026       number(20,6)      ,/* 後台進價金額 */
debs027       number(20,6)      ,/* 後台應收金額 */
debs028       number(20,6)      ,/* 前台銷售數量 */
debs029       number(20,6)      ,/* 前台進價金額 */
debs030       number(20,6)      ,/* 前台應收金額 */
debs031       number(20,6)      ,/* 抵扣券金額 */
debs032       number(20,6)      ,/* 會員折扣金額 */
debs033       number(20,6)      ,/* 實收金額 */
debs034       number(20,6)      ,/* 客單價 */
debs035       varchar2(1)      /* 日結類型 */
);
alter table debs_t add constraint debs_pk primary key (debsent,debssite,debs002,debs005,debs006,debs007,debs008,debs009,debs035) enable validate;

create unique index debs_pk on debs_t (debsent,debssite,debs002,debs005,debs006,debs007,debs008,debs009,debs035);

grant select on debs_t to tiptop;
grant update on debs_t to tiptop;
grant delete on debs_t to tiptop;
grant insert on debs_t to tiptop;

exit;
