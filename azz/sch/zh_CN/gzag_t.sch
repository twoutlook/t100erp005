/* 
================================================================================
檔案代號:gzag_t
檔案名稱:核算項類型資料抄寫表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzag_t
(
gzagent       number(5)      ,/* 企業編號 */
gzag001       varchar2(10)      ,/* 核算項類型編號 */
gzag002       varchar2(20)      /* 開窗查詢代號 */
);
alter table gzag_t add constraint gzag_pk primary key (gzagent,gzag001) enable validate;

create unique index gzag_pk on gzag_t (gzagent,gzag001);

grant select on gzag_t to tiptop;
grant update on gzag_t to tiptop;
grant delete on gzag_t to tiptop;
grant insert on gzag_t to tiptop;

exit;
