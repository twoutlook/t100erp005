/* 
================================================================================
檔案代號:glgb_t
檔案名稱:傳票預覽單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glgb_t
(
glgbent       number(5)      ,/* 企業編號 */
glgbld       varchar2(5)      ,/* 帳別(套)編號 */
glgbcomp       varchar2(10)      ,/* 營運據點(法人) */
glgbdocno       varchar2(20)      ,/* 單據編號 */
glgbseq       number(10,0)      ,/* 項次 */
glgb100       varchar2(4)      ,/* 系統別 */
glgb101       varchar2(10)      ,/* 類別 */
glgb001       varchar2(255)      ,/* 摘要 */
glgb002       varchar2(24)      ,/* 科目編號 */
glgb003       number(20,6)      ,/* 借方金額 */
glgb004       number(20,6)      ,/* 貸方金額 */
glgb005       varchar2(10)      ,/* 交易幣別 */
glgb006       number(20,10)      ,/* 匯率 */
glgb007       varchar2(10)      ,/* 計價單位 */
glgb008       number(20,6)      ,/* 數量 */
glgb009       number(20,6)      ,/* 單價 */
glgb010       number(20,6)      ,/* 原幣金額 */
glgb011       varchar2(20)      ,/* 票據號碼 */
glgb012       date      ,/* 票據日期 */
glgb013       varchar2(10)      ,/* 收付對象 */
glgb014       varchar2(30)      ,/* 銀行帳號 */
glgb015       varchar2(10)      ,/* 結算方式 */
glgb016       varchar2(1)      ,/* 收支項目 */
glgb017       varchar2(10)      ,/* 營運據點 */
glgb018       varchar2(10)      ,/* 部門 */
glgb019       varchar2(10)      ,/* 利潤/成本中心 */
glgb020       varchar2(10)      ,/* 區域 */
glgb021       varchar2(10)      ,/* 交易客商 */
glgb022       varchar2(10)      ,/* 帳款客商 */
glgb023       varchar2(10)      ,/* 客群 */
glgb024       varchar2(10)      ,/* 產品類別 */
glgb025       varchar2(20)      ,/* 人員 */
glgb026       varchar2(10)      ,/* 預算編號（20140904改為nouse) */
glgb027       varchar2(20)      ,/* 專案編號 */
glgb028       varchar2(30)      ,/* WBS */
glgb029       varchar2(30)      ,/* 自由核算項一 */
glgb030       varchar2(30)      ,/* 自由核算項二 */
glgb031       varchar2(30)      ,/* 自由核算項三 */
glgb032       varchar2(30)      ,/* 自由核算項四 */
glgb033       varchar2(30)      ,/* 自由核算項五 */
glgb034       varchar2(30)      ,/* 自由核算項六 */
glgb035       varchar2(30)      ,/* 自由核算項七 */
glgb036       varchar2(30)      ,/* 自由核算項八 */
glgb037       varchar2(30)      ,/* 自由核算項九 */
glgb038       varchar2(30)      ,/* 自由核算項十 */
glgb039       number(20,10)      ,/* 匯率(本位幣二) */
glgb040       number(20,6)      ,/* 借方金額(本位幣二) */
glgb041       number(20,6)      ,/* 貸方金額(本位幣二) */
glgb042       number(20,10)      ,/* 匯率(本位幣三) */
glgb043       number(20,6)      ,/* 借方金額(本位幣三) */
glgb044       number(20,6)      ,/* 貸方金額(本位幣三) */
glgb051       varchar2(10)      ,/* 經營方式 */
glgb052       varchar2(10)      ,/* 渠道 */
glgb053       varchar2(10)      ,/* 品牌 */
glgb054       varchar2(4)      ,/* 銀行存提碼 */
glgb055       varchar2(4)      ,/* 現金變動碼 */
glgb056       varchar2(30)      /* 銀行帳戶 */
);
alter table glgb_t add constraint glgb_pk primary key (glgbent,glgbld,glgbdocno,glgbseq,glgb100,glgb101) enable validate;

create unique index glgb_pk on glgb_t (glgbent,glgbld,glgbdocno,glgbseq,glgb100,glgb101);

grant select on glgb_t to tiptop;
grant update on glgb_t to tiptop;
grant delete on glgb_t to tiptop;
grant insert on glgb_t to tiptop;

exit;
