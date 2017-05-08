/* 
================================================================================
檔案代號:wsfb_t
檔案名稱:集成xml记录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsfb_t
(
wsfb001       varchar2(40)      ,/* 服务名称 */
wsfb002       number(10,0)      ,/* process_id */
wsfb003       varchar2(40)      ,/* 起始时间 */
wsfb004       varchar2(500)      /* xml内容 */
);
alter table wsfb_t add constraint wsfb_pk primary key (wsfb001,wsfb002,wsfb003) enable validate;

create unique index wsfb_pk on wsfb_t (wsfb001,wsfb002,wsfb003);

grant select on wsfb_t to tiptop;
grant update on wsfb_t to tiptop;
grant delete on wsfb_t to tiptop;
grant insert on wsfb_t to tiptop;

exit;
