/*
================================================================================
檔案代號:dzbm_t
檔案名稱:元件回傳資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbm_t
(
dzbm001       varchar2(50) NOT NULL,    /*元件名稱                            */
dzbm002       varchar2(10) NOT NULL,    /*版本                                */
dzbm003       number(2) NOT NULL,       /*回傳順序                            */
dzbm004       varchar2(20) NOT NULL,    /*回傳型態                            */
dzbm005       varchar2(50) NOT NULL,    /*回傳名稱                            */
dzbm006       varchar2(255)             /*回傳說明                            */
);
alter table dzbm_t add constraint dzbm_pk primary key (dzbm001,dzbm002,dzbm005) enable validate;
grant select on dzbm_t to tiptopgp;
grant update on dzbm_t to tiptopgp;
grant delete on dzbm_t to tiptopgp;
grant insert on dzbm_t to tiptopgp;
grant index on dzbm_t to tiptopgp;
grant index on dzbm_t to public;
grant select on dzbm_t to ods;