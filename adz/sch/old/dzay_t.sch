/*
================================================================================
檔案代號:dzay_t
檔案名稱:校驗帶值設計器參數設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzay_t
(
dzay001       varchar2(20) NOT NULL,    /*校驗帶值ID                          */
dzay002       varchar2(10) NOT NULL,    /*版本                                */
dzay003       number(2) NOT NULL,       /*參數順序                            */
dzay004       varchar2(1) NOT NULL,     /*參數型態                            */
dzay005       varchar2(20) NOT NULL,    /*參數名稱                            */
dzay006       varchar2(50)              /*參數說明                            */
);
alter table dzay_t add constraint dzay_pk primary key (dzay001,dzay002,dzay003) enable validate;
grant select on dzay_t to tiptopgp;
grant update on dzay_t to tiptopgp;
grant delete on dzay_t to tiptopgp;
grant insert on dzay_t to tiptopgp;
grant index on dzay_t to tiptopgp;
grant index on dzay_t to public;
grant select on dzay_t to ods;
