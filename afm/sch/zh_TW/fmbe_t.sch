/* 
================================================================================
檔案代號:fmbe_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmbe_t
(
fmbeent       number(5)      ,/* 企業代碼 */
fmbe001       varchar2(20)      ,/* 償還本息帳務編號 */
fmbe002       number(10,0)      ,/* 項次 */
fmbe003       varchar2(10)      ,/* 融資組織 */
fmbe004       varchar2(20)      ,/* 還款單編號 */
fmbe005       varchar2(10)      ,/* 融資合同號 */
fmbe006       varchar2(10)      ,/* 融資合同項次 */
fmbe007       varchar2(1)      ,/* 還款性質 */
fmbe008       varchar2(10)      ,/* 幣別 */
fmbe009       number(20,6)      ,/* 本/息金額 */
fmbe010       number(20,10)      ,/* 匯率一 */
fmbe011       number(20,6)      ,/* 本幣一金額 */
fmbe012       varchar2(24)      ,/* 還款科目 */
fmbe013       number(20,10)      ,/* 匯率二 */
fmbe014       number(20,6)      ,/* 本幣二金額 */
fmbe015       number(20,10)      ,/* 匯率三 */
fmbe016       number(20,6)      ,/* 本幣三金額 */
fmbe017       number(20,10)      ,/* 本幣一重估匯率 */
fmbe018       number(20,6)      ,/* 本幣一重估調整 */
fmbe019       number(20,6)      ,/* 本幣一重估金額 */
fmbe020       number(20,10)      ,/* 本幣二重估匯率 */
fmbe021       number(20,6)      ,/* 本幣二重估調整 */
fmbe022       number(20,6)      ,/* 本幣二重估金額 */
fmbe023       number(20,10)      ,/* 本幣三重估匯率 */
fmbe024       number(20,6)      ,/* 本幣三重估調整 */
fmbe025       number(20,6)      ,/* 本幣三重估金額 */
fmbe026       varchar2(10)      ,/* 營運據點 */
fmbe027       varchar2(10)      ,/* 部門 */
fmbe028       varchar2(10)      ,/* 利潤/成本中心 */
fmbe029       varchar2(10)      ,/* 區域 */
fmbe030       varchar2(10)      ,/* 交易客商 */
fmbe031       varchar2(10)      ,/* 帳款客商 */
fmbe032       varchar2(10)      ,/* 客群 */
fmbe033       varchar2(10)      ,/* 產品類別 */
fmbe034       varchar2(20)      ,/* 人員 */
fmbe035       varchar2(10)      ,/* 預算編號 */
fmbe036       varchar2(20)      ,/* 專案編號 */
fmbe037       varchar2(30)      ,/* WBS */
fmbe038       varchar2(10)      ,/* 經營方式 */
fmbe039       varchar2(10)      ,/* 渠道 */
fmbe040       varchar2(10)      ,/* 品牌 */
fmbe041       varchar2(30)      ,/* 自由核算項(一) */
fmbe042       varchar2(30)      ,/* 自由核算項(二) */
fmbe043       varchar2(30)      ,/* 自由核算項(三) */
fmbe044       varchar2(30)      ,/* 自由核算項(四) */
fmbe045       varchar2(30)      ,/* 自由核算項(五) */
fmbe046       varchar2(30)      ,/* 自由核算項(六) */
fmbe047       varchar2(30)      ,/* 自由核算項(七) */
fmbe048       varchar2(30)      ,/* 自由核算項(八) */
fmbe049       varchar2(30)      ,/* 自由核算項(九) */
fmbe050       varchar2(30)      ,/* 自由核算項(十) */
fmbe051       varchar2(24)      /* 對方科目 */
);
alter table fmbe_t add constraint fmbe_pk primary key (fmbeent,fmbe001,fmbe002) enable validate;

create unique index fmbe_pk on fmbe_t (fmbeent,fmbe001,fmbe002);

grant select on fmbe_t to tiptop;
grant update on fmbe_t to tiptop;
grant delete on fmbe_t to tiptop;
grant insert on fmbe_t to tiptop;

exit;
