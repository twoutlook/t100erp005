/*
================================================================================
檔案代號:dzbv_t
檔案名稱:資料項目單身檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbv_t
(
dzbv001       varchar2(30) NOT NULL,    /*項目名稱                            */
dzbv002       varchar2(10) NOT NULL,    /*版本                                */
dzbv003       varchar2(10) NOT NULL     /*項目內存值                          */
);
alter table dzbv_t add constraint dzbv_pk primary key (dzbv001,dzbv002,dzbv003) enable validate;
grant select on dzbv_t to tiptopgp;
grant update on dzbv_t to tiptopgp;
grant delete on dzbv_t to tiptopgp;
grant insert on dzbv_t to tiptopgp;
grant index on dzbv_t to tiptopgp;
grant index on dzbv_t to public;
grant select on dzbv_t to ods;