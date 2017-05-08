/* 
================================================================================
檔案代號:fmbd_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmbd_t
(
fmbdent       number(5)      ,/* 企業編號 */
fmbd001       varchar2(20)      ,/* 計提利息帳務編號 */
fmbd002       number(10,0)      ,/* 項次 */
fmbd003       varchar2(10)      ,/* 融資組織 */
fmbd004       varchar2(10)      ,/* 融資合同號 */
fmbd005       number(10,0)      ,/* 融資合同項次 */
fmbd006       varchar2(10)      ,/* 幣別 */
fmbd007       number(20,6)      ,/* 金額 */
fmbd008       number(20,10)      ,/* 匯率一 */
fmbd009       number(20,6)      ,/* 本金一 */
fmbd010       varchar2(24)      ,/* 利息科目 */
fmbd011       number(20,10)      ,/* 對方科目 */
fmbd012       number(20,10)      ,/* 匯率二 */
fmbd013       number(20,6)      ,/* 本金二 */
fmbd014       number(20,10)      ,/* 匯率三 */
fmbd015       number(20,6)      ,/* 本金三 */
fmbd016       number(20,10)      ,/* 本幣一重估匯率 */
fmbd017       number(20,6)      ,/* 本幣一重估調整 */
fmbd018       number(20,6)      ,/* 本幣一重估金額 */
fmbd019       number(20,10)      ,/* 本幣二重估匯率 */
fmbd020       number(20,6)      ,/* 本幣二重估調整 */
fmbd021       number(20,6)      ,/* 本幣二重估金額 */
fmbd022       number(20,10)      ,/* 本幣三重估匯率 */
fmbd023       number(20,6)      ,/* 本幣三重估調整 */
fmbd024       number(20,6)      ,/* 本幣三重估金額 */
fmbd025       varchar2(10)      ,/* 營運據點 */
fmbd026       varchar2(10)      ,/* 部門 */
fmbd027       varchar2(10)      ,/* 利潤/成本中心 */
fmbd028       varchar2(10)      ,/* 區域 */
fmbd029       varchar2(10)      ,/* 交易客商 */
fmbd030       varchar2(10)      ,/* 帳款客商 */
fmbd031       varchar2(10)      ,/* 客群 */
fmbd032       varchar2(10)      ,/* 產品類別 */
fmbd033       varchar2(20)      ,/* 人員 */
fmbd034       varchar2(10)      ,/* 預算編號 */
fmbd035       varchar2(20)      ,/* 專案編號 */
fmbd036       varchar2(30)      ,/* WBS */
fmbd037       varchar2(10)      ,/* 經營方式 */
fmbd038       varchar2(10)      ,/* 渠道 */
fmbd039       varchar2(10)      ,/* 品牌 */
fmbd040       varchar2(30)      ,/* 自由核算項(一) */
fmbd041       varchar2(30)      ,/* 自由核算項(二) */
fmbd042       varchar2(30)      ,/* 自由核算項(三) */
fmbd043       varchar2(30)      ,/* 自由核算項(四) */
fmbd044       varchar2(30)      ,/* 自由核算項(五) */
fmbd045       varchar2(30)      ,/* 自由核算項(六) */
fmbd046       varchar2(30)      ,/* 自由核算項(七) */
fmbd047       varchar2(30)      ,/* 自由核算項(八) */
fmbd048       varchar2(30)      ,/* 自由核算項(九) */
fmbd049       varchar2(30)      /* 自由核算項(十) */
);
alter table fmbd_t add constraint fmbd_pk primary key (fmbdent,fmbd001,fmbd002) enable validate;

create unique index fmbd_pk on fmbd_t (fmbdent,fmbd001,fmbd002);

grant select on fmbd_t to tiptop;
grant update on fmbd_t to tiptop;
grant delete on fmbd_t to tiptop;
grant insert on fmbd_t to tiptop;

exit;
