/* 
================================================================================
檔案代號:oofgl_t
檔案名稱:自動編碼設定資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oofgl_t
(
oofglent       number(5)      ,/* 企業編號 */
oofgl001       varchar2(10)      ,/* 編碼分類 */
oofgl002       varchar2(10)      ,/* 節點編號 */
oofgl003       varchar2(6)      ,/* 語言別 */
oofgl004       varchar2(500)      ,/* 說明 */
oofgl005       varchar2(10)      /* 助記碼 */
);
alter table oofgl_t add constraint oofgl_pk primary key (oofglent,oofgl001,oofgl002,oofgl003) enable validate;

create  index oofgl_01 on oofgl_t (oofgl005);
create unique index oofgl_pk on oofgl_t (oofglent,oofgl001,oofgl002,oofgl003);

grant select on oofgl_t to tiptop;
grant update on oofgl_t to tiptop;
grant delete on oofgl_t to tiptop;
grant insert on oofgl_t to tiptop;

exit;
