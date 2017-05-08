/* 
================================================================================
檔案代號:chenl_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table chenl_t
(
chenlent       number(5)      ,/* 企業代碼 */
chenl001       varchar2(10)      ,/* 幣別編號 */
chenl002       number(5)      ,/* 語言別 */
chenl003       varchar2(80)      ,/* 說明 */
chenl004       varchar2(10)      /* 助記碼 */
);
alter table chenl_t add constraint chenl_pk primary key (chenlent,chenl001,chenl002) enable validate;

create  index chenl_01 on chenl_t (chenl004);

grant select on chenl_t to tiptop;
grant update on chenl_t to tiptop;
grant delete on chenl_t to tiptop;
grant insert on chenl_t to tiptop;

exit;
