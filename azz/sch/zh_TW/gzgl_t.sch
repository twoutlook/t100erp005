/* 
================================================================================
檔案代號:gzgl_t
檔案名稱:表頭合併資料基本檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgl_t
(
gzglstus       varchar2(10)      ,/* 狀態碼 */
gzgl001       number(10,0)      ,/* 序號 */
gzgl002       number(5,0)      ,/* 欄序 */
gzgl003       varchar2(20)      ,/* 合併內容 */
gzglownid       varchar2(20)      ,/* 資料所有者 */
gzglowndp       varchar2(10)      ,/* 資料所屬部門 */
gzglcrtid       varchar2(20)      ,/* 資料建立者 */
gzglcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzglcrtdt       timestamp(0)      ,/* 資料創建日 */
gzglmodid       varchar2(20)      ,/* 資料修改者 */
gzglmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzgl_t add constraint gzgl_pk primary key (gzgl001) enable validate;

create unique index gzgl_pk on gzgl_t (gzgl001);

grant select on gzgl_t to tiptop;
grant update on gzgl_t to tiptop;
grant delete on gzgl_t to tiptop;
grant insert on gzgl_t to tiptop;

exit;
