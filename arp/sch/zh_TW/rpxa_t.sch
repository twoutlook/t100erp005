/* 
================================================================================
檔案代號:rpxa_t
檔案名稱:APP使用者資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table rpxa_t
(
rpxaownid       varchar2(20)      ,/* 資料所有者 */
rpxaowndp       varchar2(10)      ,/* 資料所屬部門 */
rpxacrtid       varchar2(20)      ,/* 資料建立者 */
rpxacrtdp       varchar2(10)      ,/* 資料建立部門 */
rpxacrtdt       timestamp(0)      ,/* 資料創建日 */
rpxamodid       varchar2(20)      ,/* 資料修改者 */
rpxamoddt       timestamp(0)      ,/* 最近修改日 */
rpxastus       varchar2(10)      ,/* 狀態碼 */
rpxaent       number(5)      ,/* 企業代碼 */
rpxa001       varchar2(20)      ,/* 使用者編號 */
rpxa002       varchar2(20)      /* APP編號 */
);
alter table rpxa_t add constraint rpxa_pk primary key (rpxaent,rpxa001,rpxa002) enable validate;

create unique index rpxa_pk on rpxa_t (rpxaent,rpxa001,rpxa002);

grant select on rpxa_t to tiptop;
grant update on rpxa_t to tiptop;
grant delete on rpxa_t to tiptop;
grant insert on rpxa_t to tiptop;

exit;
