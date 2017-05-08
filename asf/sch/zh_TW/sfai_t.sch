/* 
================================================================================
檔案代號:sfai_t
檔案名稱:工單模具檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfai_t
(
sfaient       number(5)      ,/* 企業代碼 */
sfaisite       varchar2(10)      ,/* 營運據點 */
sfaidocno       varchar2(20)      ,/* 工單單號 */
sfai001       varchar2(40)      ,/* 製品料號 */
sfai002       number(20,6)      ,/* 送樣數量 */
sfai003       varchar2(80)      ,/* 圖別 */
sfai004       varchar2(80)      ,/* 版別 */
sfai005       varchar2(80)      /* 穴數 */
);
alter table sfai_t add constraint sfai_pk primary key (sfaient,sfaidocno) enable validate;

create unique index sfai_pk on sfai_t (sfaient,sfaidocno);

grant select on sfai_t to tiptop;
grant update on sfai_t to tiptop;
grant delete on sfai_t to tiptop;
grant insert on sfai_t to tiptop;

exit;
