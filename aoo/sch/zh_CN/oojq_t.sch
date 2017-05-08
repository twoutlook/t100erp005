/* 
================================================================================
檔案代號:oojq_t
檔案名稱:報表郵件預設收件人單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table oojq_t
(
oojqstus       varchar2(10)      ,/* 狀態碼 */
oojqent       number(5)      ,/* 企業編號 */
oojq001       varchar2(20)      ,/* 作業編號 */
oojq002       varchar2(20)      ,/* 用戶 */
oojq003       varchar2(10)      ,/* 角色 */
oojq004       varchar2(255)      ,/* 信件主旨 */
oojq005       varchar2(500)      ,/* 信件內文 */
oojqownid       varchar2(20)      ,/* 資料所有者 */
oojqowndp       varchar2(10)      ,/* 資料所屬部門 */
oojqcrtid       varchar2(20)      ,/* 資料建立者 */
oojqcrtdp       varchar2(10)      ,/* 資料建立部門 */
oojqcrtdt       timestamp(0)      ,/* 資料創建日 */
oojqmodid       varchar2(20)      ,/* 資料修改者 */
oojqmoddt       timestamp(0)      /* 最近修改日 */
);
alter table oojq_t add constraint oojq_pk primary key (oojqent,oojq001,oojq002,oojq003) enable validate;

create unique index oojq_pk on oojq_t (oojqent,oojq001,oojq002,oojq003);

grant select on oojq_t to tiptop;
grant update on oojq_t to tiptop;
grant delete on oojq_t to tiptop;
grant insert on oojq_t to tiptop;

exit;
