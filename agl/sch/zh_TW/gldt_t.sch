/* 
================================================================================
檔案代號:gldt_t
檔案名稱:合併報表沖銷前各期科目餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table gldt_t
(
gldtent       number(5)      ,/* 企業編號 */
gldtld       varchar2(5)      ,/* 合併帳別 */
gldt001       varchar2(10)      ,/* 上層公司編號 */
gldt002       varchar2(5)      ,/* 上層公司帳別 */
gldt003       varchar2(10)      ,/* 下層公司編號 */
gldt004       varchar2(5)      ,/* 下層公司帳別 */
gldt005       number(5,0)      ,/* 年度 */
gldt006       number(5,0)      ,/* 期別 */
gldt007       varchar2(24)      ,/* 會計科目 */
gldt008       varchar2(1000)      ,/* 組合要素(key) */
gldt009       varchar2(10)      ,/* 幣別(記帳幣) */
gldt010       number(20,6)      ,/* 借方金額(記帳幣) */
gldt011       number(20,6)      ,/* 貸方金額(記帳幣) */
gldt012       number(10,0)      ,/* 借方筆數 */
gldt013       number(10,0)      ,/* 貸方筆數 */
gldt014       varchar2(10)      ,/* 營運據點 */
gldt015       varchar2(10)      ,/* 部門 */
gldt016       varchar2(10)      ,/* 利潤/成本中心 */
gldt017       varchar2(10)      ,/* 區域 */
gldt018       varchar2(10)      ,/* 交易客商 */
gldt019       varchar2(10)      ,/* 帳款客商 */
gldt020       varchar2(1)      ,/* 客群 */
gldt021       varchar2(1)      ,/* 產品類別 */
gldt022       varchar2(20)      ,/* 人員 */
gldt023       varchar2(20)      ,/* 專案編號 */
gldt024       varchar2(30)      ,/* ＷＢＳ */
gldt025       varchar2(10)      ,/* 幣別(功能幣) */
gldt026       number(20,6)      ,/* 借方金額(功能幣) */
gldt027       number(20,6)      ,/* 貸方金額(功能幣) */
gldt028       varchar2(10)      ,/* 幣別(報告幣) */
gldt029       number(20,6)      ,/* 借方金額(報告幣) */
gldt030       number(20,6)      ,/* 貸方金額(報告幣) */
gldt031       varchar2(10)      ,/* 原始公司編號 */
gldt032       varchar2(5)      ,/* 原始公司帳別 */
gldt033       number(20,10)      ,/* 匯率(記帳幣) */
gldt034       number(20,10)      ,/* 匯率(功能幣) */
gldt035       number(20,10)      ,/* 匯率(報告幣) */
gldt036       varchar2(10)      ,/* 經營方式 */
gldt037       varchar2(10)      ,/* 渠道 */
gldt038       varchar2(10)      /* 品牌 */
);
alter table gldt_t add constraint gldt_pk primary key (gldtent,gldtld,gldt001,gldt002,gldt003,gldt004,gldt005,gldt006,gldt007,gldt008,gldt031,gldt032) enable validate;

create unique index gldt_pk on gldt_t (gldtent,gldtld,gldt001,gldt002,gldt003,gldt004,gldt005,gldt006,gldt007,gldt008,gldt031,gldt032);

grant select on gldt_t to tiptop;
grant update on gldt_t to tiptop;
grant delete on gldt_t to tiptop;
grant insert on gldt_t to tiptop;

exit;
