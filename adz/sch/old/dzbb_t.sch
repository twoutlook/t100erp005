/*
================================================================================
檔案代號:dzbb_t
檔案名稱:Action結構資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbb_t
(
dzbb001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbb002       varchar2(10) NOT NULL,    /*版本                                */
dzbb003       varchar2(30) NOT NULL,    /*子階                                */
dzbb004       varchar2(30) NOT NULL     /*父階                                */
);
alter table dzbb_t add constraint dzbb_pk primary key (dzbb001,dzbb002,dzbb003,dzbb004) enable validate;
grant select on dzbb_t to tiptopgp;
grant update on dzbb_t to tiptopgp;
grant delete on dzbb_t to tiptopgp;
grant insert on dzbb_t to tiptopgp;
grant index on dzbb_t to tiptopgp;
grant index on dzbb_t to public;
grant select on dzbb_t to ods;
