/*
================================================================================
檔案代號:dzaq_t
檔案名稱:校驗帶值配置檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzaq_t
(
dzaq001       varchar2(20) NOT NULL,    /*程式代號                            */
dzaq002       varchar2(10) NOT NULL,    /*版本                                */
dzaq003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzaq004       number(2) NOT NULL,       /*校驗順序                            */
dzaq005       varchar2(1) NOT NULL,     /*校驗用途                            */
dzaq006       varchar2(50) NOT NULL,    /*校驗帶值配置                        */
dzaq007       varchar2(20) NOT NULL,    /*錯誤訊息代號                        */
dzaq008       varchar2(1) NOT NULL,     /*彈示訊息                            */
dzaq009       varchar2(1) NOT NULL      /*強制蓋值                            */
);
alter table dzaq_t add constraint dzaq_pk primary key (dzaq001,dzaq002,dzaq003,dzaq004) enable validate;
grant select on dzaq_t to tiptopgp;
grant update on dzaq_t to tiptopgp;
grant delete on dzaq_t to tiptopgp;
grant insert on dzaq_t to tiptopgp;
grant index on dzaq_t to tiptopgp;
grant index on dzaq_t to public;
grant select on dzaq_t to ods;
