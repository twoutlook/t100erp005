/* 
================================================================================
檔案代號:xrde_t
檔案名稱:收款及差異處理明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrde_t
(
xrdeent       number(5)      ,/* 企業代碼 */
xrdecomp       varchar2(10)      ,/* 法人 */
xrdeld       varchar2(5)      ,/* 帳別 */
xrdedocno       varchar2(20)      ,/* 沖銷單單號 */
xrdeseq       number(10,0)      ,/* 項次 */
xrdesite       varchar2(10)      ,/* 帳務中心 */
xrdeorga       varchar2(10)      ,/* 帳務歸屬組織 */
xrde001       varchar2(20)      ,/* 來源作業 */
xrde002       varchar2(10)      ,/* 沖銷帳款類型 */
xrde003       varchar2(20)      ,/* 來源單號 */
xrde004       number(10,0)      ,/* 來源單項次 */
xrde006       varchar2(10)      ,/* 款別代碼 */
xrde007       varchar2(10)      ,/* 款別編號 */
xrde008       varchar2(20)      ,/* 帳戶/票券號碼 */
xrde010       varchar2(255)      ,/* 摘要 */
xrde011       varchar2(10)      ,/* 銀行存提碼 */
xrde012       varchar2(10)      ,/* 現金變動碼 */
xrde013       varchar2(10)      ,/* 轉入客商碼 */
xrde014       varchar2(20)      ,/* 轉入帳款單編號 */
xrde015       varchar2(1)      ,/* 沖銷加減項 */
xrde016       varchar2(24)      ,/* 沖銷會科 */
xrde017       varchar2(20)      ,/* 業務人員 */
xrde018       varchar2(10)      ,/* 業務部門 */
xrde019       varchar2(10)      ,/* 責任中心 */
xrde020       varchar2(10)      ,/* 產品類別 */
xrde022       varchar2(20)      ,/* 專案編號 */
xrde023       varchar2(30)      ,/* WBS編號 */
xrde028       varchar2(1)      ,/* 產生方式 */
xrde029       varchar2(20)      ,/* 傳票號碼 */
xrde030       number(10,0)      ,/* 傳票項次 */
xrde035       varchar2(10)      ,/* 區域 */
xrde036       varchar2(10)      ,/* 客群 */
xrde038       varchar2(10)      ,/* 對象 */
xrde039       varchar2(10)      ,/* 經營方式 */
xrde040       varchar2(10)      ,/* 渠道 */
xrde041       varchar2(10)      ,/* 品牌 */
xrde042       varchar2(30)      ,/* 自由核算項一 */
xrde043       varchar2(30)      ,/* 自由核算項二 */
xrde044       varchar2(30)      ,/* 自由核算項三 */
xrde045       varchar2(30)      ,/* 自由核算項四 */
xrde046       varchar2(30)      ,/* 自由核算項五 */
xrde047       varchar2(30)      ,/* 自由核算項六 */
xrde048       varchar2(30)      ,/* 自由核算項七 */
xrde049       varchar2(30)      ,/* 自由核算項八 */
xrde050       varchar2(30)      ,/* 自由核算項九 */
xrde051       varchar2(30)      ,/* 自由核算項十 */
xrde100       varchar2(10)      ,/* 幣別 */
xrde101       number(20,10)      ,/* 匯率 */
xrde109       number(20,6)      ,/* 原幣沖帳金額 */
xrde119       number(20,6)      ,/* 本幣沖帳金額 */
xrde120       varchar2(10)      ,/* 本位幣二幣別 */
xrde121       number(20,10)      ,/* 本位幣二匯率 */
xrde129       number(20,6)      ,/* 本位幣二沖帳金額 */
xrde130       varchar2(10)      ,/* 本位幣三幣別 */
xrde131       number(20,10)      ,/* 本位幣三匯率 */
xrde139       number(20,6)      ,/* 本位幣三沖帳金額 */
xrde032       date      /* 收款日期 */
);
alter table xrde_t add constraint xrde_pk primary key (xrdeent,xrdeld,xrdedocno,xrdeseq) enable validate;

create  index xrde_n1 on xrde_t (xrdeent,xrdeld,xrde002,xrde003,xrde008);
create  index xrde_n2 on xrde_t (xrdeent,xrdeld,xrde002,xrde013,xrde014);
create  index xrde_n3 on xrde_t (xrdeent,xrdeld,xrde029,xrde030,xrde016);
create unique index xrde_pk on xrde_t (xrdeent,xrdeld,xrdedocno,xrdeseq);

grant select on xrde_t to tiptop;
grant update on xrde_t to tiptop;
grant delete on xrde_t to tiptop;
grant insert on xrde_t to tiptop;

exit;
