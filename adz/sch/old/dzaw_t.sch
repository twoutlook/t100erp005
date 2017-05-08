/*
================================================================================
檔案代號:dzaw_t
檔案名稱:開窗設計器參數設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzaw_t
(
dzaw001       varchar2(20) NOT NULL,    /*開窗ID                              */
dzaw002       varchar2(10) NOT NULL,    /*版本                                */
dzaw003       varchar2(1) NOT NULL,     /*開窗狀態                            */
dzaw004       number(2) NOT NULL,       /*參數順序                            */
dzaw005       varchar2(1) NOT NULL,     /*參數型態                            */
dzaw006       varchar2(20) NOT NULL,    /*參數名稱                            */
dzaw007       varchar2(50)              /*參數說明                            */
);
alter table dzaw_t add constraint dzaw_pk primary key (dzaw001,dzaw002,dzaw003,dzaw004) enable validate;
grant select on dzaw_t to tiptopgp;
grant update on dzaw_t to tiptopgp;
grant delete on dzaw_t to tiptopgp;
grant insert on dzaw_t to tiptopgp;
grant index on dzaw_t to tiptopgp;
grant index on dzaw_t to public;
grant select on dzaw_t to ods;
