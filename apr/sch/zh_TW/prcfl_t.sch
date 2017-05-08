/* 
================================================================================
檔案代號:prcfl_t
檔案名稱:促銷方案多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table prcfl_t
(
prcflent       number(5)      ,/* 企業編號 */
prcfl001       varchar2(30)      ,/* 促銷方案 */
prcfl002       varchar2(6)      ,/* 語言別 */
prcfl003       varchar2(500)      ,/* 說明 */
prcfl004       varchar2(10)      /* 助記碼 */
);
alter table prcfl_t add constraint prcfl_pk primary key (prcflent,prcfl001,prcfl002) enable validate;

create unique index prcfl_pk on prcfl_t (prcflent,prcfl001,prcfl002);

grant select on prcfl_t to tiptop;
grant update on prcfl_t to tiptop;
grant delete on prcfl_t to tiptop;
grant insert on prcfl_t to tiptop;

exit;
