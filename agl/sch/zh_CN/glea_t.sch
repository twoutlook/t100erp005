/* 
================================================================================
檔案代號:glea_t
檔案名稱:合併報表合併後各期科目餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table glea_t
(
gleaent       number(5)      ,/* 企業編號 */
gleald       varchar2(5)      ,/* 合併帳別 */
glea001       varchar2(10)      ,/* 上層公司編號 */
glea002       varchar2(5)      ,/* 上層公司帳別 */
glea003       number(5,0)      ,/* 年度 */
glea004       number(5,0)      ,/* 期別 */
glea005       varchar2(24)      ,/* 會計科目 */
glea006       varchar2(1000)      ,/* 組合要素(key) */
glea007       varchar2(10)      ,/* 幣別(記帳幣) */
glea008       number(20,6)      ,/* 借方金額(記帳幣) */
glea009       number(20,6)      ,/* 貸方金額(記帳幣) */
glea010       number(10,0)      ,/* 借方筆數 */
glea011       number(10,0)      ,/* 貸方筆數 */
glea012       varchar2(10)      ,/* 營運據點 */
glea013       varchar2(10)      ,/* 部門 */
glea014       varchar2(10)      ,/* 利潤/成本中心 */
glea015       varchar2(10)      ,/* 區域 */
glea016       varchar2(10)      ,/* 交易客商 */
glea017       varchar2(10)      ,/* 帳款客商 */
glea018       varchar2(1)      ,/* 客群 */
glea019       varchar2(1)      ,/* 產品類別 */
glea020       varchar2(10)      ,/* 經營方式 */
glea021       varchar2(10)      ,/* 渠道 */
glea022       varchar2(10)      ,/* 品牌 */
glea023       varchar2(20)      ,/* 人員 */
glea024       varchar2(20)      ,/* 專案編號 */
glea025       varchar2(30)      ,/* WBS */
glea026       varchar2(10)      ,/* 幣別(功能幣) */
glea027       number(20,6)      ,/* 借方金額(功能幣) */
glea028       number(20,6)      ,/* 貸方金額(功能幣) */
glea029       varchar2(10)      ,/* 幣別(報告幣) */
glea030       number(20,6)      ,/* 借方金額(報告幣) */
glea031       number(20,6)      ,/* 貸方金額(報告幣) */
glea032       varchar2(10)      ,/* 原始公司編號 */
glea033       varchar2(5)      ,/* 原始公司帳別 */
glea034       number(20,10)      ,/* 匯率(記帳幣) */
glea035       number(20,10)      ,/* 匯率(功能幣) */
glea036       number(20,10)      /* 匯率(報告幣) */
);
alter table glea_t add constraint glea_pk primary key (gleaent,gleald,glea001,glea002,glea003,glea004,glea005,glea006,glea032,glea033) enable validate;

create unique index glea_pk on glea_t (gleaent,gleald,glea001,glea002,glea003,glea004,glea005,glea006,glea032,glea033);

grant select on glea_t to tiptop;
grant update on glea_t to tiptop;
grant delete on glea_t to tiptop;
grant insert on glea_t to tiptop;

exit;
