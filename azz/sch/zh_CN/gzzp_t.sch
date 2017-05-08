/* 
================================================================================
檔案代號:gzzp_t
檔案名稱:階層式選單設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzp_t
(
gzzpstus       varchar2(10)      ,/* 狀態碼 */
gzzp001       varchar2(20)      ,/* 程式編號 */
gzzp002       varchar2(80)      ,/* 功能編號 */
gzzp003       varchar2(80)      ,/* 上階功能編號 */
gzzp004       number(10,0)      ,/* 顯現順序 */
gzzp005       varchar2(1)      ,/* 種類 */
gzzpownid       varchar2(20)      ,/* 資料所有者 */
gzzpowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzpcrtid       varchar2(20)      ,/* 資料建立者 */
gzzpcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzpcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzpmodid       varchar2(20)      ,/* 資料修改者 */
gzzpmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzzp_t add constraint gzzp_pk primary key (gzzp001,gzzp002) enable validate;

create unique index gzzp_pk on gzzp_t (gzzp001,gzzp002);

grant select on gzzp_t to tiptop;
grant update on gzzp_t to tiptop;
grant delete on gzzp_t to tiptop;
grant insert on gzzp_t to tiptop;

exit;
