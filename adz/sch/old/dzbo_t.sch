/*
================================================================================
檔案代號:dzbo_t
檔案名稱:ACTION校驗帶值配置檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbo_t
(
dzbo001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbo002       varchar2(10) NOT NULL,    /*版本                                */
dzbo003       varchar2(30) NOT NULL,    /*Action名稱                          */
dzbo004       number(2) NOT NULL,       /*校驗順序                            */
dzbo005       varchar2(1) NOT NULL,     /*校驗用途                            */
dzbo006       varchar2(50) NOT NULL,    /*校驗帶值配置                        */
dzbo007       varchar2(20)              /*錯誤訊息代號                        */
);
alter table dzbo_t add constraint dzbo_pk primary key (dzbo001,dzbo002,dzbo003,dzbo004) enable validate;
grant select on dzbo_t to tiptopgp;
grant update on dzbo_t to tiptopgp;
grant delete on dzbo_t to tiptopgp;
grant insert on dzbo_t to tiptopgp;
grant index on dzbo_t to tiptopgp;
grant index on dzbo_t to public;
grant select on dzbo_t to ods;