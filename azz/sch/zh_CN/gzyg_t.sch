/* 
================================================================================
檔案代號:gzyg_t
檔案名稱:部門最大上線人數設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzyg_t
(
gzygent       number(5)      ,/* 企業代碼 */
gzyg001       varchar2(10)      ,/* 部門編號 */
gzyg002       number(10,0)      ,/* 上線人數 */
gzygownid       varchar2(20)      ,/* 資料所有者 */
gzygowndp       varchar2(10)      ,/* 資料所屬部門 */
gzygcrtid       varchar2(20)      ,/* 資料建立者 */
gzygcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzygcrtdt       timestamp(0)      ,/* 資料創建日 */
gzygmodid       varchar2(20)      ,/* 資料修改者 */
gzygmoddt       timestamp(0)      ,/* 最近修改日 */
gzygstus       varchar2(10)      /* 狀態碼 */
);
alter table gzyg_t add constraint gzyg_pk primary key (gzygent,gzyg001) enable validate;

create unique index gzyg_pk on gzyg_t (gzygent,gzyg001);

grant select on gzyg_t to tiptop;
grant update on gzyg_t to tiptop;
grant delete on gzyg_t to tiptop;
grant insert on gzyg_t to tiptop;

exit;
