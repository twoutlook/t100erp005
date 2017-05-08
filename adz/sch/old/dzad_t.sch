/*
================================================================================
檔案代號:dzad_t
檔案名稱:Action屬性資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzad_t
(
dzad001       varchar2(20) NOT NULL,    /*程式代號                            */
dzad002       varchar2(10) NOT NULL,    /*版本                                */
dzad003       varchar2(1) NOT NULL,     /*識別碼:1.單頭瀏覽,2.單頭編輯,3.單身瀏覽,4.單身編輯 */
dzad004       varchar2(30) NOT NULL,    /*Action名稱                          */
dzad005       varchar2(30),             /*快捷鍵                              */
dzad006       varchar2(1) NOT NULL,     /*權限控管:Y/N                        */
dzad007       clob,                     /*規格內容                            */
dzad008       varchar2(1) NOT NULL,     /*是否有邏輯配置:Y/N                  */
dzad009       varchar2(30) NOT NULL     /*群組代號                            */
);
alter table dzad_t add constraint dzad_pk primary key (dzad001,dzad002,dzad003,dzad004) enable validate;
grant select on dzad_t to tiptopgp;
grant update on dzad_t to tiptopgp;
grant delete on dzad_t to tiptopgp;
grant insert on dzad_t to tiptopgp;
grant index on dzad_t to tiptopgp;
grant index on dzad_t to public;
grant select on dzad_t to ods;
