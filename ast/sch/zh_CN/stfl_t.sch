/* 
================================================================================
檔案代號:stfl_t
檔案名稱:專櫃合同水电费設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfl_t
(
stflent       number(5)      ,/* 企業編號 */
stflunit       varchar2(10)      ,/* 應用組織 */
stflsite       varchar2(10)      ,/* 營運據點 */
stflseq       number(10,0)      ,/* 項次 */
stfl001       varchar2(20)      ,/* 合同編號 */
stfl002       varchar2(10)      ,/* 費用編號 */
stfl003       varchar2(10)      ,/* 費用類型 */
stfl004       varchar2(10)      ,/* 價款類型 */
stfl005       varchar2(1)      ,/* 納入結算單否 */
stfl006       varchar2(1)      ,/* 票扣否 */
stfl007       number(20,6)      ,/* 單價 */
stfl008       number(10,0)      ,/* 優惠度數 */
stfl009       number(20,6)      ,/* 優惠度額 */
stflacti       varchar2(1)      /* 資料有效碼 */
);
alter table stfl_t add constraint stfl_pk primary key (stflent,stflseq,stfl001) enable validate;

create unique index stfl_pk on stfl_t (stflent,stflseq,stfl001);

grant select on stfl_t to tiptop;
grant update on stfl_t to tiptop;
grant delete on stfl_t to tiptop;
grant insert on stfl_t to tiptop;

exit;
