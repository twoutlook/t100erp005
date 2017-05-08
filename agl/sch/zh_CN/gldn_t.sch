/* 
================================================================================
檔案代號:gldn_t
檔案名稱:合併報表個體公司會計科目餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table gldn_t
(
gldnent       number(5)      ,/* 企業代碼 */
gldnld       varchar2(5)      ,/* 帳別 */
gldn001       varchar2(10)      ,/* 上層公司編號 */
gldn002       varchar2(5)      ,/* 上層公司帳別 */
gldn003       number(5,0)      ,/* 來源資料年度 */
gldn004       number(5,0)      ,/* 來源資料期別 */
gldn005       number(5,0)      ,/* 合併年度 */
gldn006       number(5,0)      ,/* 合併期別 */
gldn007       varchar2(24)      ,/* 會計科目 */
gldn008       varchar2(1000)      ,/* 組合要素(KEY) */
gldn009       varchar2(10)      ,/* 幣別(記帳幣) */
gldn010       number(20,6)      ,/* 借方金額(記帳幣) */
gldn011       number(20,6)      ,/* 貸方金額(記帳幣) */
gldn012       number(10,0)      ,/* 借方筆數 */
gldn013       number(10,0)      ,/* 貸方筆數 */
gldn014       varchar2(10)      ,/* 營運據點 */
gldn015       varchar2(10)      ,/* 部門 */
gldn016       varchar2(10)      ,/* 利潤/成本中心 */
gldn017       varchar2(10)      ,/* 區域 */
gldn018       varchar2(10)      ,/* 交易客商 */
gldn019       varchar2(10)      ,/* 帳款客商 */
gldn020       varchar2(10)      ,/* 客群 */
gldn021       varchar2(10)      ,/* 產品類別 */
gldn022       varchar2(20)      ,/* 人員 */
gldn024       varchar2(20)      ,/* 專案編號 */
gldn025       varchar2(30)      ,/* WBS */
gldn026       varchar2(10)      ,/* 幣別(功能幣) */
gldn027       number(20,6)      ,/* 借方金額(功能幣) */
gldn028       number(20,6)      ,/* 貸方金額(功能幣) */
gldn029       varchar2(10)      ,/* 幣別(報告幣) */
gldn030       number(20,6)      ,/* 借方金額(報告幣) */
gldn031       number(20,6)      ,/* 貸方金額(報告幣) */
gldn032       varchar2(10)      ,/* 原始公司編號 */
gldn033       varchar2(5)      ,/* 原始公司帳別 */
gldn034       number(20,10)      ,/* 匯率(記帳幣) */
gldn035       number(20,10)      ,/* 匯率(功能幣) */
gldn036       number(20,10)      ,/* 匯率(報告幣) */
gldn037       varchar2(10)      ,/* 經營方式 */
gldn038       varchar2(10)      ,/* 渠道 */
gldn039       varchar2(10)      ,/* 品牌 */
gldn040       varchar2(10)      ,/* 下層公司 */
gldn041       varchar2(5)      ,/* 下層公司帳別 */
gldn042       number(20,6)      ,/* 下層公司累計借方金額(記帳幣) */
gldn043       number(20,6)      ,/* 下層公司累計貸方金額(記帳幣) */
gldn044       number(20,6)      ,/* 下層公司累計借方金額(功能幣) */
gldn045       number(20,6)      ,/* 下層公司累計貸方金額(功能幣) */
gldn046       number(20,6)      ,/* 下層公司累計借方金額(報告幣) */
gldn047       number(20,6)      /* 下層公司累計貸方金額(報告幣) */
);
alter table gldn_t add constraint gldn_pk primary key (gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn032,gldn033,gldn040,gldn041) enable validate;

create unique index gldn_pk on gldn_t (gldnent,gldnld,gldn001,gldn002,gldn003,gldn004,gldn005,gldn006,gldn007,gldn008,gldn032,gldn033,gldn040,gldn041);

grant select on gldn_t to tiptop;
grant update on gldn_t to tiptop;
grant delete on gldn_t to tiptop;
grant insert on gldn_t to tiptop;

exit;
