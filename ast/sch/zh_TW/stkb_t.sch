/* 
================================================================================
檔案代號:stkb_t
檔案名稱:租賃促銷折扣明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkb_t
(
stkbent       number(5)      ,/* 企业代码 */
stkbunit       varchar2(10)      ,/* 應用組織 */
stkbsite       varchar2(10)      ,/* 营运组织 */
stkbdocno       varchar2(20)      ,/* 促銷協議編號 */
stkbseq       number(10,0)      ,/* 項次 */
stkb001       varchar2(10)      ,/* 促銷類型 */
stkb002       varchar2(20)      ,/* 促銷規則編號 */
stkb003       date      ,/* 費用日期 */
stkb004       varchar2(10)      ,/* 商戶編號 */
stkb005       varchar2(20)      ,/* 鋪位編號 */
stkb006       varchar2(20)      ,/* 合約編號 */
stkb007       number(20,6)      ,/* 贈品數量 */
stkb008       number(20,6)      ,/* 贈品金額 */
stkb009       varchar2(30)      ,/* 卡券編號 */
stkb010       number(20,6)      ,/* 折扣金額 */
stkb011       varchar2(10)      ,/* 費用編號 */
stkb012       number(20,6)      ,/* 場租倍數 */
stkb013       number(20,6)      ,/* 費用臨界值比率 */
stkb014       number(20,6)      ,/* 商戶承擔費用比例 */
stkb015       number(20,6)      ,/* 商戶承擔費用金額 */
stkb016       number(20,6)      /* 賣場承擔費用金額 */
);
alter table stkb_t add constraint stkb_pk primary key (stkbent,stkbdocno,stkbseq) enable validate;

create unique index stkb_pk on stkb_t (stkbent,stkbdocno,stkbseq);

grant select on stkb_t to tiptop;
grant update on stkb_t to tiptop;
grant delete on stkb_t to tiptop;
grant insert on stkb_t to tiptop;

exit;
