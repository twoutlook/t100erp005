/* 
================================================================================
檔案代號:prhb_t
檔案名稱:促銷協議明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prhb_t
(
prhbdocno       varchar2(20)      ,/* 單號 */
prhbseq       number(10,0)      ,/* 項次 */
prhb001       varchar2(1)      ,/* 促銷類型 */
prhb002       varchar2(20)      ,/* 規則編號 */
prhb003       date      ,/* 促銷開始日期 */
prhb004       date      ,/* 促銷結束日期 */
prhb005       varchar2(10)      ,/* 商戶承擔費用編碼 */
prhb006       number(20,6)      ,/* 費用臨界值比率 */
prhb007       number(22,2)      ,/* 場租倍數 */
prhb008       varchar2(1)      ,/* 商戶承擔方式 */
prhb009       number(20,6)      ,/* 商戶承擔比例/金額 */
prhb010       varchar2(255)      ,/* 備註 */
prhbent       number(5)      ,/* 企業編號 */
prhbsite       varchar2(10)      ,/* 營運據點 */
prhbunit       varchar2(10)      ,/* 應用組織 */
prhbownid       varchar2(20)      ,/* 資料所屬者 */
prhbowndp       varchar2(10)      ,/* 資料所屬部門 */
prhbcrtid       varchar2(20)      ,/*   */
prhbcrtdp       varchar2(10)      ,/*   */
prhbcrtdt       timestamp(0)      ,/* 資料創建日 */
prhbmodid       varchar2(20)      ,/*   */
prhbmoddt       timestamp(0)      ,/*   */
prhbcnfid       varchar2(20)      ,/*   */
prhbcnfdt       timestamp(0)      ,/*   */
prhbpstid       varchar2(20)      ,/* 資料過帳者 */
prhbpstdt       timestamp(0)      ,/* 資料過帳日 */
prhbstus       varchar2(10)      /* 狀態碼 */
);
alter table prhb_t add constraint prhb_pk primary key (prhbdocno,prhbseq,prhbent) enable validate;

create unique index prhb_pk on prhb_t (prhbdocno,prhbseq,prhbent);

grant select on prhb_t to tiptop;
grant update on prhb_t to tiptop;
grant delete on prhb_t to tiptop;
grant insert on prhb_t to tiptop;

exit;
