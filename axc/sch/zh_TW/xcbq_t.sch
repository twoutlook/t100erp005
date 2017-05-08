/* 
================================================================================
檔案代號:xcbq_t
檔案名稱:工藝成本工時單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xcbq_t
(
xcbqent       number(5)      ,/* 企業編號 */
xcbqsite       varchar2(10)      ,/* 營運組織 */
xcbqcomp       varchar2(10)      ,/* 法人組織 */
xcbqdocno       varchar2(20)      ,/* 單據編號 */
xcbq001       date      ,/* 日期 */
xcbq002       varchar2(80)      ,/* 備註 */
xcbqownid       varchar2(20)      ,/* 資料所有者 */
xcbqowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbqcrtid       varchar2(20)      ,/* 資料建立者 */
xcbqcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbqcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbqmodid       varchar2(20)      ,/* 資料修改者 */
xcbqmoddt       timestamp(0)      ,/* 最近修改日 */
xcbqcnfid       varchar2(20)      ,/* 資料確認者 */
xcbqcnfdt       timestamp(0)      ,/* 資料確認日 */
xcbqstus       varchar2(10)      /* 狀態碼 */
);
alter table xcbq_t add constraint xcbq_pk primary key (xcbqent,xcbqdocno) enable validate;

create unique index xcbq_pk on xcbq_t (xcbqent,xcbqdocno);

grant select on xcbq_t to tiptop;
grant update on xcbq_t to tiptop;
grant delete on xcbq_t to tiptop;
grant insert on xcbq_t to tiptop;

exit;
