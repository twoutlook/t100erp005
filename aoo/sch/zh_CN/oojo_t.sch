/* 
================================================================================
檔案代號:oojo_t
檔案名稱:歷史報表留存設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table oojo_t
(
oojoent       number(5)      ,/* 企業編號 */
oojosite       varchar2(10)      ,/* 營運據點 */
oojo001       varchar2(20)      ,/* 作業編號 */
oojo002       varchar2(20)      ,/* 使用者 */
oojo003       varchar2(1)      ,/* 留存類別 */
oojo004       varchar2(1)      ,/* 留存份數 */
oojostus       varchar2(10)      ,/* 狀態碼 */
oojoownid       varchar2(20)      ,/* 資料所有者 */
oojoowndp       varchar2(10)      ,/* 資料所屬部門 */
oojocrtid       varchar2(20)      ,/* 資料建立者 */
oojocrtdp       varchar2(10)      ,/* 資料建立部門 */
oojocrtdt       timestamp(0)      ,/* 資料創建日 */
oojomodid       varchar2(20)      ,/* 資料修改者 */
oojomoddt       timestamp(0)      /* 最近修改日 */
);
alter table oojo_t add constraint oojo_pk primary key (oojoent,oojosite,oojo001,oojo002,oojo003) enable validate;

create unique index oojo_pk on oojo_t (oojoent,oojosite,oojo001,oojo002,oojo003);

grant select on oojo_t to tiptop;
grant update on oojo_t to tiptop;
grant delete on oojo_t to tiptop;
grant insert on oojo_t to tiptop;

exit;
