/* 
================================================================================
檔案代號:fmah_t
檔案名稱:融資稽覈單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmah_t
(
fmahent       number(5)      ,/* 企業編號 */
fmahdocno       varchar2(20)      ,/* 融資稽覈單號 */
fmahseq       number(10,0)      ,/* 項次 */
fmah001       varchar2(10)      ,/* 融資類型 */
fmah002       varchar2(10)      ,/* 對外融資組織 */
fmah003       varchar2(20)      ,/* 合約編號 */
fmah004       number(10,0)      ,/* 合約項次 */
fmah005       varchar2(15)      ,/* 合約銀行 */
fmah006       varchar2(10)      ,/* 融資幣別 */
fmah007       number(20,6)      ,/* 融資額度 */
fmah008       date      ,/* 融資起始日期 */
fmah009       date      ,/* 截止日期 */
fmah010       number(15,3)      /* 融資成本（年利率%） */
);
alter table fmah_t add constraint fmah_pk primary key (fmahent,fmahdocno,fmahseq) enable validate;

create unique index fmah_pk on fmah_t (fmahent,fmahdocno,fmahseq);

grant select on fmah_t to tiptop;
grant update on fmah_t to tiptop;
grant delete on fmah_t to tiptop;
grant insert on fmah_t to tiptop;

exit;
