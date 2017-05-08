/*
================================================================================
檔案代號:dzaa_t
檔案名稱:程式基本資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzaa_t
(
dzaa001       varchar2(20) NOT NULL,    /*程式代號                            */
dzaa002       varchar2(10) NOT NULL     /*版本                                */
);
alter table dzaa_t add constraint dzaa_pk primary key (dzaa001,dzaa002) enable validate;
grant select on dzaa_t to tiptopgp;
grant update on dzaa_t to tiptopgp;
grant delete on dzaa_t to tiptopgp;
grant insert on dzaa_t to tiptopgp;
grant index on dzaa_t to tiptopgp;
grant index on dzaa_t to public;
grant select on dzaa_t to ods;