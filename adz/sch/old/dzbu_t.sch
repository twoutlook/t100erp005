/*
================================================================================
檔案代號:dzbu_t
檔案名稱:資料項目單頭檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbu_t
(
dzbu001       varchar2(30) NOT NULL,    /*項目名稱                            */
dzbu002       varchar2(10) NOT NULL,    /*版本                                */
dzbu003       varchar2(50)              /*項目說明                            */
);
alter table dzbu_t add constraint dzbu_pk primary key (dzbu001,dzbu002) enable validate;
grant select on dzbu_t to tiptopgp;
grant update on dzbu_t to tiptopgp;
grant delete on dzbu_t to tiptopgp;
grant insert on dzbu_t to tiptopgp;
grant index on dzbu_t to tiptopgp;
grant index on dzbu_t to public;
grant select on dzbu_t to ods;