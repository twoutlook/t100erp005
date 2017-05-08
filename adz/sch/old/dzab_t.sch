/*
================================================================================
檔案代號:dzab_t
檔案名稱:程式輔助資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzab_t
(
dzab001       varchar2(20) NOT NULL,    /*程式代號                            */
dzab002       varchar2(10) NOT NULL,    /*版本                                */
dzab003       clob                      /*補充規格內容                        */
);
alter table dzab_t add constraint dzab_pk primary key (dzab001,dzab002) enable validate;
grant select on dzab_t to tiptopgp;
grant update on dzab_t to tiptopgp;
grant delete on dzab_t to tiptopgp;
grant insert on dzab_t to tiptopgp;
grant index on dzab_t to tiptopgp;
grant index on dzab_t to public;
grant select on dzab_t to ods;