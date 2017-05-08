/* 
================================================================================
檔案代號:fmdh_t
檔案名稱:利息調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmdh_t
(
fmdhent       number(5)      ,/* 企業代碼 */
fmdhdocno       varchar2(20)      ,/* 融資到帳單號 */
fmdhcomp       varchar2(10)      ,/* 法人 */
fmdhseq       number(10,0)      ,/* 融資到帳項次 */
fmdh001       varchar2(20)      ,/* 融資合同號 */
fmdh002       number(10,0)      ,/* 融資合同項次 */
fmdh003       number(5,0)      ,/* 年度 */
fmdh004       number(5,0)      ,/* 期別 */
fmdh005       number(20,6)      ,/* 債券面值 */
fmdh006       number(20,6)      ,/* 到賬金額 */
fmdh007       number(20,6)      ,/* 利息調整總金額 */
fmdh008       number(20,6)      ,/* 攤銷金額 */
fmdh009       number(20,10)      ,/* 匯率一 */
fmdh010       number(20,10)      ,/* 匯率二 */
fmdh011       number(20,10)      ,/* 匯率三 */
fmdh012       number(20,6)      ,/* 利息調整總金額本幣一 */
fmdh013       number(20,6)      ,/* 利息調整總金額本幣二 */
fmdh014       number(20,6)      ,/* 利息調整總金額本幣三 */
fmdh015       varchar2(10)      ,/* 攤銷年期 */
fmdh016       number(20,6)      ,/* 攤銷金額本幣一 */
fmdh017       number(20,6)      ,/* 攤銷金額本幣二 */
fmdh018       number(20,6)      /* 攤銷金額本幣三 */
);
alter table fmdh_t add constraint fmdh_pk primary key (fmdhent,fmdhdocno,fmdhseq) enable validate;

create unique index fmdh_pk on fmdh_t (fmdhent,fmdhdocno,fmdhseq);

grant select on fmdh_t to tiptop;
grant update on fmdh_t to tiptop;
grant delete on fmdh_t to tiptop;
grant insert on fmdh_t to tiptop;

exit;
