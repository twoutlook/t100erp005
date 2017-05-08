/* 
================================================================================
檔案代號:nmbz_t
檔案名稱:內部資金排程項目利息資料單據檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmbz_t
(
nmbzent       number(5)      ,/* 企業編號 */
nmbzdocno       varchar2(20)      ,/* 利息單號 */
nmbz001       varchar2(10)      ,/* 資金中心 */
nmbz002       number(5,0)      ,/* 年度 */
nmbz003       number(5,0)      ,/* 月份 */
nmbzownid       varchar2(20)      ,/* 資料所有者 */
nmbzowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbzcrtid       varchar2(20)      ,/* 資料建立者 */
nmbzcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbzcrtdt       timestamp(0)      ,/* 資料創建日 */
nmbzmodid       varchar2(20)      ,/* 資料修改者 */
nmbzmoddt       timestamp(0)      ,/* 最近修改日 */
nmbzstus       varchar2(10)      ,/* 狀態碼 */
nmbzcnfid       varchar2(20)      ,/* 資料確認者 */
nmbzcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table nmbz_t add constraint nmbz_pk primary key (nmbzent,nmbzdocno,nmbz001,nmbz002,nmbz003) enable validate;

create unique index nmbz_pk on nmbz_t (nmbzent,nmbzdocno,nmbz001,nmbz002,nmbz003);

grant select on nmbz_t to tiptop;
grant update on nmbz_t to tiptop;
grant delete on nmbz_t to tiptop;
grant insert on nmbz_t to tiptop;

exit;
