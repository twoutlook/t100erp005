/* 
================================================================================
檔案代號:glaz_t
檔案名稱:傳票細項立沖各期餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table glaz_t
(
glazent       number(5)      ,/* 企業編號 */
glazld       varchar2(5)      ,/* 帳套 */
glazcomp       varchar2(10)      ,/* 法人 */
glazdocno       varchar2(20)      ,/* 單號 */
glazseq       number(10,0)      ,/* 項次 */
glazdocdt       date      ,/* 單據日期 */
glaz001       number(5,0)      ,/* 年度 */
glaz002       number(5,0)      ,/* 期別 */
glaz003       varchar2(24)      ,/* 會計科目 */
glaz004       number(20,6)      ,/* 本幣立帳金額(當期期初金額) */
glaz005       number(20,6)      ,/* 本幣已沖金額(當期已沖金額) */
glaz006       varchar2(10)      ,/* 計價單位 */
glaz007       number(20,6)      ,/* 立帳數量(當期期初數量) */
glaz008       number(20,6)      ,/* 已沖數量(當期已沖數量) */
glaz009       varchar2(10)      ,/* 交易幣別 */
glaz010       number(20,6)      ,/* 原幣立帳金額(當期期初金額) */
glaz011       number(20,6)      ,/* 原幣已沖金額(當期已沖金額) */
glaz012       varchar2(10)      ,/* 營運據點 */
glaz013       varchar2(10)      ,/* 部門 */
glaz014       varchar2(10)      ,/* 利潤/成本中心 */
glaz015       varchar2(10)      ,/* 區域 */
glaz016       varchar2(10)      ,/* 收付款客商 */
glaz017       varchar2(10)      ,/* 帳款客商 */
glaz018       varchar2(10)      ,/* 客群 */
glaz019       varchar2(10)      ,/* 產品類別 */
glaz020       varchar2(20)      ,/* 人員 */
glaz021       varchar2(10)      ,/* no use */
glaz022       varchar2(20)      ,/* 專案編號 */
glaz023       varchar2(30)      ,/* WBS */
glaz024       varchar2(30)      ,/* 自由核算項一 */
glaz025       varchar2(30)      ,/* 自由核算項二 */
glaz026       varchar2(30)      ,/* 自由核算項三 */
glaz027       varchar2(30)      ,/* 自由核算項四 */
glaz028       varchar2(30)      ,/* 自由核算項五 */
glaz029       varchar2(30)      ,/* 自由核算項六 */
glaz030       varchar2(30)      ,/* 自由核算項七 */
glaz031       varchar2(30)      ,/* 自由核算項八 */
glaz032       varchar2(30)      ,/* 自由核算項九 */
glaz033       varchar2(30)      ,/* 自由核算項十 */
glaz034       number(20,6)      ,/* 立帳金額(本位幣二當期期初金額 */
glaz035       number(20,6)      ,/* 已沖金額(本位幣二當期已沖金額) */
glaz036       number(20,6)      ,/* 立帳金額(本位幣三當期期初金額) */
glaz037       number(20,6)      ,/* 已沖金額(本位幣三當期已沖金額) */
glaz061       varchar2(10)      ,/* 經營方式 */
glaz062       varchar2(10)      ,/* 通路 */
glaz063       varchar2(10)      /* 品牌 */
);
alter table glaz_t add constraint glaz_pk primary key (glazent,glazld,glazdocno,glazseq,glaz001,glaz002) enable validate;

create unique index glaz_pk on glaz_t (glazent,glazld,glazdocno,glazseq,glaz001,glaz002);

grant select on glaz_t to tiptop;
grant update on glaz_t to tiptop;
grant delete on glaz_t to tiptop;
grant insert on glaz_t to tiptop;

exit;
