/*
================================================================================
檔案代號:dzaz_t
檔案名稱:校驗帶值設計器回傳設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzaz_t
(
dzaz001       varchar2(20) NOT NULL,    /*校驗帶值ID                          */
dzaz002       varchar2(10) NOT NULL,    /*版本                                */
dzaz003       number(2) NOT NULL,       /*回傳順序                            */
dzaz004       varchar2(1) NOT NULL,     /*回傳型態                            */
dzaz005       varchar2(20) NOT NULL,    /*回傳名稱                            */
dzaz006       varchar2(50)              /*回傳說明                            */
);
alter table dzaz_t add constraint dzaz_pk primary key (dzaz001,dzaz002,dzaz003) enable validate;
grant select on dzaz_t to tiptopgp;
grant update on dzaz_t to tiptopgp;
grant delete on dzaz_t to tiptopgp;
grant insert on dzaz_t to tiptopgp;
grant index on dzaz_t to tiptopgp;
grant index on dzaz_t to public;
grant select on dzaz_t to ods;
