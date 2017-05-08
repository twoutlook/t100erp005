/* 
================================================================================
檔案代號:gzzo_t
檔案名稱:模組編號設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzo_t
(
gzzostus       varchar2(10)      ,/* 狀態碼 */
gzzo001       varchar2(4)      ,/* 模組編號 */
gzzo002       varchar2(10)      ,/* 功能類別 */
gzzo003       varchar2(1)      ,/* 功能屬性 */
gzzoownid       varchar2(20)      ,/* 資料所有者 */
gzzoowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzocrtid       varchar2(20)      ,/* 資料建立者 */
gzzocrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzocrtdt       timestamp(0)      ,/* 資料創建日 */
gzzomodid       varchar2(20)      ,/* 資料修改者 */
gzzomoddt       timestamp(0)      ,/* 最近修改日 */
gzzo004       varchar2(40)      ,/* 佈景編號 */
gzzo005       varchar2(10)      ,/* 色調編號 */
gzzo006       varchar2(1)      ,/* 模組類別 */
gzzo007       varchar2(2)      ,/* 歸屬行業編號 */
gzzo008       varchar2(10)      /* 作業操作模式 */
);
alter table gzzo_t add constraint gzzo_pk primary key (gzzo001) enable validate;

create unique index gzzo_pk on gzzo_t (gzzo001);

grant select on gzzo_t to tiptop;
grant update on gzzo_t to tiptop;
grant delete on gzzo_t to tiptop;
grant insert on gzzo_t to tiptop;

exit;
