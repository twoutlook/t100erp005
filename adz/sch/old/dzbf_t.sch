/*
================================================================================
檔案代號:dzbf_t
檔案名稱:程式串查配置檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbf_t
(
dzbf001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbf002       varchar2(10) NOT NULL,    /*版本                                */
dzbf003       varchar2(20) NOT NULL,    /*Label代號                           */
dzbf004       number(2) NOT NULL,       /*傳送順序                            */
dzbf005       varchar2(1) NOT NULL,     /*傳送類型                            */
dzbf006       varchar2(50) NOT NULL     /*傳送值                              */
);
alter table dzbf_t add constraint dzbf_pk primary key (dzbf001,dzbf002,dzbf003,dzbf004) enable validate;
grant select on dzbf_t to tiptopgp;
grant update on dzbf_t to tiptopgp;
grant delete on dzbf_t to tiptopgp;
grant insert on dzbf_t to tiptopgp;
grant index on dzbf_t to tiptopgp;
grant index on dzbf_t to public;
grant select on dzbf_t to ods;