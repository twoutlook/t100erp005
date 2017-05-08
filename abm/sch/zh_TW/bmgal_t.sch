/* 
================================================================================
檔案代號:bmgal_t
檔案名稱:BOM群組替代單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bmgal_t
(
bmgalent       number(5)      ,/* 企業編號 */
bmgalsite       varchar2(10)      ,/* 營運據點 */
bmgal001       varchar2(40)      ,/* 主件料號 */
bmgal002       varchar2(30)      ,/* 特性/版本 */
bmgal003       varchar2(10)      ,/* 替代群組 */
bmgal004       varchar2(6)      ,/* 語言別 */
bmgal005       varchar2(500)      /* 說明 */
);
alter table bmgal_t add constraint bmgal_pk primary key (bmgalent,bmgalsite,bmgal001,bmgal002,bmgal003,bmgal004) enable validate;

create unique index bmgal_pk on bmgal_t (bmgalent,bmgalsite,bmgal001,bmgal002,bmgal003,bmgal004);

grant select on bmgal_t to tiptop;
grant update on bmgal_t to tiptop;
grant delete on bmgal_t to tiptop;
grant insert on bmgal_t to tiptop;

exit;
