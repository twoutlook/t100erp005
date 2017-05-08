/* 
================================================================================
檔案代號:stfal_t
檔案名稱:專櫃合同主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table stfal_t
(
stfalent       number(5)      ,/* 企業編號 */
stfal001       varchar2(20)      ,/* 合同編號 */
stfal002       varchar2(6)      ,/* 語言別 */
stfal003       varchar2(500)      ,/* 專櫃簡稱 */
stfal004       varchar2(500)      ,/* 專櫃全稱 */
stfal005       varchar2(10)      /* 助記碼 */
);
alter table stfal_t add constraint stfal_pk primary key (stfalent,stfal001,stfal002) enable validate;

create unique index stfal_pk on stfal_t (stfalent,stfal001,stfal002);

grant select on stfal_t to tiptop;
grant update on stfal_t to tiptop;
grant delete on stfal_t to tiptop;
grant insert on stfal_t to tiptop;

exit;
