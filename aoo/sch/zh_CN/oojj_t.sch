/* 
================================================================================
檔案代號:oojj_t
檔案名稱:報表簽核設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table oojj_t
(
oojjstus       varchar2(10)      ,/* 狀態碼 */
oojjent       number(5)      ,/* 企業編號 */
oojjsite       varchar2(10)      ,/* 營運據點 */
oojj001       varchar2(20)      ,/* 報表元件代號 */
oojj002       varchar2(5)      ,/* 單據別 */
oojj003       varchar2(4)      ,/* 模組別 */
oojj004       varchar2(20)      ,/* 單據性質 */
oojj005       varchar2(10)      ,/* 簽核代號 */
oojj006       varchar2(1)      ,/* 客制 */
oojjownid       varchar2(20)      ,/* 資料所有者 */
oojjowndp       varchar2(10)      ,/* 資料所屬部門 */
oojjcrtid       varchar2(20)      ,/* 資料建立者 */
oojjcrtdp       varchar2(10)      ,/* 資料建立部門 */
oojjcrtdt       timestamp(0)      ,/* 資料創建日 */
oojjmodid       varchar2(20)      ,/* 資料修改者 */
oojjmoddt       timestamp(0)      ,/* 最近修改日 */
oojj007       varchar2(1000)      /* 表尾備註 */
);
alter table oojj_t add constraint oojj_pk primary key (oojjent,oojjsite,oojj001,oojj002) enable validate;

create unique index oojj_pk on oojj_t (oojjent,oojjsite,oojj001,oojj002);

grant select on oojj_t to tiptop;
grant update on oojj_t to tiptop;
grant delete on oojj_t to tiptop;
grant insert on oojj_t to tiptop;

exit;
