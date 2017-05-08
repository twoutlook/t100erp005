/* 
================================================================================
檔案代號:glar_t
檔案名稱:會計科目各期餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table glar_t
(
glarent       number(5)      ,/* 企業編號 */
glarcomp       varchar2(10)      ,/* 法人 */
glarld       varchar2(5)      ,/* 帳套 */
glar001       varchar2(24)      ,/* 會計科目 */
glar002       number(5,0)      ,/* 年度 */
glar003       number(5,0)      ,/* 期別 */
glar004       varchar2(1000)      ,/* 組合要素(key) */
glar005       number(20,6)      ,/* 借方金額 */
glar006       number(20,6)      ,/* 貸方金額 */
glar007       number(10,0)      ,/* 借方筆數 */
glar008       number(10,0)      ,/* 貸方筆數 */
glar009       varchar2(10)      ,/* 交易幣別 */
glar010       number(20,6)      ,/* 原幣借方金額 */
glar011       number(20,6)      ,/* 原幣貸方金額 */
glar012       varchar2(10)      ,/* 營運據點 */
glar013       varchar2(10)      ,/* 部門 */
glar014       varchar2(10)      ,/* 利潤/成本中心 */
glar015       varchar2(10)      ,/* 區域 */
glar016       varchar2(10)      ,/* 收付款客商 */
glar017       varchar2(10)      ,/* 帳款客商 */
glar018       varchar2(10)      ,/* 客群 */
glar019       varchar2(10)      ,/* 產品類別 */
glar020       varchar2(20)      ,/* 人員 */
glar021       varchar2(10)      ,/* no use */
glar022       varchar2(20)      ,/* 專案編號 */
glar023       varchar2(30)      ,/* WBS */
glar024       varchar2(30)      ,/* 自由核算項一 */
glar025       varchar2(30)      ,/* 自由核算項二 */
glar026       varchar2(30)      ,/* 自由核算項三 */
glar027       varchar2(30)      ,/* 自由核算項四 */
glar028       varchar2(30)      ,/* 自由核算項五 */
glar029       varchar2(30)      ,/* 自由核算項六 */
glar030       varchar2(30)      ,/* 自由核算項七 */
glar031       varchar2(30)      ,/* 自由核算項八 */
glar032       varchar2(30)      ,/* 自由核算項九 */
glar033       varchar2(30)      ,/* 自由核算項十 */
glar034       number(20,6)      ,/* 借方金額(本位幣二) */
glar035       number(20,6)      ,/* 貸方金額(本位幣二) */
glar036       number(20,6)      ,/* 借方金額(本位幣三) */
glar037       number(20,6)      ,/* 貸方金額(本位幣三) */
glar051       varchar2(10)      ,/* 經營方式 */
glar052       varchar2(10)      ,/* 通路 */
glar053       varchar2(10)      /* 品牌 */
);
alter table glar_t add constraint glar_pk primary key (glarent,glarld,glar001,glar002,glar003,glar004) enable validate;

create unique index glar_pk on glar_t (glarent,glarld,glar001,glar002,glar003,glar004);

grant select on glar_t to tiptop;
grant update on glar_t to tiptop;
grant delete on glar_t to tiptop;
grant insert on glar_t to tiptop;

exit;
