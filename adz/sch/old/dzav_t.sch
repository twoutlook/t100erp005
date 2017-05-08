/*
================================================================================
檔案代號:dzav_t
檔案名稱:開窗設計器畫面設定資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzav_t
(
dzav001       varchar2(20) NOT NULL,    /*開窗ID                              */
dzav002       varchar2(10) NOT NULL,    /*版本                                */
dzav003       varchar2(1) NOT NULL,     /*開窗狀態                            */
dzav004       number(2) NOT NULL,       /*欄位顯現順序                        */
dzav005       varchar2(20) NOT NULL,    /*Table名稱                           */
dzav006       varchar2(20) NOT NULL,    /*欄位名稱                            */
dzav007       varchar2(1) NOT NULL,     /*顯現物件                            */
dzav008       varchar2(1) NOT NULL,     /*是否回傳                            */
dzav009       varchar2(1) NOT NULL      /*是否重查                            */
);
alter table dzav_t add constraint dzav_pk primary key (dzav001,dzav002,dzav003,dzav004) enable validate;
grant select on dzav_t to tiptopgp;
grant update on dzav_t to tiptopgp;
grant delete on dzav_t to tiptopgp;
grant insert on dzav_t to tiptopgp;
grant index on dzav_t to tiptopgp;
grant index on dzav_t to public;
grant select on dzav_t to ods;