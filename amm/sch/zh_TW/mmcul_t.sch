/* 
================================================================================
檔案代號:mmcul_t
檔案名稱:會員等級升降策略單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmcul_t
(
mmculent       number(5)      ,/* 企業編號 */
mmcul001       varchar2(30)      ,/* 升降等策略編號 */
mmcul002       varchar2(6)      ,/* 語言別 */
mmcul003       varchar2(500)      ,/* 說明 */
mmcul004       varchar2(10)      /* 助記碼 */
);
alter table mmcul_t add constraint mmcul_pk primary key (mmculent,mmcul001,mmcul002) enable validate;

create unique index mmcul_pk on mmcul_t (mmculent,mmcul001,mmcul002);

grant select on mmcul_t to tiptop;
grant update on mmcul_t to tiptop;
grant delete on mmcul_t to tiptop;
grant insert on mmcul_t to tiptop;

exit;
