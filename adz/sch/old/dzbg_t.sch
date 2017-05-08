/*
================================================================================
檔案代號:dzbg_t
檔案名稱:元件程式資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbg_t
(
dzbg001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbg002       varchar2(255),            /*程式說明                            */
dzbg003       varchar2(1) NOT NULL      /*所屬模組                            */
);
alter table dzbg_t add constraint dzbg_pk primary key (dzbg001) enable validate;
grant select on dzbg_t to tiptopgp;
grant update on dzbg_t to tiptopgp;
grant delete on dzbg_t to tiptopgp;
grant insert on dzbg_t to tiptopgp;
grant index on dzbg_t to tiptopgp;
grant index on dzbg_t to public;
grant select on dzbg_t to ods;
