/* 
================================================================================
檔案代號:gzjb_t
檔案名稱:整合產品參數表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzjb_t
(
gzjb001       varchar2(40)      ,/* 服務規格編號 */
gzjb002       varchar2(40)      ,/* XML資料表 */
gzjb003       varchar2(40)      ,/* ERP欄位 */
gzjb004       varchar2(40)      ,/* XML欄位 */
gzjb005       varchar2(1)      ,/* XML 資料類型 */
gzjbownid       varchar2(20)      ,/* 資料所有者 */
gzjbowndp       varchar2(10)      ,/* 資料所屬部門 */
gzjbcrtid       varchar2(20)      ,/* 資料建立者 */
gzjbcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzjbcrtdt       timestamp(0)      ,/* 資料創建日 */
gzjbmodid       varchar2(20)      ,/* 資料修改者 */
gzjbmoddt       timestamp(0)      ,/* 最近修改日 */
gzjbstus       varchar2(10)      /* 狀態碼 */
);
alter table gzjb_t add constraint gzjb_pk primary key (gzjb001,gzjb002,gzjb004) enable validate;

create unique index gzjb_pk on gzjb_t (gzjb001,gzjb002,gzjb004);

grant select on gzjb_t to tiptop;
grant update on gzjb_t to tiptop;
grant delete on gzjb_t to tiptop;
grant insert on gzjb_t to tiptop;

exit;
