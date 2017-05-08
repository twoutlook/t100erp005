/* 
================================================================================
檔案代號:imckl_t
檔案名稱:流通商品主分群碼多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imckl_t
(
imcklent       number(5)      ,/* 企業編號 */
imckl001       varchar2(40)      ,/* 主分群碼 */
imckl002       varchar2(6)      ,/* 語言別 */
imckl003       varchar2(500)      ,/* 說明 */
imckl004       varchar2(10)      /* 助記碼 */
);
alter table imckl_t add constraint imckl_pk primary key (imcklent,imckl001,imckl002) enable validate;

create  index imckl_01 on imckl_t (imckl004);
create unique index imckl_pk on imckl_t (imcklent,imckl001,imckl002);

grant select on imckl_t to tiptop;
grant update on imckl_t to tiptop;
grant delete on imckl_t to tiptop;
grant insert on imckl_t to tiptop;

exit;
