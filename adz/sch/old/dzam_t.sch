/*
================================================================================
檔案代號:dzam_t
檔案名稱:開窗配置檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzam_t
(
dzam001       varchar2(20) NOT NULL,    /*程式代號                            */
dzam002       varchar2(10) NOT NULL,    /*版本                                */
dzam003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzam004       varchar2(20) NOT NULL     /*開窗配置                            */
);
alter table dzam_t add constraint dzam_pk primary key (dzam001,dzam002,dzam003) enable validate;
grant select on dzam_t to tiptopgp;
grant update on dzam_t to tiptopgp;
grant delete on dzam_t to tiptopgp;
grant insert on dzam_t to tiptopgp;
grant index on dzam_t to tiptopgp;
grant index on dzam_t to public;
grant select on dzam_t to ods;