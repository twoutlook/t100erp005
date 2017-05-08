/* 
================================================================================
檔案代號:fabq_t
檔案名稱:資產抵押/解除單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabq_t
(
fabqent       number(5)      ,/* 企業編碼 */
fabqsite       varchar2(10)      ,/* 營運據點 */
fabqdocno       varchar2(20)      ,/* 異動單號 */
fabqseq       number(10,0)      ,/* 項次 */
fabq001       varchar2(10)      ,/* 抵押銀行 */
fabq002       varchar2(10)      ,/* 抵押文號 */
fabq003       date      ,/* 抵押日期 */
fabq004       date      ,/* 償還日期 */
fabq005       varchar2(20)      ,/* 財產編號 */
fabq006       varchar2(20)      ,/* 附號 */
fabq007       varchar2(10)      ,/* 卡片編號 */
fabq008       varchar2(40)      ,/* 規格 */
fabq009       number(20,6)      ,/* 數量 */
fabq010       number(20,6)      ,/* 成本 */
fabq011       number(20,6)      ,/* 帳面金額 */
fabq012       varchar2(10)      ,/* 抵押幣別 */
fabq013       number(20,10)      ,/* 匯率 */
fabq014       number(20,6)      ,/* 抵押原幣金額/解除金額 */
fabq015       number(20,6)      ,/* 抵押本幣抵押/解除金額 */
fabq016       number(20,6)      ,/* 鑑價 */
fabq017       varchar2(10)      ,/* 異動原因 */
fabq018       number(10)      ,/* 狀態 */
fabq019       date      ,/* 清償日期 */
fabq020       date      ,/* 鑑價日期 */
fabq021       varchar2(20)      ,/* 抵押單號 */
fabq022       number(10,0)      ,/* 抵押項次 */
fabq101       varchar2(10)      ,/* 本幣位二幣別 */
fabq102       number(20,10)      ,/* 本位幣二匯率 */
fabq103       number(20,6)      ,/* 本位幣二成本 */
fabq104       number(20,6)      ,/* 本位幣二帳面金額 */
fabq105       number(20,6)      ,/* 本位幣二抵押金額/解除 */
fabq111       varchar2(10)      ,/* 本位幣三幣別 */
fabq112       number(20,10)      ,/* 本位幣三匯率 */
fabq113       number(20,6)      ,/* 本位幣三成本 */
fabq114       number(20,6)      ,/* 本位幣三帳面金額 */
fabq115       number(20,6)      /* 本位幣三抵押金額/解除 */
);
alter table fabq_t add constraint fabq_pk primary key (fabqent,fabqdocno,fabqseq) enable validate;

create unique index fabq_pk on fabq_t (fabqent,fabqdocno,fabqseq);

grant select on fabq_t to tiptop;
grant update on fabq_t to tiptop;
grant delete on fabq_t to tiptop;
grant insert on fabq_t to tiptop;

exit;
