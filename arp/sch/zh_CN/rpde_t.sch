/* 
================================================================================
檔案代號:rpde_t
檔案名稱:APP功能基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rpde_t
(
rpdeownid       varchar2(20)      ,/* 資料所有者 */
rpdeowndp       varchar2(10)      ,/* 資料所屬部門 */
rpdecrtid       varchar2(20)      ,/* 資料建立者 */
rpdecrtdp       varchar2(10)      ,/* 資料建立部門 */
rpdecrtdt       timestamp(0)      ,/* 資料創建日 */
rpdemodid       varchar2(20)      ,/* 資料修改者 */
rpdemoddt       timestamp(0)      ,/* 最近修改日 */
rpdestus       varchar2(10)      ,/* 狀態碼 */
rpde001       varchar2(20)      ,/* APP編號 */
rpde002       varchar2(20)      ,/* 功能編號 */
rpde003       varchar2(1)      ,/* 客製 */
rpde004       varchar2(500)      /* 額外參數 */
);
alter table rpde_t add constraint rpde_pk primary key (rpde001,rpde002) enable validate;

create unique index rpde_pk on rpde_t (rpde001,rpde002);

grant select on rpde_t to tiptop;
grant update on rpde_t to tiptop;
grant delete on rpde_t to tiptop;
grant insert on rpde_t to tiptop;

exit;
