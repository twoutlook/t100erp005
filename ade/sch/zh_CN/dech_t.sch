/* 
================================================================================
檔案代號:dech_t
檔案名稱:門店庫區週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dech_t
(
dechent       number(5)      ,/* 企業編號 */
dechsite       varchar2(10)      ,/* 營運據點 */
dech001       varchar2(10)      ,/* 層級類型 */
dech005       varchar2(10)      ,/* 庫區編號 */
dech006       varchar2(10)      ,/* 庫區類型 */
dech007       varchar2(10)      ,/* 存貨管理方式 */
dech008       varchar2(10)      ,/* 庫區業態 */
dech009       varchar2(10)      ,/* 品類編號 */
dech010       varchar2(20)      ,/* 專櫃編號 */
dech011       varchar2(10)      ,/* 稅別編號 */
dech012       number(20,6)      ,/* 稅額 */
dech013       number(20,6)      ,/* 銷售數量 */
dech014       number(20,6)      ,/* 銷售成本 */
dech015       number(20,6)      ,/* 進價金額 */
dech016       number(20,6)      ,/* 原價金額 */
dech017       number(20,6)      ,/* 未稅金額 */
dech018       number(20,6)      ,/* 應收金額 */
dech019       number(20,6)      ,/* 折扣金額 */
dech020       number(20,6)      ,/* 實收金額 */
dech021       number(20,6)      ,/* 收銀差額 */
dech022       number(20,6)      ,/* 毛利 */
dech023       number(20,6)      ,/* 毛利率 */
dech024       number(20,6)      ,/* 客單數 */
dech025       number(20,6)      ,/* 退貨單據數 */
dech026       number(20,6)      ,/* 退貨金額 */
dech027       number(20,6)      ,/* 打折金額 */
dech028       number(20,6)      ,/* 變價金額 */
dech029       number(20,6)      ,/* 抵扣券金額 */
dech030       number(20,6)      ,/* 會員折扣金額 */
dech031       number(10,0)      ,/* 統計年度月份 */
dech032       number(5,0)      ,/* 統計週期 */
dech033       number(20,6)      /* 客單價 */
);
alter table dech_t add constraint dech_pk primary key (dechent,dechsite,dech005,dech009,dech010,dech011,dech031,dech032) enable validate;

create unique index dech_pk on dech_t (dechent,dechsite,dech005,dech009,dech010,dech011,dech031,dech032);

grant select on dech_t to tiptop;
grant update on dech_t to tiptop;
grant delete on dech_t to tiptop;
grant insert on dech_t to tiptop;

exit;
