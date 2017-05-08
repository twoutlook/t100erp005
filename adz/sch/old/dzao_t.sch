/*
================================================================================
檔案代號:dzao_t
檔案名稱:開窗配置傳送設定檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzao_t
(
dzao001       varchar2(20) NOT NULL,    /*程式代號                            */
dzao002       varchar2(10) NOT NULL,    /*版本                                */
dzao003       varchar2(20) NOT NULL,    /*欄位代號                            */
dzao004       varchar2(1) NOT NULL,     /*配置狀態:1.輸入,2.查詢              */
dzao005       number(2) NOT NULL,       /*傳送順序                            */
dzao006       varchar2(1) NOT NULL,     /*傳送類型                            */
dzao007       varchar2(50) NOT NULL     /*傳送值                              */
);
alter table dzao_t add constraint dzao_pk primary key (dzao001,dzao002,dzao003,dzao004,dzao005) enable validate;
grant select on dzao_t to tiptopgp;
grant update on dzao_t to tiptopgp;
grant delete on dzao_t to tiptopgp;
grant insert on dzao_t to tiptopgp;
grant index on dzao_t to tiptopgp;
grant index on dzao_t to public;
grant select on dzao_t to ods;
