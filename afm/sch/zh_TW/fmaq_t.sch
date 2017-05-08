/* 
================================================================================
檔案代號:fmaq_t
檔案名稱:債券明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table fmaq_t
(
fmaqent       number(5)      ,/*   */
fmaq001       varchar2(10)      ,/* 融資合同編號 */
fmaq002       varchar2(10)      ,/* 債券編號 */
fmaq003       varchar2(10)      ,/* 發行幣別 */
fmaq004       number(20,6)      ,/* 債券面值 */
fmaq005       number(10,6)      ,/* 票面利率 */
fmaq006       varchar2(20)      ,/* 債券編號起 */
fmaq007       varchar2(20)      ,/* 債券編號止 */
fmaq008       number(20,6)      ,/* 發行數量 */
fmaq009       number(20,6)      ,/* 債券本金總額 */
fmaq010       number(20,6)      /* 發行價格 */
);
alter table fmaq_t add constraint fmaq_pk primary key (fmaqent,fmaq001,fmaq002) enable validate;

create unique index fmaq_pk on fmaq_t (fmaqent,fmaq001,fmaq002);

grant select on fmaq_t to tiptop;
grant update on fmaq_t to tiptop;
grant delete on fmaq_t to tiptop;
grant insert on fmaq_t to tiptop;

exit;
