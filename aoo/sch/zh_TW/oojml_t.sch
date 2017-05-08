/* 
================================================================================
檔案代號:oojml_t
檔案名稱:組織基本資料申請單身檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oojml_t
(
oojmlent       number(5)      ,/* 企業編號 */
oojmldocno       varchar2(20)      ,/* 單據編號 */
oojml001       varchar2(10)      ,/* 組織編號 */
oojml002       varchar2(6)      ,/* 語言別 */
oojml003       varchar2(500)      ,/* 說明 */
oojml004       varchar2(500)      ,/* 說明(對內全稱) */
oojml005       varchar2(500)      ,/* 說明(對外全稱) */
oojml006       varchar2(10)      /* 助記碼 */
);
alter table oojml_t add constraint oojml_pk primary key (oojmlent,oojmldocno,oojml001,oojml002) enable validate;

create unique index oojml_pk on oojml_t (oojmlent,oojmldocno,oojml001,oojml002);

grant select on oojml_t to tiptop;
grant update on oojml_t to tiptop;
grant delete on oojml_t to tiptop;
grant insert on oojml_t to tiptop;

exit;
