/* 
================================================================================
檔案代號:stio_t
檔案名稱:招商租賃合約申請結算帳期單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stio_t
(
stioent       number(5)      ,/* 企業編號 */
stiosite       varchar2(10)      ,/* 營運組織 */
stiounit       varchar2(10)      ,/* 制定組織 */
stiodocno       varchar2(20)      ,/* 單據編號 */
stioseq       number(10,0)      ,/* 結算帳期 */
stio001       varchar2(20)      ,/* 合約編號 */
stio002       date      ,/* 結算日期 */
stio003       date      ,/* 起始日期 */
stio004       date      ,/* 截止日期 */
stio005       varchar2(1)      ,/* 已結算 */
stio006       varchar2(20)      ,/* 結算單號 */
stio007       varchar2(10)      /* 合約版本 */
);
alter table stio_t add constraint stio_pk primary key (stioent,stiodocno,stioseq) enable validate;

create unique index stio_pk on stio_t (stioent,stiodocno,stioseq);

grant select on stio_t to tiptop;
grant update on stio_t to tiptop;
grant delete on stio_t to tiptop;
grant insert on stio_t to tiptop;

exit;
