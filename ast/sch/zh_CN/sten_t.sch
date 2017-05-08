/* 
================================================================================
檔案代號:sten_t
檔案名稱:合約費用優惠審批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sten_t
(
stenent       number(5)      ,/* 企業編號 */
stenunit       varchar2(10)      ,/* 制定組織 */
stensite       varchar2(10)      ,/* 營運組織 */
stenseq       number(10,0)      ,/* 項次 */
stendocno       varchar2(20)      ,/* 審批單號 */
stenacti       varchar2(10)      ,/* 有效 */
sten001       varchar2(30)      ,/* 優惠類型 */
sten002       varchar2(10)      ,/* 費用編碼 */
sten003       date      ,/* 優惠開始日期 */
sten004       date      ,/* 優惠結束日期 */
sten005       number(20,6)      ,/* 優惠金額 */
sten006       number(20,6)      ,/* 優惠幅度 */
sten007       number(20,6)      ,/* 優惠單價 */
sten008       number(20,6)      ,/* 原單價 */
sten009       varchar2(10)      ,/* 優惠原因 */
sten010       varchar2(80)      ,/* 優惠前情況說明 */
sten011       varchar2(1)      /* 執行優惠否 */
);
alter table sten_t add constraint sten_pk primary key (stenent,stenseq,stendocno) enable validate;

create unique index sten_pk on sten_t (stenent,stenseq,stendocno);

grant select on sten_t to tiptop;
grant update on sten_t to tiptop;
grant delete on sten_t to tiptop;
grant insert on sten_t to tiptop;

exit;
