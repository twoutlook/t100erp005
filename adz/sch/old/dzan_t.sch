/*
================================================================================
檔案代號:dzan_t
檔案名稱:開窗配置條件設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzan_t
(
dzan001       varchar2(20) NOT NULL,    /*程式代號                            */
dzan002       varchar2(10) NOT NULL,    /*版本                                */
dzan003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzan004       varchar2(1) NOT NULL,     /*配置狀態:1.輸入,2.查詢              */
dzan005       varchar2(500)             /*額外條件                            */
);
alter table dzan_t add constraint dzan_pk primary key (dzan001,dzan002,dzan003,dzan004) enable validate;
grant select on dzan_t to tiptopgp;
grant update on dzan_t to tiptopgp;
grant delete on dzan_t to tiptopgp;
grant insert on dzan_t to tiptopgp;
grant index on dzan_t to tiptopgp;
grant index on dzan_t to public;
grant select on dzan_t to ods;