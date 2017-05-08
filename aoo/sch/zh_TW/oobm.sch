/* 
================================================================================
檔案代號:oobm
檔案名稱:單據流程設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oobm
(
oobment       number(5)      ,/* 企業編號 */
oobm001       varchar2(10)      ,/* 流程編號 */
oobm002       varchar2(5)      ,/* 進銷存單據別參照表 */
oobm003       varchar2(5)      ,/* 財務單據別參照表 */
oobmstus       varchar2(10)      ,/* 狀態碼 */
oobmownid       varchar2(10)      ,/* 資料所有者 */
oobmowndp       varchar2(10)      ,/* 資料所屬部門 */
oobmcrtid       varchar2(10)      ,/* 資料建立者 */
oobmcrtdp       varchar2(10)      ,/* 資料建立部門 */
oobmcrtdt       date      ,/* 資料創建日 */
oobmmodid       varchar2(10)      ,/* 資料修改者 */
oobmmoddt       date      ,/* 最近修改日 */
oobmcnfid       varchar2(10)      ,/* 資料確認者 */
oobmcnfdt       date      /* 資料確認日 */
);
alter table oobm add constraint oobm_pk primary key (oobment,oobm001) enable validate;


grant select on oobm to tiptop;
grant update on oobm to tiptop;
grant delete on oobm to tiptop;
grant insert on oobm to tiptop;

exit;
