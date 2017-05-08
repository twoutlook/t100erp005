/* 
================================================================================
檔案代號:wsfcl_t
檔案名稱:集成常用指令档多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table wsfcl_t
(
wsfcl001       varchar2(10)      ,/* 集成接口类别 */
wsfcl002       varchar2(100)      ,/* 指令内容 */
wsfcl003       varchar2(6)      ,/* 语言别 */
wsfcl004       varchar2(500)      ,/* 说明 */
wsfcl005       varchar2(10)      /* 助记码 */
);
alter table wsfcl_t add constraint wsfcl_pk primary key (wsfcl001,wsfcl002,wsfcl003) enable validate;

create unique index wsfcl_pk on wsfcl_t (wsfcl001,wsfcl002,wsfcl003);

grant select on wsfcl_t to tiptop;
grant update on wsfcl_t to tiptop;
grant delete on wsfcl_t to tiptop;
grant insert on wsfcl_t to tiptop;

exit;
