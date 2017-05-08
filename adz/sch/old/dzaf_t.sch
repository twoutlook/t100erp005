/*
================================================================================
檔案代號:dzaf_t
檔案名稱:函式參數資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzaf_t
(
dzaf001       varchar2(20) NOT NULL,    /*程式代號                            */
dzaf002       varchar2(10) NOT NULL,    /*版本                                */
dzaf003       varchar2(50) NOT NULL,    /*函式名稱                            */
dzaf004       number(2) NOT NULL,       /*參數順序                            */
dzaf005       varchar2(1) NOT NULL,     /*參數型態                            */
dzaf006       varchar2(50) NOT NULL,    /*參數名稱                            */
dzaf007       varchar2(255)             /*參數說明                            */
);
alter table dzaf_t add constraint dzaf_pk primary key (dzaf001,dzaf002,dzaf003,dzaf006) enable validate;
grant select on dzaf_t to tiptopgp;
grant update on dzaf_t to tiptopgp;
grant delete on dzaf_t to tiptopgp;
grant insert on dzaf_t to tiptopgp;
grant index on dzaf_t to tiptopgp;
grant index on dzaf_t to public;
grant select on dzaf_t to ods;
