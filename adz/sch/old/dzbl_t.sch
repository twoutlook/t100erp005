/*
================================================================================
檔案代號:dzbl_t
檔案名稱:元件參數資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbl_t
(
dzbl001       varchar2(50) NOT NULL,    /*元件名稱                            */
dzbl002       varchar2(10) NOT NULL,    /*版本                                */
dzbl003       number(2) NOT NULL,       /*參數順序                            */
dzbl004       varchar2(20) NOT NULL,     /*參數型態                            */
dzbl005       varchar2(50) NOT NULL,    /*參數名稱                            */
dzbl006       varchar2(255)             /*參數說明                            */
);
alter table dzbl_t add constraint dzbl_pk primary key (dzbl001,dzbl002,dzbl003) enable validate;
grant select on dzbl_t to tiptopgp;
grant update on dzbl_t to tiptopgp;
grant delete on dzbl_t to tiptopgp;
grant insert on dzbl_t to tiptopgp;
grant index on dzbl_t to tiptopgp;
grant index on dzbl_t to public;
grant select on dzbl_t to ods;
