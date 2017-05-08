/* 
================================================================================
檔案代號:mmar_t
檔案名稱:會員卡積點異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table mmar_t
(
mmarent       number(5)      ,/* 企業編號 */
mmar001       varchar2(30)      ,/* 會員卡號 */
mmar002       varchar2(30)      ,/* 會員編號 */
mmar003       varchar2(10)      ,/* 異動來源 */
mmar004       varchar2(10)      ,/* 異動類別 */
mmar005       varchar2(20)      ,/* 異動單據編號 */
mmar006       timestamp(0)      ,/* 異動日期 */
mmar007       varchar2(10)      ,/* 異動組織 */
mmar008       number(20,6)      ,/* 消費金額 */
mmar009       number(15,3)      ,/* 本次異動積點 */
mmar010       varchar2(10)      ,/* 需求組織 */
mmarseq       number(10,0)      ,/* 異動序 */
mmar100       varchar2(40)      ,/* 請求GUID */
mmar101       varchar2(40)      /* 處理ID */
);
alter table mmar_t add constraint mmar_pk primary key (mmarent,mmar001,mmar004,mmar005,mmarseq) enable validate;

create unique index mmar_pk on mmar_t (mmarent,mmar001,mmar004,mmar005,mmarseq);

grant select on mmar_t to tiptop;
grant update on mmar_t to tiptop;
grant delete on mmar_t to tiptop;
grant insert on mmar_t to tiptop;

exit;
