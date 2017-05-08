/* 
================================================================================
檔案代號:stbk_t
檔案名稱:自營合約補充條款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbk_t
(
stbkent       number(5)      ,/* 企業代碼 */
stbk001       varchar2(20)      ,/* 合約編號 */
stbk002       number(10,0)      ,/* 項次 */
stbk003       varchar2(500)      /* 補充條款 */
);
alter table stbk_t add constraint stbk_pk primary key (stbkent,stbk001,stbk002) enable validate;

create unique index stbk_pk on stbk_t (stbkent,stbk001,stbk002);

grant select on stbk_t to tiptop;
grant update on stbk_t to tiptop;
grant delete on stbk_t to tiptop;
grant insert on stbk_t to tiptop;

exit;
