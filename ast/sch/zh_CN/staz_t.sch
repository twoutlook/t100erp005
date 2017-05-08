/* 
================================================================================
檔案代號:staz_t
檔案名稱:自營合約自定義範圍設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table staz_t
(
stazent       number(5)      ,/* 企業編號 */
staz001       varchar2(20)      ,/* 合同編號 */
stazseq1       number(10,0)      ,/* 項次 */
stazseq2       number(10,0)      ,/* 項次2 */
staz002       varchar2(10)      ,/* 範圍類型 */
staz003       varchar2(10)      ,/* 屬性類型 */
staz004       varchar2(40)      ,/* 類型編號 */
staz005       varchar2(10)      /* 方向 */
);
alter table staz_t add constraint staz_pk primary key (stazent,staz001,stazseq1,stazseq2) enable validate;

create unique index staz_pk on staz_t (stazent,staz001,stazseq1,stazseq2);

grant select on staz_t to tiptop;
grant update on staz_t to tiptop;
grant delete on staz_t to tiptop;
grant insert on staz_t to tiptop;

exit;
