/*
================================================================================
檔案代號:dzbn_t
檔案名稱:元件宣告資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbn_t
(
dzbn001       varchar2(50) NOT NULL,    /*元件名稱                            */
dzbn002       varchar2(10) NOT NULL,    /*版本                                */
dzbn003       number(2) NOT NULL,       /*變數順序                            */
dzbn004       varchar2(20) NOT NULL,    /*變數型態                            */
dzbn005       varchar2(50) NOT NULL,    /*變數名稱                            */
dzbn006       varchar2(255)             /*變數說明                            */
);
alter table dzbn_t add constraint dzbn_pk primary key (dzbn001,dzbn002,dzbn005) enable validate;
grant select on dzbn_t to tiptopgp;
grant update on dzbn_t to tiptopgp;
grant delete on dzbn_t to tiptopgp;
grant insert on dzbn_t to tiptopgp;
grant index on dzbn_t to tiptopgp;
grant index on dzbn_t to public;
grant select on dzbn_t to ods;