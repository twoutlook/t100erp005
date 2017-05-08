/* 
================================================================================
檔案代號:mmakl_t
檔案名稱:卡種基本資料申請檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmakl_t
(
mmaklent       number(5)      ,/* 企業編號 */
mmakldocno       varchar2(20)      ,/* 申請單號 */
mmakl001       varchar2(6)      ,/* 語言別 */
mmakl002       varchar2(500)      ,/* 說明 */
mmakl003       varchar2(10)      /* 助記碼 */
);
alter table mmakl_t add constraint mmakl_pk primary key (mmaklent,mmakldocno,mmakl001) enable validate;

create  index mmakl_01 on mmakl_t (mmakl003);
create unique index mmakl_pk on mmakl_t (mmaklent,mmakldocno,mmakl001);

grant select on mmakl_t to tiptop;
grant update on mmakl_t to tiptop;
grant delete on mmakl_t to tiptop;
grant insert on mmakl_t to tiptop;

exit;
