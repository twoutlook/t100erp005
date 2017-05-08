/* 
================================================================================
檔案代號:bgbd_t
檔案名稱:滾動預算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table bgbd_t
(
bgbdent       number(5)      ,/* 企業代碼 */
bgbd001       varchar2(10)      ,/* 預算編號 */
bgbd002       varchar2(10)      ,/* 版本 */
bgbd003       varchar2(10)      ,/* 預算組織 */
bgbd004       number(5,0)      ,/* 期別 */
bgbd005       varchar2(1)      ,/* 滾動週期 */
bgbd006       number(5,0)      ,/* 滾動期別 */
bgbd007       varchar2(10)      ,/* 預算項目 */
bgbd008       varchar2(1000)      ,/* 組合KEY */
bgbd009       varchar2(10)      ,/* 計量單位 */
bgbd010       number(20,6)      ,/* 數量 */
bgbd011       number(20,6)      ,/* 借方金額 */
bgbd012       number(20,6)      ,/* 貸方金額 */
bgbd013       varchar2(10)      ,/* 部門 */
bgbd014       varchar2(10)      ,/* 利潤成本中心 */
bgbd015       varchar2(10)      ,/* 區域 */
bgbd016       varchar2(10)      ,/* 交易客商 */
bgbd017       varchar2(10)      ,/* 收款客商 */
bgbd018       varchar2(10)      ,/* 客群 */
bgbd019       varchar2(10)      ,/* 產品類別 */
bgbd020       varchar2(20)      ,/* 人員 */
bgbd021       varchar2(20)      ,/* 專案編號 */
bgbd022       varchar2(30)      ,/* WBS */
bgbd023       varchar2(10)      ,/* 經營方式 */
bgbd024       varchar2(30)      ,/* 自由核算項一 */
bgbd025       varchar2(30)      ,/* 自由核算項二 */
bgbd026       varchar2(30)      ,/* 自由核算項三 */
bgbd027       varchar2(30)      ,/* 自由核算項四 */
bgbd028       varchar2(30)      ,/* 自由核算項五 */
bgbd029       varchar2(30)      ,/* 自由核算項六 */
bgbd030       varchar2(30)      ,/* 自由核算項七 */
bgbd031       varchar2(30)      ,/* 自由核算項八 */
bgbd032       varchar2(30)      ,/* 自由核算項九 */
bgbd033       varchar2(30)      ,/* 自由核算項十 */
bgbd034       number(20,6)      ,/* 追加金額 */
bgbd035       number(20,6)      ,/* 挪用金額 */
bgbd036       varchar2(10)      ,/* 來源碼 */
bgbd037       varchar2(20)      ,/* 單號 */
bgbd038       number(10,0)      ,/* 項次 */
bgbd039       number(20,6)      ,/* 使用金額 */
bgbd040       number(20,6)      ,/* 轉出金額 */
bgbd041       varchar2(1)      ,/* 單據審核碼 */
bgbd042       varchar2(10)      ,/* 渠道 */
bgbd043       varchar2(10)      /* 品牌 */
);
alter table bgbd_t add constraint bgbd_pk primary key (bgbdent,bgbd001,bgbd002,bgbd003,bgbd004,bgbd006,bgbd007,bgbd008,bgbd036,bgbd037,bgbd038) enable validate;

create unique index bgbd_pk on bgbd_t (bgbdent,bgbd001,bgbd002,bgbd003,bgbd004,bgbd006,bgbd007,bgbd008,bgbd036,bgbd037,bgbd038);

grant select on bgbd_t to tiptop;
grant update on bgbd_t to tiptop;
grant delete on bgbd_t to tiptop;
grant insert on bgbd_t to tiptop;

exit;
