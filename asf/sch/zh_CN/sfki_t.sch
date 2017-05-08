/* 
================================================================================
檔案代號:sfki_t
檔案名稱:工單變更單模具檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfki_t
(
sfkient       number(5)      ,/* 企業代碼 */
sfkisite       varchar2(10)      ,/* 營運據點 */
sfkidocno       varchar2(20)      ,/* 工單單號 */
sfki001       varchar2(40)      ,/* 製品料號 */
sfki002       number(20,6)      ,/* 送樣數量 */
sfki003       varchar2(80)      ,/* 圖別 */
sfki004       varchar2(80)      ,/* 版別 */
sfki005       varchar2(80)      ,/* 穴數 */
sfki900       number(10,0)      ,/* 變更序 */
sfki901       varchar2(1)      ,/* 變更類型 */
sfki902       date      ,/* 變更日期 */
sfki905       varchar2(10)      ,/* 變更理由 */
sfki906       varchar2(255)      /* 變更備註 */
);
alter table sfki_t add constraint sfki_pk primary key (sfkient,sfkidocno,sfki900) enable validate;

create unique index sfki_pk on sfki_t (sfkient,sfkidocno,sfki900);

grant select on sfki_t to tiptop;
grant update on sfki_t to tiptop;
grant delete on sfki_t to tiptop;
grant insert on sfki_t to tiptop;

exit;
