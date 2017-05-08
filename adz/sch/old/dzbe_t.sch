/*
================================================================================
檔案代號:dzbe_t
檔案名稱:欄位相依配置檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzbe_t
(
dzbe001       varchar2(20) NOT NULL,    /*程式代號                            */
dzbe002       varchar2(10) NOT NULL,    /*版本                                */
dzbe003       varchar2(20) NOT NULL,    /*設定欄位                            */
dzbe004       number(2) NOT NULL,       /*順序                                */
dzbe005       varchar2(1) NOT NULL,     /*邏輯運算子                          */
dzbe006       varchar2(30) NOT NULL,    /*條件設定值                          */
dzbe007       varchar2(20) NOT NULL,    /*被影響欄位                          */
dzbe008       varchar2(30) NOT NULL     /*被影響欄位設定值                    */
);
alter table dzbe_t add constraint dzbe_pk primary key (dzbe001,dzbe002,dzbe003,dzbe004) enable validate;
grant select on dzbe_t to tiptopgp;
grant update on dzbe_t to tiptopgp;
grant delete on dzbe_t to tiptopgp;
grant insert on dzbe_t to tiptopgp;
grant index on dzbe_t to tiptopgp;
grant index on dzbe_t to public;
grant select on dzbe_t to ods;