/* 
================================================================================
檔案代號:wsbc_t
檔案名稱:BPM 開啟附件記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsbc_t
(
wsbc001       varchar2(500)      ,/* SSOKey */
wsbc002       varchar2(500)      ,/* 附件組合Key */
wsbc003       varchar2(20)      ,/* 使用者 */
wsbc004       varchar2(40)      /* 處理時間 */
);
alter table wsbc_t add constraint wsbc_pk primary key (wsbc001) enable validate;

create unique index wsbc_pk on wsbc_t (wsbc001);

grant select on wsbc_t to tiptop;
grant update on wsbc_t to tiptop;
grant delete on wsbc_t to tiptop;
grant insert on wsbc_t to tiptop;

exit;
