/* 
================================================================================
檔案代號:stel_t
檔案名稱:專櫃合同水电费設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stel_t
(
stelent       number(5)      ,/* 企業編號 */
stelunit       varchar2(10)      ,/* 應用組織 */
steldocno       varchar2(20)      ,/* 單據編號 */
stelsite       varchar2(10)      ,/* 營運據點 */
stelseq       number(10,0)      ,/* 項次 */
stel001       varchar2(20)      ,/* 合同編號 */
stel002       varchar2(10)      ,/* 費用編號 */
stel003       varchar2(10)      ,/* 費用類型 */
stel004       varchar2(10)      ,/* 價款類型 */
stel005       varchar2(1)      ,/* 納入結算單否 */
stel006       varchar2(1)      ,/* 票扣否 */
stel007       number(20,6)      ,/* 單價 */
stel008       number(10,0)      ,/* 優惠度數 */
stel009       number(20,6)      ,/* 優惠度額 */
stelacti       varchar2(1)      /* 資料有效碼 */
);
alter table stel_t add constraint stel_pk primary key (stelent,steldocno,stelseq) enable validate;

create unique index stel_pk on stel_t (stelent,steldocno,stelseq);

grant select on stel_t to tiptop;
grant update on stel_t to tiptop;
grant delete on stel_t to tiptop;
grant insert on stel_t to tiptop;

exit;
