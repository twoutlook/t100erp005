/* 
================================================================================
檔案代號:pmenl_t
檔案名稱:碼頭基礎資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pmenl_t
(
pmenlent       number(5)      ,/* 企業代碼 */
pmenlsite       varchar2(10)      ,/* 營運據點 */
pmenl001       varchar2(10)      ,/* 碼頭編號 */
pmenl002       varchar2(6)      ,/* 語言別 */
pmenl003       varchar2(500)      ,/* 說明 */
pmenl004       varchar2(10)      /* 助記碼 */
);
alter table pmenl_t add constraint pmenl_pk primary key (pmenlent,pmenlsite,pmenl001,pmenl002) enable validate;

create unique index pmenl_pk on pmenl_t (pmenlent,pmenlsite,pmenl001,pmenl002);

grant select on pmenl_t to tiptop;
grant update on pmenl_t to tiptop;
grant delete on pmenl_t to tiptop;
grant insert on pmenl_t to tiptop;

exit;
