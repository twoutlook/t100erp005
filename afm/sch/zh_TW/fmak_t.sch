/* 
================================================================================
檔案代號:fmak_t
檔案名稱:融資明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmak_t
(
fmakent       number(5)      ,/* 企業編號 */
fmak001       varchar2(10)      ,/* 融資合同編號 */
fmak002       varchar2(10)      ,/* 幣別 */
fmak003       varchar2(30)      ,/* 貸款帳戶 */
fmak004       number(20,6)      ,/* 金額 */
fmak005       varchar2(1)      ,/* 利率方式 */
fmak006       varchar2(1)      ,/* 浮動方式 */
fmak007       number(10,6)      ,/* 固定利率/浮動利率(年%) */
fmak008       number(10,6)      ,/* 逾期罰息率(年%) */
fmak009       number(10,6)      ,/* 挪用罰息率(年%) */
fmak010       varchar2(1)      ,/* 複利計算 */
fmak011       number(10,0)      /* 項次 */
);
alter table fmak_t add constraint fmak_pk primary key (fmakent,fmak001,fmak011) enable validate;

create unique index fmak_pk on fmak_t (fmakent,fmak001,fmak011);

grant select on fmak_t to tiptop;
grant update on fmak_t to tiptop;
grant delete on fmak_t to tiptop;
grant insert on fmak_t to tiptop;

exit;
