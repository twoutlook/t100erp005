/*
================================================================================
檔案代號:dzbc_t
檔案名稱:資料瀏覽設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbc_t
(
dzbc001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbc002       varchar2(10) NOT NULL,    /*版本                                */
dzbc003       varchar2(30) NOT NULL     /*欄位代號                            */
);
alter table dzbc_t add constraint dzbc_pk primary key (dzbc001,dzbc002) enable validate;
grant select on dzbc_t to tiptopgp;
grant update on dzbc_t to tiptopgp;
grant delete on dzbc_t to tiptopgp;
grant insert on dzbc_t to tiptopgp;
grant index on dzbc_t to tiptopgp;
grant index on dzbc_t to public;
grant select on dzbc_t to ods;