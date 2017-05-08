/*
================================================================================
檔案代號:dzax_t
檔案名稱:校驗帶值設計器資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzax_t
(
dzax001       varchar2(20) NOT NULL,    /*校驗帶值ID                          */
dzax002       varchar2(10) NOT NULL,    /*版本                                */
dzax003       varchar2(100),            /*簡述                                */
dzax004       varchar2(255),            /*說明                                */
dzax005       varchar2(20),             /*錯誤訊息代號                        */
dzax006       varchar2(1000)            /*SQL指令                             */
);
alter table dzax_t add constraint dzax_pk primary key (dzax001,dzax002) enable validate;
grant select on dzax_t to tiptopgp;
grant update on dzax_t to tiptopgp;
grant delete on dzax_t to tiptopgp;
grant insert on dzax_t to tiptopgp;
grant index on dzax_t to tiptopgp;
grant index on dzax_t to public;
grant select on dzax_t to ods;