/* 
================================================================================
檔案代號:debc_t
檔案名稱:門店庫區日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debc_t
(
debcent       number(5)      ,/* 企業編號 */
debcsite       varchar2(10)      ,/* 營運據點 */
debc001       varchar2(10)      ,/* 層級類型 */
debc002       date      ,/* 統計日期 */
debc003       number(5,0)      ,/* 會計週 */
debc004       number(5,0)      ,/* 會計期 */
debc005       varchar2(10)      ,/* 庫區編號 */
debc006       varchar2(10)      ,/* 庫區類型 */
debc007       varchar2(10)      ,/* 存貨管理方式 */
debc008       varchar2(10)      ,/* 庫區業態 */
debc009       varchar2(10)      ,/* 品類編號 */
debc010       varchar2(20)      ,/* 專櫃編號 */
debc011       varchar2(10)      ,/* 稅別編號 */
debc012       number(20,6)      ,/* 稅額 */
debc013       number(20,6)      ,/* 銷售數量 */
debc014       number(20,6)      ,/* 銷售成本 */
debc015       number(20,6)      ,/* 進價金額 */
debc016       number(20,6)      ,/* 原價金額 */
debc017       number(20,6)      ,/* 未稅金額 */
debc018       number(20,6)      ,/* 應收金額 */
debc019       number(20,6)      ,/* 折扣金額 */
debc020       number(20,6)      ,/* 實收金額 */
debc021       number(20,6)      ,/* 收銀差額 */
debc022       number(20,6)      ,/* 毛利 */
debc023       number(20,6)      ,/* 毛利率 */
debc024       number(20,6)      ,/* 客單數 */
debc025       number(20,6)      ,/* 退貨單據數 */
debc026       number(20,6)      ,/* 退貨金額 */
debc027       number(20,6)      ,/* 打折金額 */
debc028       number(20,6)      ,/* 變價金額 */
debc029       number(20,6)      ,/* 抵扣券金額 */
debc030       number(20,6)      ,/* 會員折扣金額 */
debc031       number(20,6)      /* 客單價 */
);
alter table debc_t add constraint debc_pk primary key (debcent,debcsite,debc002,debc005,debc009,debc010,debc011) enable validate;

create unique index debc_pk on debc_t (debcent,debcsite,debc002,debc005,debc009,debc010,debc011);

grant select on debc_t to tiptop;
grant update on debc_t to tiptop;
grant delete on debc_t to tiptop;
grant insert on debc_t to tiptop;

exit;
