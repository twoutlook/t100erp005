/* 
================================================================================
檔案代號:oodcl_t
檔案名稱:稅目多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oodcl_t
(
oodclent       number(5)      ,/* 企業編號 */
oodcl001       varchar2(10)      ,/* 稅目 */
oodcl002       varchar2(6)      ,/* 語言別 */
oodcl003       varchar2(500)      ,/* 說明 */
oodcl004       varchar2(10)      /* 助記碼 */
);
alter table oodcl_t add constraint oodcl_pk primary key (oodcl001,oodcl002,oodclent) enable validate;

create  index oodcl_01 on oodcl_t (oodcl004);

grant select on oodcl_t to tiptop;
grant update on oodcl_t to tiptop;
grant delete on oodcl_t to tiptop;
grant insert on oodcl_t to tiptop;

exit;
