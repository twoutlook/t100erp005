/*
================================================================================
檔案代號:dzba_t
檔案名稱:頁籤屬性資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzba_t
(
dzba001       varchar2(20) NOT NULL,    /*程式代號                            */
dzba002       varchar2(10) NOT NULL,    /*版本                                */
dzba003       varchar2(30) NOT NULL,    /*頁籤名稱                            */
dzba004       clob                      /*規格內容                            */
);
alter table dzba_t add constraint dzba_pk primary key (dzba001,dzba002,dzba003) enable validate;
grant select on dzba_t to tiptopgp;
grant update on dzba_t to tiptopgp;
grant delete on dzba_t to tiptopgp;
grant insert on dzba_t to tiptopgp;
grant index on dzba_t to tiptopgp;
grant index on dzba_t to public;
grant select on dzba_t to ods;