/* 
================================================================================
檔案代號:bmbas_t
檔案名稱:產品結構研發資料單身檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table bmbas_t
(
bmbasent       number(5)      ,/* 企業代碼 */
bmbassite       varchar2(10)      ,/* 營運據點 */
bmbas001       varchar2(40)      ,/* 主件料號 */
bmbas002       varchar2(30)      ,/* 特性代碼/版本 */
bmbas003       varchar2(40)      ,/* 元件料號 */
bmbas004       varchar2(10)      ,/* 部位編號 */
bmbas005       date      ,/* 生效日期時間 */
bmbas007       varchar2(10)      ,/* 作業編號 */
bmbas008       varchar2(6)      ,/* 製程段號 */
bmbas009       varchar2(40)      ,/* 提速值 */
bmbas010       number(5,0)      /* 階層 */
);
alter table bmbas_t add constraint bmbas_pk primary key (bmbasent,bmbassite,bmbas001,bmbas002,bmbas003,bmbas004,bmbas005,bmbas007,bmbas008,bmbas009) enable validate;


grant select on bmbas_t to tiptop;
grant update on bmbas_t to tiptop;
grant delete on bmbas_t to tiptop;
grant insert on bmbas_t to tiptop;

exit;
