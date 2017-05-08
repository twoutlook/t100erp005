/* 
================================================================================
檔案代號:gleb_t
檔案名稱:合併報表上層公司上傳餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table gleb_t
(
glebent       number(5)      ,/* 企業代碼 */
glebld       varchar2(5)      ,/* 合併帳別 */
gleb001       varchar2(10)      ,/* 上層公司編號 */
gleb002       varchar2(5)      ,/* 上層公司帳別 */
gleb003       number(5,0)      ,/* 年度 */
gleb004       number(5,0)      ,/* 期別 */
gleb005       varchar2(24)      ,/* 會計科目 */
gleb006       varchar2(1000)      ,/* 組合要素(key) */
gleb007       varchar2(10)      ,/* 幣別(記帳幣) */
gleb008       number(20,6)      ,/* 借方金額(記帳幣) */
gleb009       number(20,6)      ,/* 貸方金額(記帳幣) */
gleb010       number(10,0)      ,/* 借方筆數 */
gleb011       number(10,0)      ,/* 貸方筆數 */
gleb012       varchar2(10)      ,/* 營運據點 */
gleb013       varchar2(10)      ,/* 部門 */
gleb014       varchar2(10)      ,/* 利潤/成本中心 */
gleb015       varchar2(10)      ,/* 區域 */
gleb016       varchar2(10)      ,/* 交易客商 */
gleb017       varchar2(10)      ,/* 帳款客商 */
gleb018       varchar2(10)      ,/* 客群 */
gleb019       varchar2(10)      ,/* 產品類別 */
gleb020       varchar2(10)      ,/* 經營方式 */
gleb021       varchar2(10)      ,/* 渠道 */
gleb022       varchar2(40)      ,/* 品牌 */
gleb023       varchar2(20)      ,/* 人員 */
gleb024       varchar2(20)      ,/* 專案編號 */
gleb025       varchar2(30)      ,/* WBS */
gleb026       varchar2(10)      ,/* 幣別(功能幣) */
gleb027       number(20,6)      ,/* 借方金額(功能幣) */
gleb028       number(20,6)      ,/* 貸方金額(功能幣) */
gleb029       varchar2(10)      ,/* 幣別(報告幣) */
gleb030       number(20,6)      ,/* 借方金額(報告幣) */
gleb031       number(20,6)      ,/* 貸方金額(報告幣) */
gleb032       varchar2(10)      ,/* 原始公司編號 */
gleb033       varchar2(5)      ,/* 原始公司帳別 */
gleb034       number(20,10)      ,/* 匯率(記帳幣) */
gleb035       number(20,10)      ,/* 匯率(功能幣) */
gleb036       number(20,10)      /* 匯率(報告幣) */
);
alter table gleb_t add constraint gleb_pk primary key (glebent,glebld,gleb001,gleb002,gleb003,gleb004,gleb005,gleb006,gleb032,gleb033) enable validate;

create unique index gleb_pk on gleb_t (glebent,glebld,gleb001,gleb002,gleb003,gleb004,gleb005,gleb006,gleb032,gleb033);

grant select on gleb_t to tiptop;
grant update on gleb_t to tiptop;
grant delete on gleb_t to tiptop;
grant insert on gleb_t to tiptop;

exit;
