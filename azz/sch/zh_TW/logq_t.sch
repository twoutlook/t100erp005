/*
================================================================================
名稱代號:用戶功能點選執行時間記錄檔 (logb_t)
檔案目的:
上游檔案:
下游檔案:
檔案類型:Z
多語系檔案:N
============.========================.==========================================
*/
create table logb_t
(
logb010        varchar2(10),            /*用戶代號                    */
logb020        varchar2(20),            /*程式代號                    */
logb030        varchar2(30),            /*AP主機提供PID紀錄        */
logb040        date,                    /*點選執行時間                */
logb050        varchar2(10),            /*點選執行功能               */
logb060        varchar2(1)              /*成功或失敗紀錄             */
);

create index logb_01 on logb_t (logb010,logb020);
grant select on logb_t to tiptopgp;
grant update on logb_t to tiptopgp;
grant delete on logb_t to tiptopgp;
grant insert on logb_t to tiptopgp;
grant index on logb_t to public;
grant select on logb_t to ods;
