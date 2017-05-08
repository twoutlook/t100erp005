/* 
================================================================================
檔案代號:stej_t
檔案名稱:專櫃合同结算帐期申请檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stej_t
(
stejent       number(5)      ,/* 企業編號 */
stejsite       varchar2(10)      ,/* 營運據點 */
stejunit       varchar2(10)      ,/* 應用組織 */
stejdocno       varchar2(20)      ,/* 單據編號 */
stejseq       number(10,0)      ,/* 帳期 */
stej001       varchar2(20)      ,/* 合同編號 */
stej002       date      ,/* 起始日期 */
stej003       date      ,/* 截止日期 */
stej004       date      ,/* 結算日期 */
stej005       varchar2(1)      ,/* 結算否 */
stej006       varchar2(20)      /* 結算單號 */
);
alter table stej_t add constraint stej_pk primary key (stejent,stejdocno,stejseq) enable validate;

create unique index stej_pk on stej_t (stejent,stejdocno,stejseq);

grant select on stej_t to tiptop;
grant update on stej_t to tiptop;
grant delete on stej_t to tiptop;
grant insert on stej_t to tiptop;

exit;
