/* 
================================================================================
檔案代號:inawl_t
檔案名稱:掃碼規則資訊檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table inawl_t
(
inawlent       number(5)      ,/* 企业代码 */
inawl001       varchar2(10)      ,/* 條碼類型 */
inawl002       number(10,0)      ,/* 總碼長 */
inawl003       varchar2(6)      ,/* 語言別 */
inawl004       varchar2(500)      /* 說明 */
);
alter table inawl_t add constraint inawl_pk primary key (inawlent,inawl001,inawl002,inawl003) enable validate;

create unique index inawl_pk on inawl_t (inawlent,inawl001,inawl002,inawl003);

grant select on inawl_t to tiptop;
grant update on inawl_t to tiptop;
grant delete on inawl_t to tiptop;
grant insert on inawl_t to tiptop;

exit;
