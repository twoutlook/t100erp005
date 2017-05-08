/* 
================================================================================
檔案代號:gzyi_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzyi_t
(
gzyi001       varchar2(20)      ,/* 程式編號 */
gzyi002       varchar2(4)      ,/* 歸屬模組 */
gzyi003       number(10)      ,/* 程式版次 */
gzyi004       varchar2(500)      ,/* 異動說明 */
gzyi005       varchar2(80)      ,/* MD5 */
gzyi007       timestamp(0)      ,/* 上傳更新時間 */
gzyi008       varchar2(20)      ,/* 上傳更新人員 */
gzyi006       blob      /* 程式42m */
);
alter table gzyi_t add constraint gzyi_pk primary key (gzyi001,gzyi002,gzyi003) enable validate;

create unique index gzyi_pk on gzyi_t (gzyi001,gzyi002,gzyi003);

grant select on gzyi_t to tiptop;
grant update on gzyi_t to tiptop;
grant delete on gzyi_t to tiptop;
grant insert on gzyi_t to tiptop;

exit;
