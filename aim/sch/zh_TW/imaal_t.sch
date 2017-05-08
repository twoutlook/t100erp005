/* 
================================================================================
檔案代號:imaal_t
檔案名稱:料件多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table imaal_t
(
imaalent       number(5)      ,/* 企業編號 */
imaal001       varchar2(40)      ,/* 料號 */
imaal002       varchar2(6)      ,/* 語系 */
imaal003       varchar2(255)      ,/* 品名 */
imaal004       varchar2(255)      ,/* 規格 */
imaal005       varchar2(10)      /* 助記碼 */
);
alter table imaal_t add constraint imaal_pk primary key (imaalent,imaal001,imaal002) enable validate;

create  index imaal_01 on imaal_t (imaal005);
create unique index imaal_pk on imaal_t (imaalent,imaal001,imaal002);

grant select on imaal_t to tiptop;
grant update on imaal_t to tiptop;
grant delete on imaal_t to tiptop;
grant insert on imaal_t to tiptop;

exit;
