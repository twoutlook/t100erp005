/*
================================================================================
檔案代號:dzbp_t
檔案名稱:ACTION校驗帶值配置傳送設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbp_t
(
dzbp001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbp002       varchar2(10) NOT NULL,    /*版本                                */
dzbp003       varchar2(30) NOT NULL,    /*Action名稱                          */
dzbp004       number(2) NOT NULL,       /*校驗順序                            */
dzbp005       number(2) NOT NULL,       /*傳送順序                            */
dzbp006       varchar2(1) NOT NULL,     /*傳送類型                            */
dzbp007       varchar2(50) NOT NULL     /*傳送值                              */
);
alter table dzbp_t add constraint dzbp_pk primary key (dzbp001,dzbp002,dzbp003,dzbp004,dzbp005) enable validate;
grant select on dzbp_t to tiptopgp;
grant update on dzbp_t to tiptopgp;
grant delete on dzbp_t to tiptopgp;
grant insert on dzbp_t to tiptopgp;
grant index on dzbp_t to tiptopgp;
grant index on dzbp_t to public;
grant select on dzbp_t to ods;