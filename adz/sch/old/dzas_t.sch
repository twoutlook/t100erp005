/*
================================================================================
檔案代號:dzas_t
檔案名稱:校驗帶值配置接收設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzas_t
(
dzas001       varchar2(20) NOT NULL,    /*程式代號                            */
dzas002       varchar2(10) NOT NULL,    /*版本                                */
dzas003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzas004       number(2) NOT NULL,       /*校驗順序                            */
dzas005       number(2) NOT NULL,       /*接收順序                            */
dzas006       varchar2(1) NOT NULL,     /*接收類型                            */
dzas007       varchar2(50) NOT NULL     /*接收值                              */
);
alter table dzas_t add constraint dzas_pk primary key (dzas001,dzas002,dzas003,dzas004,dzas005) enable validate;
grant select on dzas_t to tiptopgp;
grant update on dzas_t to tiptopgp;
grant delete on dzas_t to tiptopgp;
grant insert on dzas_t to tiptopgp;
grant index on dzas_t to tiptopgp;
grant index on dzas_t to public;
grant select on dzas_t to ods;
