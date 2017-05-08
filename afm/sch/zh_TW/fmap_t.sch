/* 
================================================================================
檔案代號:fmap_t
檔案名稱:融資擔保明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmap_t
(
fmapent       number(5)      ,/*   */
fmap001       varchar2(10)      ,/* 融資合同編號 */
fmap002       varchar2(10)      ,/* 合約編號 */
fmap003       number(10,0)      ,/* 項次 */
fmap004       varchar2(10)      ,/* 抵押人/質押人 */
fmap005       varchar2(1)      ,/* 抵押物/質押物 */
fmap006       varchar2(40)      ,/* 料號 */
fmap007       varchar2(20)      ,/* 財產編號 */
fmap008       varchar2(20)      ,/* 附號 */
fmap009       varchar2(10)      ,/* 單位 */
fmap010       varchar2(20)      ,/* 權利證書編號（始） */
fmap011       varchar2(20)      ,/* 權利證書編號（止） */
fmap012       number(20,6)      ,/* 數量 */
fmap013       number(20,6)      ,/* 帳面價值 */
fmap014       number(20,6)      ,/* 合同公允價值 */
fmap015       varchar2(1)      ,/* 狀態 */
fmap016       varchar2(20)      ,/* 庫存留置單號 */
fmap017       varchar2(20)      /* 庫存解除留置單號 */
);
alter table fmap_t add constraint fmap_pk primary key (fmapent,fmap001,fmap002,fmap003) enable validate;

create unique index fmap_pk on fmap_t (fmapent,fmap001,fmap002,fmap003);

grant select on fmap_t to tiptop;
grant update on fmap_t to tiptop;
grant delete on fmap_t to tiptop;
grant insert on fmap_t to tiptop;

exit;
