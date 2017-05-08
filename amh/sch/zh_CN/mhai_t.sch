/* 
================================================================================
檔案代號:mhai_t
檔案名稱:績效等級資料明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mhai_t
(
mhaient       number(5)      ,/* 企業編號 */
mhaisite       varchar2(10)      ,/* 營運據點 */
mhaiunit       varchar2(10)      ,/* 應用組織 */
mhaidocno       varchar2(20)      ,/* 單據編號 */
mhaiseq       number(10,0)      ,/* 項次 */
mhai001       varchar2(20)      ,/* 人員編號 */
mhai002       varchar2(10)      ,/* 專櫃編號 */
mhai003       varchar2(20)      ,/* 身份證號碼 */
mhai004       varchar2(10)      ,/* 目前等級 */
mhai005       varchar2(10)      ,/* 考核結果 */
mhai006       varchar2(255)      ,/* 備註 */
mhai007       varchar2(10)      /* 前期等級 */
);
alter table mhai_t add constraint mhai_pk primary key (mhaient,mhaidocno,mhaiseq) enable validate;

create unique index mhai_pk on mhai_t (mhaient,mhaidocno,mhaiseq);

grant select on mhai_t to tiptop;
grant update on mhai_t to tiptop;
grant delete on mhai_t to tiptop;
grant insert on mhai_t to tiptop;

exit;
