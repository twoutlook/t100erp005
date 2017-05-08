/* 
================================================================================
檔案代號:ooac_t
檔案名稱:單據別層級參數表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table ooac_t
(
ooacent       number(5)      ,/* 企業編號 */
ooac001       varchar2(5)      ,/* 參照表號 */
ooac002       varchar2(5)      ,/* 單據別 */
ooac003       varchar2(10)      ,/* 參數編號 */
ooac004       varchar2(80)      ,/* 參數值 */
ooacownid       varchar2(20)      ,/* 資料所有者 */
ooacowndp       varchar2(10)      ,/* 資料所屬部門 */
ooaccrtid       varchar2(20)      ,/* 資料建立者 */
ooaccrtdp       varchar2(10)      ,/* 資料建立部門 */
ooaccrtdt       timestamp(0)      ,/* 資料創建日 */
ooacmodid       varchar2(20)      ,/* 資料修改者 */
ooacmoddt       timestamp(0)      ,/* 最近修改日 */
ooacstus       varchar2(10)      /* 狀態碼 */
);
alter table ooac_t add constraint ooac_pk primary key (ooacent,ooac001,ooac002,ooac003) enable validate;

create unique index ooac_pk on ooac_t (ooacent,ooac001,ooac002,ooac003);

grant select on ooac_t to tiptop;
grant update on ooac_t to tiptop;
grant delete on ooac_t to tiptop;
grant insert on ooac_t to tiptop;

exit;
