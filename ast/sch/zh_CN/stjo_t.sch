/* 
================================================================================
檔案代號:stjo_t
檔案名稱:招商租賃合約結算帳期單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjo_t
(
stjoent       number(5)      ,/* 企業編號 */
stjosite       varchar2(10)      ,/* 營運組織 */
stjounit       varchar2(10)      ,/* 制定組織 */
stjoseq       number(10,0)      ,/* 結算帳期 */
stjo001       varchar2(20)      ,/* 合約編號 */
stjo002       date      ,/* 結算日期 */
stjo003       date      ,/* 起始日期 */
stjo004       date      ,/* 截止日期 */
stjo005       varchar2(1)      ,/* 已結算 */
stjo006       varchar2(20)      ,/* 結算單號 */
stjo007       varchar2(10)      /* 合約版本 */
);
alter table stjo_t add constraint stjo_pk primary key (stjoent,stjoseq,stjo001) enable validate;

create unique index stjo_pk on stjo_t (stjoent,stjoseq,stjo001);

grant select on stjo_t to tiptop;
grant update on stjo_t to tiptop;
grant delete on stjo_t to tiptop;
grant insert on stjo_t to tiptop;

exit;
