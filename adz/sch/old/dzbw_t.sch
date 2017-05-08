/*
================================================================================
檔案代號:dzbw_t
檔案名稱:資料項目多語言檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbw_t
(
dzbw001       varchar2(30) NOT NULL,    /*項目名稱                            */
dzbw002       varchar2(10) NOT NULL,    /*版本                                */
dzbw003       varchar2(10) NOT NULL,    /*項目內存值                          */
dzbw004       varchar2(1)  NOT NULL,    /*語言別                              */
dzbw005       varchar2(100)             /*項目外顯說明                        */
);
alter table dzbw_t add constraint dzbw_pk primary key (dzbw001,dzbw002,dzbw003,dzbw004) enable validate;
grant select on dzbw_t to tiptopgp;
grant update on dzbw_t to tiptopgp;
grant delete on dzbw_t to tiptopgp;
grant insert on dzbw_t to tiptopgp;
grant index on dzbw_t to tiptopgp;
grant index on dzbw_t to public;
grant select on dzbw_t to ods;