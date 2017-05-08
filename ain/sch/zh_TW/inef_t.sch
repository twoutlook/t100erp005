/* 
================================================================================
檔案代號:inef_t
檔案名稱:盤點庫存快照資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inef_t
(
inefent       number(5)      ,/* 企業編號 */
inefunit       varchar2(10)      ,/* 應用組織 */
inefsite       varchar2(10)      ,/* 營運據點 */
inef001       varchar2(20)      ,/* 盤點計劃 */
inef002       varchar2(40)      ,/* 商品編號 */
inef003       varchar2(256)      ,/* 商品特徵 */
inef004       varchar2(30)      ,/* 庫位特徵 */
inef005       varchar2(10)      ,/* 庫位編號 */
inef006       varchar2(10)      ,/* 儲位編號 */
inef007       varchar2(30)      ,/* 批號 */
inef008       varchar2(10)      ,/* 貨架 */
inef009       varchar2(10)      ,/* 庫存單位 */
inef010       number(20,6)      ,/* 數量 */
inef011       number(20,6)      /* 單位成本 */
);
alter table inef_t add constraint inef_pk primary key (inefent,inefsite,inef001,inef002,inef003,inef004,inef005,inef006,inef007,inef008) enable validate;

create unique index inef_pk on inef_t (inefent,inefsite,inef001,inef002,inef003,inef004,inef005,inef006,inef007,inef008);

grant select on inef_t to tiptop;
grant update on inef_t to tiptop;
grant delete on inef_t to tiptop;
grant insert on inef_t to tiptop;

exit;
