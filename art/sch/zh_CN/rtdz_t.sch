/* 
================================================================================
檔案代號:rtdz_t
檔案名稱:標價籤生效範圍表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdz_t
(
rtdzent       number(5)      ,/* 企業代碼 */
rtdz001       varchar2(10)      ,/* 模板編號 */
rtdz002       varchar2(10)      ,/* 門店編號 */
rtdzownid       varchar2(20)      ,/* 資料所有者 */
rtdzowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdzcrtid       varchar2(20)      ,/* 資料建立者 */
rtdzcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdzcrtdt       timestamp(0)      ,/* 資料創建日 */
rtdzmodid       varchar2(20)      ,/* 資料修改者 */
rtdzmoddt       timestamp(0)      ,/* 最近修改日 */
rtdzstus       varchar2(10)      /* 狀態碼 */
);
alter table rtdz_t add constraint rtdz_pk primary key (rtdzent,rtdz001,rtdz002) enable validate;

create unique index rtdz_pk on rtdz_t (rtdzent,rtdz001,rtdz002);

grant select on rtdz_t to tiptop;
grant update on rtdz_t to tiptop;
grant delete on rtdz_t to tiptop;
grant insert on rtdz_t to tiptop;

exit;
