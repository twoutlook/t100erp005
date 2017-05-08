/* 
================================================================================
檔案代號:mhael_t
檔案名稱:專櫃基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhael_t
(
mhaelent       number(5)      ,/* 企業編號 */
mhaelsite       varchar2(10)      ,/* 歸屬組織 */
mhael001       varchar2(10)      ,/* 專櫃編號 */
mhael020       varchar2(10)      ,/* 樓棟 */
mhael021       varchar2(10)      ,/* 樓層 */
mhael022       varchar2(6)      ,/* 語言別 */
mhael023       varchar2(80)      ,/* 簡稱 */
mhael024       varchar2(500)      ,/* 全稱 */
mhael005       varchar2(10)      /* 助記碼 */
);
alter table mhael_t add constraint mhael_pk primary key (mhaelent,mhaelsite,mhael001,mhael020,mhael021,mhael022) enable validate;

create unique index mhael_pk on mhael_t (mhaelent,mhaelsite,mhael001,mhael020,mhael021,mhael022);

grant select on mhael_t to tiptop;
grant update on mhael_t to tiptop;
grant delete on mhael_t to tiptop;
grant insert on mhael_t to tiptop;

exit;
