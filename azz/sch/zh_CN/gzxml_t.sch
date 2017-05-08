/* 
================================================================================
檔案代號:gzxml_t
檔案名稱:查詢方案多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzxml_t
(
gzxmlent       number(5)      ,/* 企業編號 */
gzxml001       number(10,0)      ,/* QBE編號 */
gzxml002       varchar2(20)      ,/* 作業編號 */
gzxml003       varchar2(20)      ,/* 員工編號 */
gzxml004       varchar2(6)      ,/* 語言別 */
gzxml005       varchar2(500)      ,/* 說明 */
gzxml006       varchar2(10)      /* 註記碼 */
);
alter table gzxml_t add constraint gzxml_pk primary key (gzxmlent,gzxml001,gzxml002,gzxml003,gzxml004) enable validate;

create unique index gzxml_pk on gzxml_t (gzxmlent,gzxml001,gzxml002,gzxml003,gzxml004);

grant select on gzxml_t to tiptop;
grant update on gzxml_t to tiptop;
grant delete on gzxml_t to tiptop;
grant insert on gzxml_t to tiptop;

exit;
