/* 
================================================================================
檔案代號:nmeb_t
檔案名稱:待结算卡回款差异原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmeb_t
(
nmebent       number(5)      ,/* 企業編碼 */
nmebcomp       varchar2(10)      ,/* 法人 */
nmebdocno       varchar2(20)      ,/* 單據單號 */
nmebseq       number(10,0)      ,/* 項次 */
nmebsite       varchar2(10)      ,/* 營運據點 */
nmeb001       varchar2(20)      ,/* 卡號 */
nmeb002       varchar2(8)      ,/* 交易日期 */
nmeb003       varchar2(10)      ,/* 幣別 */
nmeb004       varchar2(40)      ,/* POS機號 */
nmeb005       varchar2(10)      ,/* 收款對象 */
nmeb006       number(20,6)      ,/* 差異金額 */
nmeb007       varchar2(40)      /* 差異明細原因 */
);
alter table nmeb_t add constraint nmeb_pk primary key (nmebent,nmebcomp,nmebdocno,nmebseq) enable validate;

create unique index nmeb_pk on nmeb_t (nmebent,nmebcomp,nmebdocno,nmebseq);

grant select on nmeb_t to tiptop;
grant update on nmeb_t to tiptop;
grant delete on nmeb_t to tiptop;
grant insert on nmeb_t to tiptop;

exit;
