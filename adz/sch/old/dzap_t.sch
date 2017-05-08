/*
================================================================================
檔案代號:dzap_t
檔案名稱:開窗配置接收設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzap_t
(
dzap001       varchar2(20) NOT NULL,    /*程式代號                            */
dzap002       varchar2(10) NOT NULL,    /*版本                                */
dzap003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzap004       varchar2(1) NOT NULL,     /*配置狀態:1.輸入,2.查詢              */
dzap005       number(2) NOT NULL,       /*接收順序                            */
dzap006       varchar2(1) NOT NULL,     /*接收類型                            */
dzap007       varchar2(50) NOT NULL     /*接收值                              */
);
alter table dzap_t add constraint dzap_pk primary key (dzap001,dzap002,dzap003,dzap004,dzap005) enable validate;
grant select on dzap_t to tiptopgp;
grant update on dzap_t to tiptopgp;
grant delete on dzap_t to tiptopgp;
grant insert on dzap_t to tiptopgp;
grant index on dzap_t to tiptopgp;
grant index on dzap_t to public;
grant select on dzap_t to ods;
