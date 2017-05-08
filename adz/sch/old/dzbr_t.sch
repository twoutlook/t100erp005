/*
================================================================================
檔案代號:dzbr_t
檔案名稱:CONTROL校驗帶值配置檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbr_t
(
dzbr001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbr002       varchar2(10) NOT NULL,    /*版本                                */
dzbr003       varchar2(1) NOT NULL,     /*控制狀態:2.單頭編輯,3.單身瀏覽,4.單身編輯*/
dzbr004       varchar2(1) NOT NULL,     /*校驗配置點                          */
dzbr005       number(2) NOT NULL,       /*校驗順序                            */
dzbr006       varchar2(1) NOT NULL,     /*校驗用途                            */
dzbr007       varchar2(50) NOT NULL,    /*校驗帶值配置                        */
dzbr008       varchar2(20)              /*錯誤訊息代號                        */
);
alter table dzbr_t add constraint dzbr_pk primary key (dzbr001,dzbr002,dzbr003,dzbr004,dzbr005) enable validate;
grant select on dzbr_t to tiptopgp;
grant update on dzbr_t to tiptopgp;
grant delete on dzbr_t to tiptopgp;
grant insert on dzbr_t to tiptopgp;
grant index on dzbr_t to tiptopgp;
grant index on dzbr_t to public;
grant select on dzbr_t to ods;