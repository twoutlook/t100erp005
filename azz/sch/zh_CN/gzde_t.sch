/* 
================================================================================
檔案代號:gzde_t
檔案名稱:子程式及應用元件基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzde_t
(
gzdeownid       varchar2(20)      ,/* 資料所有者 */
gzdeowndp       varchar2(10)      ,/* 資料所屬部門 */
gzdecrtid       varchar2(20)      ,/* 資料建立者 */
gzdecrtdp       varchar2(10)      ,/* 資料建立部門 */
gzdecrtdt       timestamp(0)      ,/* 資料創建日 */
gzdemodid       varchar2(20)      ,/* 資料修改者 */
gzdemoddt       timestamp(0)      ,/* 最近修改日 */
gzdestus       varchar2(10)      ,/* 狀態碼 */
gzde001       varchar2(20)      ,/* 規格編號 */
gzde002       varchar2(4)      ,/* 歸屬模組 */
gzde003       varchar2(1)      ,/* 規格類別 */
gzde004       varchar2(1)      ,/* 斷開樣板配置改採Free Style開發方法 */
gzde005       varchar2(1)      ,/* 程式類別 */
gzde006       varchar2(1)      ,/* 程式產生類型 */
gzde007       varchar2(1)      ,/* 程式可維護(特別開發屬性) */
gzde008       varchar2(1)      ,/* 客製 */
gzde009       varchar2(80)      /* 歸屬行業別 */
);
alter table gzde_t add constraint gzde_pk primary key (gzde001) enable validate;

create unique index gzde_pk on gzde_t (gzde001);

grant select on gzde_t to tiptop;
grant update on gzde_t to tiptop;
grant delete on gzde_t to tiptop;
grant insert on gzde_t to tiptop;

exit;
