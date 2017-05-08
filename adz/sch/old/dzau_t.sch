/*
================================================================================
檔案代號:dzau_t
檔案名稱:開窗設計器SQL資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzau_t
(
dzau001       varchar2(20) NOT NULL,    /*開窗ID                              */
dzau002       varchar2(10) NOT NULL,    /*版本                                */
dzau003       varchar2(1) NOT NULL,     /*開窗狀態                            */
dzau004       varchar2(1000)            /*SQL指令                             */
);
alter table dzau_t add constraint dzau_pk primary key (dzau001,dzau002,dzau003) enable validate;
grant select on dzau_t to tiptopgp;
grant update on dzau_t to tiptopgp;
grant delete on dzau_t to tiptopgp;
grant insert on dzau_t to tiptopgp;
grant index on dzau_t to tiptopgp;
grant index on dzau_t to public;
grant select on dzau_t to ods;