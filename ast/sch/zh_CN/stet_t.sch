/* 
================================================================================
檔案代號:stet_t
檔案名稱:结算单冲抵金额资料档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stet_t
(
stetent       number(5)      ,/* 企業編號 */
stetsite       varchar2(10)      ,/* 所屬組織 */
stetcomp       varchar2(10)      ,/* 所屬法人 */
stetdocno       varchar2(20)      ,/* 單據編號 */
stetseq       number(10,0)      ,/* 單據項次 */
stet001       varchar2(10)      ,/* 來源類型 */
stet002       varchar2(20)      ,/* 來源單據 */
stet003       number(20,6)      ,/* 單據金額 */
stet004       number(20,6)      ,/* 衝抵金額 */
stet005       timestamp(0)      ,/* 錄入日期 */
stet006       varchar2(20)      ,/* 錄入人員 */
stet007       varchar2(10)      /* 專櫃編號 */
);
alter table stet_t add constraint stet_pk primary key (stetent,stetdocno,stetseq) enable validate;

create unique index stet_pk on stet_t (stetent,stetdocno,stetseq);

grant select on stet_t to tiptop;
grant update on stet_t to tiptop;
grant delete on stet_t to tiptop;
grant insert on stet_t to tiptop;

exit;
