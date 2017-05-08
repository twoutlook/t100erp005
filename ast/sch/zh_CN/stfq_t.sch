/* 
================================================================================
檔案代號:stfq_t
檔案名稱:专柜人员合同资料档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stfq_t
(
stfqent       number(5)      ,/* 企業編號 */
stfqsite       varchar2(10)      ,/* 營運據點 */
stfqunit       varchar2(10)      ,/* 應用組織 */
stfq001       varchar2(20)      ,/* 人員合同編號 */
stfq002       varchar2(10)      ,/* 版本 */
stfq003       varchar2(10)      ,/* 專櫃編號 */
stfq004       varchar2(10)      ,/* 供應商編號 */
stfq005       number(5,0)      ,/* 定編人數 */
stfq006       number(20,6)      ,/* 應繳服務質量保證金 */
stfq007       varchar2(20)      ,/* 應繳服務保證金費用單號 */
stfq008       number(20,6)      ,/* 個人應繳促銷管理費 */
stfq009       number(20,6)      ,/* 未滿半年應扣違約金 */
stfq010       varchar2(20)      ,/* 手冊編號 */
stfq011       number(20,6)      ,/* 轉崗費用金額 */
stfq012       number(20,6)      ,/* 工牌押金 */
stfq013       varchar2(5)      ,/* 業務人員 */
stfq014       varchar2(255)      ,/* 備註 */
stfqownid       varchar2(20)      ,/* 資料所有者 */
stfqowndp       varchar2(10)      ,/* 資料所屬部門 */
stfqcrtid       varchar2(20)      ,/* 資料建立者 */
stfqcrtdp       varchar2(10)      ,/* 資料建立部門 */
stfqcrtdt       timestamp(0)      ,/* 資料創建日 */
stfqmodid       varchar2(20)      ,/* 資料修改者 */
stfqmoddt       timestamp(0)      ,/* 最近修改日 */
stfqcnfid       varchar2(20)      ,/* 資料確認者 */
stfqcnfdt       timestamp(0)      ,/* 資料確認日 */
stfqstus       varchar2(10)      /* 狀態碼 */
);
alter table stfq_t add constraint stfq_pk primary key (stfqent,stfq001) enable validate;

create unique index stfq_pk on stfq_t (stfqent,stfq001);

grant select on stfq_t to tiptop;
grant update on stfq_t to tiptop;
grant delete on stfq_t to tiptop;
grant insert on stfq_t to tiptop;

exit;
