/* 
================================================================================
檔案代號:steo_t
檔案名稱:合約費用優惠執行情況明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table steo_t
(
steoent       number(5)      ,/* 企業編號 */
steounit       varchar2(10)      ,/* 制定組織 */
steosite       varchar2(10)      ,/* 營運據點 */
steoacti       varchar2(10)      ,/* 狀態 */
steodocno       varchar2(20)      ,/* 審批單號 */
steoseq       number(10,0)      ,/* 項次 */
steo001       varchar2(10)      ,/* 執行類型 */
steo002       varchar2(10)      ,/* 優惠類型 */
steo003       varchar2(10)      ,/* 費用編號 */
steo004       date      ,/* 優惠開始日期 */
steo005       date      ,/* 優惠結束日期 */
steo006       number(20,6)      ,/* 優惠金額 */
steo007       varchar2(10)      ,/* 優惠原因 */
steo008       varchar2(20)      ,/* 優惠單號 */
steo009       number(10,0)      /* 優惠項次 */
);
alter table steo_t add constraint steo_pk primary key (steoent,steodocno,steoseq) enable validate;

create unique index steo_pk on steo_t (steoent,steodocno,steoseq);

grant select on steo_t to tiptop;
grant update on steo_t to tiptop;
grant delete on steo_t to tiptop;
grant insert on steo_t to tiptop;

exit;
