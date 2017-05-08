/* 
================================================================================
檔案代號:mhah_t
檔案名稱:績效等級資料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mhah_t
(
mhahent       number(5)      ,/* 企業編號 */
mhahsite       varchar2(10)      ,/* 營運據點 */
mhahunit       varchar2(10)      ,/* 應用組織 */
mhahdocno       varchar2(20)      ,/* 單據編號 */
mhahdocdt       date      ,/* 單據日期 */
mhah001       date      ,/* 考核日期 */
mhah002       number(5,0)      ,/* 年度 */
mhah003       varchar2(10)      ,/* 所屬季度 */
mhah004       varchar2(255)      ,/* 備註 */
mhahownid       varchar2(20)      ,/* 資料所有者 */
mhahowndp       varchar2(10)      ,/* 資料所屬部門 */
mhahcrtid       varchar2(20)      ,/* 資料建立者 */
mhahcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhahcrtdt       timestamp(0)      ,/* 資料創建日 */
mhahmodid       varchar2(20)      ,/* 資料修改者 */
mhahmoddt       timestamp(0)      ,/* 最近修改日 */
mhahcnfid       varchar2(20)      ,/* 資料確認者 */
mhahcnfdt       timestamp(0)      ,/* 資料確認日 */
mhahpstid       varchar2(20)      ,/* 資料過帳者 */
mhahpstdt       timestamp(0)      ,/* 資料過帳日 */
mhahstus       varchar2(10)      /* 狀態碼 */
);
alter table mhah_t add constraint mhah_pk primary key (mhahent,mhahdocno) enable validate;

create unique index mhah_pk on mhah_t (mhahent,mhahdocno);

grant select on mhah_t to tiptop;
grant update on mhah_t to tiptop;
grant delete on mhah_t to tiptop;
grant insert on mhah_t to tiptop;

exit;
