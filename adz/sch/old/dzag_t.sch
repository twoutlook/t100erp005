/*
================================================================================
檔案代號:dzag_t
檔案名稱:函式回傳資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzag_t
(
dzag001       varchar2(20) NOT NULL,    /*程式代號                            */
dzag002       varchar2(10) NOT NULL,    /*版本                                */
dzag003       varchar2(50) NOT NULL,    /*函式名稱                            */
dzag004       number(2) NOT NULL,       /*回傳順序                            */
dzag005       varchar2(1) NOT NULL,     /*回傳型態                            */
dzag006       varchar2(50) NOT NULL,    /*回傳名稱                            */
dzag007       varchar2(255)             /*回傳說明                            */
);
alter table dzag_t add constraint dzag_pk primary key (dzag001,dzag002,dzag003,dzag006) enable validate;
grant select on dzag_t to tiptopgp;
grant update on dzag_t to tiptopgp;
grant delete on dzag_t to tiptopgp;
grant insert on dzag_t to tiptopgp;
grant index on dzag_t to tiptopgp;
grant index on dzag_t to public;
grant select on dzag_t to ods;
