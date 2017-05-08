/*
================================================================================
檔案代號:dzbk_t
檔案名稱:元件編輯區塊資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbk_t
(
dzbk001       varchar2(50) NOT NULL,    /*元件名稱                            */
dzbk002       varchar2(10) NOT NULL,    /*版本                                */
dzbk003       varchar2(1) NOT NULL,     /*識別碼                              */
dzbk004       clob,                     /*程式區塊                            */
dzbk005       varchar2(1)               /*程式區塊是否有效                    */
);
alter table dzbk_t add constraint dzbk_pk primary key (dzbk001,dzbk002,dzbk003) enable validate;
grant select on dzbk_t to tiptopgp;
grant update on dzbk_t to tiptopgp;
grant delete on dzbk_t to tiptopgp;
grant insert on dzbk_t to tiptopgp;
grant index on dzbk_t to tiptopgp;
grant index on dzbk_t to public;
grant select on dzbk_t to ods;