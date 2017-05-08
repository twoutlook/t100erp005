/*
================================================================================
檔案代號:dzbq_t
檔案名稱:ACTION校驗帶值配置接收設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbq_t
(
dzbq001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbq002       varchar2(10) NOT NULL,    /*版本                                */
dzbq003       varchar2(30) NOT NULL,    /*Action名稱                          */
dzbq004       number(2) NOT NULL,       /*校驗順序                            */
dzbq005       number(2) NOT NULL,       /*接收順序                            */
dzbq006       varchar2(1) NOT NULL,     /*接收類型                            */
dzbq007       varchar2(50) NOT NULL     /*接收值                              */
);
alter table dzbq_t add constraint dzbq_pk primary key (dzbq001,dzbq002,dzbq003,dzbq004,dzbq005) enable validate;
grant select on dzbq_t to tiptopgp;
grant update on dzbq_t to tiptopgp;
grant delete on dzbq_t to tiptopgp;
grant insert on dzbq_t to tiptopgp;
grant index on dzbq_t to tiptopgp;
grant index on dzbq_t to public;
grant select on dzbq_t to ods;