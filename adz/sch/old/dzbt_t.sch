/*
================================================================================
檔案代號:dzbt_t
檔案名稱:CONTROL校驗帶值配置接收設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbt_t
(
dzbt001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbt002       varchar2(10) NOT NULL,    /*版本                                */
dzbt003       varchar2(1) NOT NULL,     /*控制狀態:2.單頭編輯,3.單身瀏覽,4.單身編輯*/
dzbt004       varchar2(1) NOT NULL,     /*校驗配置點                          */
dzbt005       number(2) NOT NULL,       /*校驗順序                            */
dzbt006       number(2) NOT NULL,       /*接收順序                            */
dzbt007       varchar2(1) NOT NULL,     /*接收類型                            */
dzbt008       varchar2(50) NOT NULL     /*接收值                              */
);
alter table dzbt_t add constraint dzbt_pk primary key (dzbt001,dzbt002,dzbt003,dzbt004,dzbt005) enable validate;
grant select on dzbt_t to tiptopgp;
grant update on dzbt_t to tiptopgp;
grant delete on dzbt_t to tiptopgp;
grant insert on dzbt_t to tiptopgp;
grant index on dzbt_t to tiptopgp;
grant index on dzbt_t to public;
grant select on dzbt_t to ods;