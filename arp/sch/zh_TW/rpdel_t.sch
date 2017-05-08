/* 
================================================================================
檔案代號:rpdel_t
檔案名稱:APP功能基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rpdel_t
(
rpdel001       varchar2(20)      ,/* APP編號 */
rpdel002       varchar2(20)      ,/* 功能編號 */
rpdel003       varchar2(6)      ,/* 語言別 */
rpdel004       varchar2(500)      ,/* 說明 */
rpdel005       varchar2(10)      /* 助記碼 */
);
alter table rpdel_t add constraint rpdel_pk primary key (rpdel001,rpdel002,rpdel003) enable validate;

create unique index rpdel_pk on rpdel_t (rpdel001,rpdel002,rpdel003);

grant select on rpdel_t to tiptop;
grant update on rpdel_t to tiptop;
grant delete on rpdel_t to tiptop;
grant insert on rpdel_t to tiptop;

exit;
