/* 
================================================================================
檔案代號:mmbk_t
檔案名稱:會員卡券存放位置統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table mmbk_t
(
mmbkent       number(5)      ,/* 企業編號 */
mmbksite       varchar2(10)      ,/* 營運據點 */
mmbk000       varchar2(10)      ,/* 資料類型 */
mmbk001       varchar2(10)      ,/* 卡種編號 */
mmbk002       varchar2(10)      ,/* 存放庫位 */
mmbk003       number(10,0)      /* 存放數量 */
);
alter table mmbk_t add constraint mmbk_pk primary key (mmbkent,mmbk000,mmbk001,mmbk002) enable validate;

create unique index mmbk_pk on mmbk_t (mmbkent,mmbk000,mmbk001,mmbk002);

grant select on mmbk_t to tiptop;
grant update on mmbk_t to tiptop;
grant delete on mmbk_t to tiptop;
grant insert on mmbk_t to tiptop;

exit;
