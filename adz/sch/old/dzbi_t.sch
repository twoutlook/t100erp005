/*
================================================================================
檔案代號:dzbi_t
檔案名稱:元件規格資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbi_t
(
dzbi001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbi002       varchar2(10) NOT NULL,    /*規格版本                            */
dzbi003       varchar2(20) NOT NULL,    /*規格ID                              */
dzbi004       varchar2(255),            /*規格簡述                            */
dzbi005       clob                      /*規格內容                            */
);
alter table dzbi_t add constraint dzbi_pk primary key (dzbi001,dzbi002,dzbi003) enable validate;
grant select on dzbi_t to tiptopgp;
grant update on dzbi_t to tiptopgp;
grant delete on dzbi_t to tiptopgp;
grant insert on dzbi_t to tiptopgp;
grant index on dzbi_t to tiptopgp;
grant index on dzbi_t to public;
grant select on dzbi_t to ods;