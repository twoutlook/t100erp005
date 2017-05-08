/* 
================================================================================
檔案代號:psjal_t
檔案名稱:採購預測策略檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table psjal_t
(
psjalent       number(5)      ,/* 企業編號 */
psjalsite       varchar2(10)      ,/* 營運據點 */
psjal001       varchar2(10)      ,/* 預測編號 */
psjal002       varchar2(6)      ,/* 語言別 */
psjal003       varchar2(500)      ,/* 說明 */
psjal004       varchar2(10)      /* 助記碼 */
);
alter table psjal_t add constraint psjal_pk primary key (psjalent,psjalsite,psjal001,psjal002) enable validate;

create unique index psjal_pk on psjal_t (psjalent,psjalsite,psjal001,psjal002);

grant select on psjal_t to tiptop;
grant update on psjal_t to tiptop;
grant delete on psjal_t to tiptop;
grant insert on psjal_t to tiptop;

exit;
