/* 
================================================================================
檔案代號:rtkg_t
檔案名稱:自動補貨建議補貨量計算公式設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table rtkg_t
(
rtkgent       number(5)      ,/* 企業編號 */
rtkgunit       varchar2(10)      ,/* 應用組織 */
rtkg001       varchar2(10)      ,/* 公式編號 */
rtkg002       varchar2(256)      ,/* 建議補貨量公式 */
rtkg011       varchar2(256)      ,/* 備貨天數公式 */
rtkg020       varchar2(10)      ,/* 安全庫存量取值方式 */
rtkg021       varchar2(256)      ,/* 安全庫存量1公式 */
rtkg022       varchar2(256)      ,/* 安全庫存量2公式 */
rtkg023       varchar2(256)      ,/* 安全庫存量3公式 */
rtkg031       varchar2(256)      ,/* 促銷庫存增量公式 */
rtkg032       varchar2(256)      ,/* 年節備貨增量公式 */
rtkg033       varchar2(256)      ,/* 休假備貨增量公式 */
rtkg041       varchar2(256)      ,/* 目標庫存量(存在目標庫存天數)公式 */
rtkg042       varchar2(256)      ,/* 目標庫存量(不存在目標庫存天數)公式 */
rtkgownid       varchar2(20)      ,/* 資料所有者 */
rtkgowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkgcrtid       varchar2(20)      ,/* 資料建立者 */
rtkgcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkgcrtdt       timestamp(0)      ,/* 資料創建日 */
rtkgmodid       varchar2(20)      ,/* 資料修改者 */
rtkgmoddt       timestamp(0)      ,/* 最近修改日 */
rtkgstus       varchar2(10)      /* 狀態碼 */
);
alter table rtkg_t add constraint rtkg_pk primary key (rtkgent,rtkg001) enable validate;

create unique index rtkg_pk on rtkg_t (rtkgent,rtkg001);

grant select on rtkg_t to tiptop;
grant update on rtkg_t to tiptop;
grant delete on rtkg_t to tiptop;
grant insert on rtkg_t to tiptop;

exit;
