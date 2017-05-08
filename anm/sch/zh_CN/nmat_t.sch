/* 
================================================================================
檔案代號:nmat_t
檔案名稱:網銀資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmat_t
(
nmatent       number(5)      ,/* 企業編碼 */
nmat001       varchar2(15)      ,/* 網銀編碼 */
nmat002       varchar2(10)      ,/* 支付狀態編碼 */
nmat003       varchar2(1)      ,/* 網銀交易狀態類型 */
nmatstus       varchar2(1)      ,/* 有效碼 */
nmatownid       varchar2(20)      ,/* 資料所有者 */
nmatowndp       varchar2(10)      ,/* 資料所屬部門 */
nmatcrtid       varchar2(20)      ,/* 資料建立者 */
nmatcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmatcrtdt       timestamp(0)      ,/* 資料創建日 */
nmatmodid       varchar2(20)      ,/* 資料修改者 */
nmatmoddt       timestamp(0)      /* 最近修改日 */
);
alter table nmat_t add constraint nmat_pk primary key (nmatent,nmat001,nmat002) enable validate;

create unique index nmat_pk on nmat_t (nmatent,nmat001,nmat002);

grant select on nmat_t to tiptop;
grant update on nmat_t to tiptop;
grant delete on nmat_t to tiptop;
grant insert on nmat_t to tiptop;

exit;
