/* 
================================================================================
檔案代號:prhc_t
檔案名稱:租賃促銷折扣明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prhc_t
(
prhcent       number(5)      ,/* 企業編號 */
prhcunit       varchar2(10)      ,/* 应用组织 */
prhcsite       varchar2(10)      ,/* 营运组织 */
prhcdocno       varchar2(20)      ,/* 促銷協議編號 */
prhcseq       number(10,0)      ,/* 項次 */
prhc001       varchar2(10)      ,/* 促銷類型 */
prhc002       varchar2(20)      ,/* 促銷規則編號 */
prhc003       date      ,/* 費用日期 */
prhc004       varchar2(10)      ,/* 商戶編號 */
prhc005       varchar2(20)      ,/* 鋪位編號 */
prhc006       varchar2(20)      ,/* 合約編號 */
prhc007       number(20,6)      ,/* 贈品數量 */
prhc008       number(20,6)      ,/* 贈品金額 */
prhc009       varchar2(30)      ,/* 卡券編號 */
prhc010       number(20,6)      ,/* 折扣金額 */
prhc011       varchar2(10)      ,/* 費用編號 */
prhc012       number(20,6)      ,/* 場租倍數 */
prhc013       number(20,6)      ,/* 費用臨界值比率 */
prhc014       number(20,6)      ,/* 商戶承擔費用比例 */
prhc015       number(20,6)      ,/* 商戶承擔費用金額 */
prhc016       number(20,6)      /* 賣場承擔費用金額 */
);
alter table prhc_t add constraint prhc_pk primary key (prhcent,prhcdocno,prhcseq,prhc006) enable validate;

create unique index prhc_pk on prhc_t (prhcent,prhcdocno,prhcseq,prhc006);

grant select on prhc_t to tiptop;
grant update on prhc_t to tiptop;
grant delete on prhc_t to tiptop;
grant insert on prhc_t to tiptop;

exit;
