/* 
================================================================================
檔案代號:gzow_t
檔案名稱:標準字詞表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzow_t
(
gzow000       varchar2(500)      ,/* 繁體中文標準詞 */
gzow001       varchar2(500)      ,/* 英文標準詞 */
gzow002       varchar2(500)      ,/* 簡體中文標準詞 */
gzow003       varchar2(500)      ,/* 日文標準詞 */
gzow004       varchar2(500)      ,/* 越文標準詞 */
gzow005       varchar2(500)      ,/* 泰文標準詞 */
gzow006       varchar2(500)      ,/* 韓文標準詞 */
gzowownid       varchar2(20)      ,/* 資料所有者 */
gzowowndp       varchar2(10)      ,/* 資料所屬部門 */
gzowcrtid       varchar2(20)      ,/* 資料建立者 */
gzowcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzowcrtdt       timestamp(0)      ,/* 資料創建日 */
gzowmodid       varchar2(20)      ,/* 資料修改者 */
gzowmoddt       timestamp(0)      ,/* 最近修改日 */
gzowcnfid       varchar2(20)      ,/* 資料確認者 */
gzowcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table gzow_t add constraint gzow_pk primary key (gzow000) enable validate;

create unique index gzow_pk on gzow_t (gzow000);

grant select on gzow_t to tiptop;
grant update on gzow_t to tiptop;
grant delete on gzow_t to tiptop;
grant insert on gzow_t to tiptop;

exit;
