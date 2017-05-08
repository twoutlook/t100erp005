/* 
================================================================================
檔案代號:gzgo_t
檔案名稱:報表匯出權限設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgo_t
(
gzgostus       varchar2(10)      ,/* 狀態碼 */
gzgoent       number(5)      ,/* 企業代碼 */
gzgo001       varchar2(20)      ,/* 用戶 */
gzgo002       varchar2(10)      ,/* 角色 */
gzgo003       varchar2(20)      ,/* 作業編號 */
gzgo004       varchar2(20)      ,/* 允許列印方式 */
gzgoownid       varchar2(20)      ,/* 資料所有者 */
gzgoowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgocrtid       varchar2(20)      ,/* 資料建立者 */
gzgocrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgocrtdt       timestamp(0)      ,/* 資料創建日 */
gzgomodid       varchar2(20)      ,/* 資料修改者 */
gzgomoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzgo_t add constraint gzgo_pk primary key (gzgoent,gzgo001,gzgo002,gzgo003) enable validate;

create unique index gzgo_pk on gzgo_t (gzgoent,gzgo001,gzgo002,gzgo003);

grant select on gzgo_t to tiptop;
grant update on gzgo_t to tiptop;
grant delete on gzgo_t to tiptop;
grant insert on gzgo_t to tiptop;

exit;
