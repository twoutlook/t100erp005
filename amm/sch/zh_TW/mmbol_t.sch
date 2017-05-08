/* 
================================================================================
檔案代號:mmbol_t
檔案名稱:卡活動規則申請單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmbol_t
(
mmbolent       number(5)      ,/* 企業編號 */
mmboldocno       varchar2(20)      ,/* 單據編號 */
mmbol001       varchar2(6)      ,/* 語言別 */
mmbol002       varchar2(500)      ,/* 說明 */
mmbol003       varchar2(10)      /* 助記碼 */
);
alter table mmbol_t add constraint mmbol_pk primary key (mmbolent,mmboldocno,mmbol001) enable validate;

create unique index mmbol_pk on mmbol_t (mmbolent,mmboldocno,mmbol001);

grant select on mmbol_t to tiptop;
grant update on mmbol_t to tiptop;
grant delete on mmbol_t to tiptop;
grant insert on mmbol_t to tiptop;

exit;
