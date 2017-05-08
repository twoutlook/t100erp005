/*
================================================================================
檔案代號:dzat_t
檔案名稱:開窗設計器資料檔
檔案目的:
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
*/
create table dzat_t
(
dzat001       varchar2(20) NOT NULL,    /*開窗ID                              */
dzat002       varchar2(10) NOT NULL,    /*版本                                */
dzat003       varchar2(100),            /*簡述                                */
dzat004       varchar2(255),            /*說明                                */
dzat005       varchar2(1) NOT NULL      /*是否Hard Code                       */
);
alter table dzat_t add constraint dzat_pk primary key (dzat001,dzat002) enable validate;
grant select on dzat_t to tiptopgp;
grant update on dzat_t to tiptopgp;
grant delete on dzat_t to tiptopgp;
grant insert on dzat_t to tiptopgp;
grant index on dzat_t to tiptopgp;
grant index on dzat_t to public;
grant select on dzat_t to ods;