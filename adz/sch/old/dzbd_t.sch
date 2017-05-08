/*
================================================================================
檔案代號:dzbd_t
檔案名稱:工具列失效設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbd_t
(
dzbd001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbd002       varchar2(10) NOT NULL,    /*版本                                */
dzbd003       varchar2(30) NOT NULL     /*Action代號                          */
);
alter table dzbd_t add constraint dzbd_pk primary key (dzbd001,dzbd002) enable validate;
grant select on dzbd_t to tiptopgp;
grant update on dzbd_t to tiptopgp;
grant delete on dzbd_t to tiptopgp;
grant insert on dzbd_t to tiptopgp;
grant index on dzbd_t to tiptopgp;
grant index on dzbd_t to public;
grant select on dzbd_t to ods;