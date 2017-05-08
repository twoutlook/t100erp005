/* 
================================================================================
檔案代號:xcap_t
檔案名稱:成本差異分攤依據單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcap_t
(
xcapent       number(5)      ,/* 企業編號 */
xcapld       varchar2(5)      ,/* 帳別編號 */
xcap001       varchar2(80)      ,/* 分攤公式類型 */
xcapseq       number(10,0)      ,/* 項次 */
xcap002       varchar2(80)      ,/* 科目大類（料件大類） */
xcap003       varchar2(1)      ,/* 數據來源 */
xcap004       number(15,3)      ,/* 係數% */
xcap005       varchar2(256)      /* 運算子 */
);
alter table xcap_t add constraint xcap_pk primary key (xcapent,xcapld,xcap001,xcapseq) enable validate;

create unique index xcap_pk on xcap_t (xcapent,xcapld,xcap001,xcapseq);

grant select on xcap_t to tiptop;
grant update on xcap_t to tiptop;
grant delete on xcap_t to tiptop;
grant insert on xcap_t to tiptop;

exit;
