/* 
================================================================================
檔案代號:gzpf_t
檔案名稱:最後執行時間紀錄
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzpf_t
(
gzpfent       number(5)      ,/* 企業代碼 */
gzpf001       varchar2(20)      ,/* 作業編號 */
gzpf002       timestamp(0)      /* 最後執行時間 */
);
alter table gzpf_t add constraint gzpf_pk primary key (gzpfent,gzpf001) enable validate;

create unique index gzpf_pk on gzpf_t (gzpfent,gzpf001);

grant select on gzpf_t to tiptop;
grant update on gzpf_t to tiptop;
grant delete on gzpf_t to tiptop;
grant insert on gzpf_t to tiptop;

exit;
