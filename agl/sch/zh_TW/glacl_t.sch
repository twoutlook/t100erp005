/* 
================================================================================
檔案代號:glacl_t
檔案名稱:會計科目資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glacl_t
(
glaclent       number(5)      ,/* 企業編號 */
glacl001       varchar2(5)      ,/* 會計科目參照表號 */
glacl002       varchar2(24)      ,/* 會計科目編號 */
glacl003       varchar2(6)      ,/* 語言別 */
glacl004       varchar2(500)      ,/* 說明 */
glacl005       varchar2(10)      /* 助記碼 */
);
alter table glacl_t add constraint glacl_pk primary key (glaclent,glacl001,glacl002,glacl003) enable validate;

create  index glacl_01 on glacl_t (glacl005);
create unique index glacl_pk on glacl_t (glaclent,glacl001,glacl002,glacl003);

grant select on glacl_t to tiptop;
grant update on glacl_t to tiptop;
grant delete on glacl_t to tiptop;
grant insert on glacl_t to tiptop;

exit;
