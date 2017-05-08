/* 
================================================================================
檔案代號:gztw_t
檔案名稱:選項項目組資料維護
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gztw_t
(
gztwstus       varchar2(10)      ,/* 狀態碼 */
gztw001       varchar2(20)      ,/* 選項項目組編號 */
gztw002       varchar2(10)      ,/* 項目內存值 */
gztwownid       varchar2(10)      ,/* 資料所有者 */
gztwowndp       varchar2(10)      ,/* 資料所屬部門 */
gztwcrtid       varchar2(10)      ,/* 資料建立者 */
gztwcrtdp       varchar2(10)      ,/* 資料建立部門 */
gztwcrtdt       date      ,/* 資料創建日 */
gztwmodid       varchar2(10)      ,/* 資料修改者 */
gztwmoddt       date      /* 最近修改日 */
);
alter table gztw_t add constraint gztw_pk primary key (gztw001,gztw002) enable validate;


grant select on gztw_t to tiptop;
grant update on gztw_t to tiptop;
grant delete on gztw_t to tiptop;
grant insert on gztw_t to tiptop;

exit;
