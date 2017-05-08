/* 
================================================================================
檔案代號:wsfc_t
檔案名稱:集成常用指令档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsfc_t
(
wsfc001       varchar2(10)      ,/* 集成接口类别 */
wsfc002       varchar2(100)      /* 指令内容 */
);
alter table wsfc_t add constraint wsfc_pk primary key (wsfc001,wsfc002) enable validate;

create unique index wsfc_pk on wsfc_t (wsfc001,wsfc002);

grant select on wsfc_t to tiptop;
grant update on wsfc_t to tiptop;
grant delete on wsfc_t to tiptop;
grant insert on wsfc_t to tiptop;

exit;
