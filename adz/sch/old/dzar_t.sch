/*
================================================================================
檔案代號:dzar_t
檔案名稱:校驗帶值配置傳送設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzar_t
(
dzar001       varchar2(20) NOT NULL,    /*程式代號                            */
dzar002       varchar2(10) NOT NULL,    /*版本                                */
dzar003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzar004       number(2) NOT NULL,       /*校驗順序                            */
dzar005       number(2) NOT NULL,       /*傳送順序                            */
dzar006       varchar2(1) NOT NULL,     /*傳送類型                            */
dzar007       varchar2(50) NOT NULL     /*傳送值                              */
);
alter table dzar_t add constraint dzar_pk primary key (dzar001,dzar002,dzar003,dzar004,dzar005) enable validate;
grant select on dzar_t to tiptopgp;
grant update on dzar_t to tiptopgp;
grant delete on dzar_t to tiptopgp;
grant insert on dzar_t to tiptopgp;
grant index on dzar_t to tiptopgp;
grant index on dzar_t to public;
grant select on dzar_t to ods;
