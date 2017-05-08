/* 
================================================================================
檔案代號:ookal_t
檔案名稱:異常管理節點維護檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ookal_t
(
ookalent       number(5)      ,/* 企业代码 */
ookal001       varchar2(10)      ,/* 節點編號 */
ookal002       varchar2(6)      ,/* 語言別 */
ookal003       varchar2(500)      ,/* 節點名稱 */
ookal004       varchar2(500)      ,/* 說明 */
ookal005       varchar2(10)      /* 助記碼 */
);
alter table ookal_t add constraint ookal_pk primary key (ookalent,ookal001,ookal002) enable validate;

create unique index ookal_pk on ookal_t (ookalent,ookal001,ookal002);

grant select on ookal_t to tiptop;
grant update on ookal_t to tiptop;
grant delete on ookal_t to tiptop;
grant insert on ookal_t to tiptop;

exit;
