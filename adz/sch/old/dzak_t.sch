/*
================================================================================
檔案代號:dzak_t
檔案名稱:程式主Table資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzak_t
(
dzak001       varchar2(20) NOT NULL,    /*程式代號                            */
dzak002       varchar2(10) NOT NULL,    /*版本                                */
dzak003       varchar2(1)  NOT NULL,    /*Table位置:1.單頭,2.單身             */
dzak004       varchar2(20) NOT NULL     /*Table代號                           */
);
alter table dzak_t add constraint dzak_pk primary key (dzak001,dzak002,dzak004) enable validate;
grant select on dzak_t to tiptopgp;
grant update on dzak_t to tiptopgp;
grant delete on dzak_t to tiptopgp;
grant insert on dzak_t to tiptopgp;
grant index on dzak_t to tiptopgp;
grant index on dzak_t to public;
grant select on dzak_t to ods;
