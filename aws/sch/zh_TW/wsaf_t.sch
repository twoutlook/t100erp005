/* 
================================================================================
檔案代號:wsaf_t
檔案名稱:BPM單據流程關卡設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsaf_t
(
wsaf001       varchar2(10)      ,/* 單據性質 */
wsaf002       varchar2(40)      ,/* 本關關卡對應欄位 */
wsaf003       varchar2(40)      /* 前關關卡對應欄位 */
);
alter table wsaf_t add constraint wsaf_pk primary key (wsaf001,wsaf002) enable validate;

create unique index wsaf_pk on wsaf_t (wsaf001,wsaf002);

grant select on wsaf_t to tiptop;
grant update on wsaf_t to tiptop;
grant delete on wsaf_t to tiptop;
grant insert on wsaf_t to tiptop;

exit;
