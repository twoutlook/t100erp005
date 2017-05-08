/* 
================================================================================
檔案代號:ooaa_t
檔案名稱:企業層級參數表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table ooaa_t
(
ooaaent       number(5)      ,/* 企業編號 */
ooaa001       varchar2(10)      ,/* 參數編號 */
ooaa002       varchar2(80)      ,/* 參數資料 */
ooaaownid       varchar2(20)      ,/* 資料所有者 */
ooaaowndp       varchar2(10)      ,/* 資料所屬部門 */
ooaacrtid       varchar2(20)      ,/* 資料建立者 */
ooaacrtdp       varchar2(10)      ,/* 資料建立部門 */
ooaacrtdt       timestamp(0)      ,/* 資料創建日 */
ooaamodid       varchar2(20)      ,/* 資料修改者 */
ooaamoddt       timestamp(0)      /* 最近修改日 */
);
alter table ooaa_t add constraint ooaa_pk primary key (ooaaent,ooaa001) enable validate;

create unique index ooaa_pk on ooaa_t (ooaaent,ooaa001);

grant select on ooaa_t to tiptop;
grant update on ooaa_t to tiptop;
grant delete on ooaa_t to tiptop;
grant insert on ooaa_t to tiptop;

exit;
