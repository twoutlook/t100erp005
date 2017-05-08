/*
================================================================================
檔案代號:dzbj_t
檔案名稱:元件基本資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbj_t
(
dzbj001       varchar2(50) NOT NULL,    /*元件名稱                            */
dzbj002       varchar2(10) NOT NULL,    /*版本                                */
dzbj003       varchar2(255),            /*元件說明                            */
dzbj004       varchar2(1) NOT NULL,     /*讀取範圍                            */
dzbj005       varchar2(20) NOT NULL     /*程式代號                            */
);
alter table dzbj_t add constraint dzbj_pk primary key (dzbj001,dzbj002) enable validate;
grant select on dzbj_t to tiptopgp;
grant update on dzbj_t to tiptopgp;
grant delete on dzbj_t to tiptopgp;
grant insert on dzbj_t to tiptopgp;
grant index on dzbj_t to tiptopgp;
grant index on dzbj_t to public;
grant select on dzbj_t to ods;