/* 
================================================================================
檔案代號:stei_t
檔案名稱:專櫃合同优惠条件申请资料档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stei_t
(
steient       number(5)      ,/* 企業編號 */
steisite       varchar2(10)      ,/* 營運據點 */
steiunit       varchar2(10)      ,/* 應用組織 */
steidocno       varchar2(20)      ,/* 單據編號 */
steiacti       varchar2(1)      ,/* 資料有效 */
steiseq       number(10,0)      ,/* 項次 */
stei001       varchar2(20)      ,/* 合同編號 */
stei002       varchar2(10)      ,/* 優惠類型 */
stei003       varchar2(10)      ,/* 費用編碼 */
stei004       number(20,6)      ,/* 優惠金額 */
stei005       date      ,/* 優惠開始日期 */
stei006       date      ,/* 優惠結束日期 */
stei007       varchar2(20)      ,/* 優惠單號 */
stei008       number(10,0)      ,/* 優惠項次 */
stei009       varchar2(255)      ,/* 備註 */
stei010       varchar2(10)      ,/* 優惠原因 */
stei011       varchar2(20)      ,/* 費用編號 */
stei012       number(10,0)      /* 費用項次 */
);
alter table stei_t add constraint stei_pk primary key (steient,steidocno,steiseq) enable validate;

create unique index stei_pk on stei_t (steient,steidocno,steiseq);

grant select on stei_t to tiptop;
grant update on stei_t to tiptop;
grant delete on stei_t to tiptop;
grant insert on stei_t to tiptop;

exit;
