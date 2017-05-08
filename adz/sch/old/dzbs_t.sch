/*
================================================================================
檔案代號:dzbs_t
檔案名稱:CONTROL校驗帶值配置傳送設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbs_t
(
dzbs001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbs002       varchar2(10) NOT NULL,    /*版本                                */
dzbs003       varchar2(1) NOT NULL,     /*控制狀態:2.單頭編輯,3.單身瀏覽,4.單身編輯*/
dzbs004       varchar2(1) NOT NULL,     /*校驗配置點                          */
dzbs005       number(2) NOT NULL,       /*校驗順序                            */
dzbs006       number(2) NOT NULL,       /*傳送順序                            */
dzbs007       varchar2(1) NOT NULL,     /*傳送類型                            */
dzbs008       varchar2(50) NOT NULL     /*傳送值                              */
);
alter table dzbs_t add constraint dzbs_pk primary key (dzbs001,dzbs002,dzbs003,dzbs004,dzbs005) enable validate;
grant select on dzbs_t to tiptopgp;
grant update on dzbs_t to tiptopgp;
grant delete on dzbs_t to tiptopgp;
grant insert on dzbs_t to tiptopgp;
grant index on dzbs_t to tiptopgp;
grant index on dzbs_t to public;
grant select on dzbs_t to ods;