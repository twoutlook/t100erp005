/* 
================================================================================
檔案代號:gzbf_t
檔案名稱:線上交談常用連絡人名單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzbf_t
(
gzbfent       number(5)      ,/* 企業碼 */
gzbf001       varchar2(20)      ,/* 人員代碼 */
gzbf002       varchar2(20)      /* 常用連絡人代碼 */
);
alter table gzbf_t add constraint gzbf_pk primary key (gzbfent,gzbf001,gzbf002) enable validate;

create unique index gzbf_pk on gzbf_t (gzbfent,gzbf001,gzbf002);

grant select on gzbf_t to tiptop;
grant update on gzbf_t to tiptop;
grant delete on gzbf_t to tiptop;
grant insert on gzbf_t to tiptop;

exit;
