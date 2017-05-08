/*
================================================================================
檔案代號:dzal_t
檔案名稱:Label屬性資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzal_t
(
dzal001       varchar2(20) NOT NULL,    /*程式代號                            */
dzal002       varchar2(10) NOT NULL,    /*版本                                */
dzal003       varchar2(20)  NOT NULL,   /*Label代號                           */
dzal004       varchar2(20) NOT NULL,    /*程式串查設定                        */
dzal005       clob,                     /*規格內容                            */
dzal006       varchar2(1) NOT NULL      /*是否有設定校驗                      */
);
alter table dzal_t add constraint dzal_pk primary key (dzal001,dzal002,dzal003) enable validate;
grant select on dzal_t to tiptopgp;
grant update on dzal_t to tiptopgp;
grant delete on dzal_t to tiptopgp;
grant insert on dzal_t to tiptopgp;
grant index on dzal_t to tiptopgp;
grant index on dzal_t to public;
grant select on dzal_t to ods;
