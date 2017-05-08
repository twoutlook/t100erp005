/*
================================================================================
檔案代號:dzae_t
檔案名稱:函式基本資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzae_t
(
dzae001       varchar2(20) NOT NULL,    /*程式代號                            */
dzae002       varchar2(10) NOT NULL,    /*版本                                */
dzae003       varchar2(50) NOT NULL,    /*函式名稱                            */
dzae004       varchar2(255) NOT NULL,   /*函式說明                            */
dzae005       varchar2(1) NOT NULL      /*讀取範圍:1.PRIVATE,2.PUBLIC         */
);
alter table dzae_t add constraint dzae_pk primary key (dzae001,dzae002,dzae003) enable validate;
grant select on dzae_t to tiptopgp;
grant update on dzae_t to tiptopgp;
grant delete on dzae_t to tiptopgp;
grant insert on dzae_t to tiptopgp;
grant index on dzae_t to tiptopgp;
grant index on dzae_t to public;
grant select on dzae_t to ods;