/*
================================================================================
檔案代號:dzai_t
檔案名稱:函式編輯區塊資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzai_t
(
dzai001       varchar2(20) NOT NULL,    /*程式代號                            */
dzai002       varchar2(10) NOT NULL,    /*版本                                */
dzai003       varchar2(50) NOT NULL,    /*函式名稱                            */
dzai004       varchar2(2) NOT NULL,     /*識別碼:c1(客製一),s(標準),c2(客製二)*/
dzai005       clob,                     /*程式區塊(Add Point)                 */
dzai006       varchar2(1) NOT NULL      /*程式區塊(Add Point)是否有效:Y/N     */
);
alter table dzai_t add constraint dzai_pk primary key (dzai001,dzai002,dzai003,dzai004) enable validate;
grant select on dzai_t to tiptopgp;
grant update on dzai_t to tiptopgp;
grant delete on dzai_t to tiptopgp;
grant insert on dzai_t to tiptopgp;
grant index on dzai_t to tiptopgp;
grant index on dzai_t to public;
grant select on dzai_t to ods;
