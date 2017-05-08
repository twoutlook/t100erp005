/* 
================================================================================
檔案代號:minpl_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table minpl_t
(
minplent       number(5)      ,/* 企業代碼 */
minpl001       varchar2(10)      ,/* 幣別編號 */
minpl002       number(5)      ,/* 語言別 */
minpl003       varchar2(80)      ,/* 說明 */
minpl004       varchar2(10)      /* 助記碼 */
);
alter table minpl_t add constraint minpl_pk primary key (minplent,minpl001,minpl002) enable validate;

create  index minpl_01 on minpl_t (minpl004);

grant select on minpl_t to tiptop;
grant update on minpl_t to tiptop;
grant delete on minpl_t to tiptop;
grant insert on minpl_t to tiptop;

exit;
