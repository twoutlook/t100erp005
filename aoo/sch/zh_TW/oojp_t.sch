/* 
================================================================================
檔案代號:oojp_t
檔案名稱:歷史報表查詢資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table oojp_t
(
oojpent       number(5)      ,/* 企業編號 */
oojpsite       varchar2(10)      ,/* 營運據點 */
oojp001       varchar2(20)      ,/* 作業編號 */
oojp002       varchar2(20)      ,/* 製表人 */
oojp003       varchar2(10)      ,/* 角色 */
oojp004       timestamp(0)      ,/* 建立時間 */
oojp005       varchar2(255)      ,/* 歷史報表檔名 */
oojp006       varchar2(1)      /* 有效否 */
);
alter table oojp_t add constraint oojp_pk primary key (oojpent,oojpsite,oojp001,oojp002,oojp004) enable validate;

create unique index oojp_pk on oojp_t (oojpent,oojpsite,oojp001,oojp002,oojp004);

grant select on oojp_t to tiptop;
grant update on oojp_t to tiptop;
grant delete on oojp_t to tiptop;
grant insert on oojp_t to tiptop;

exit;
