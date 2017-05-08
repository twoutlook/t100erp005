/*
================================================================================
檔案代號:dzah_t
檔案名稱:函式宣告資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzah_t
(
dzah001       varchar2(20) NOT NULL,    /*程式代號                            */
dzah002       varchar2(10) NOT NULL,    /*版本                                */
dzah003       varchar2(50) NOT NULL,    /*函式名稱                            */
dzah004       varchar2(1) NOT NULL,     /*變數型態                            */
dzah005       varchar2(50) NOT NULL,    /*變數名稱                            */
dzah006       varchar2(255),            /*變數說明                            */
dzah007       varchar2(1) NOT NULL      /*是否客製:Y/N                        */
);
alter table dzah_t add constraint dzah_pk primary key (dzah001,dzah002,dzah003,dzah005) enable validate;
grant select on dzah_t to tiptopgp;
grant update on dzah_t to tiptopgp;
grant delete on dzah_t to tiptopgp;
grant insert on dzah_t to tiptopgp;
grant index on dzah_t to tiptopgp;
grant index on dzah_t to public;
grant select on dzah_t to ods;