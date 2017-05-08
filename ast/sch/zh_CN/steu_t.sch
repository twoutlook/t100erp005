/* 
================================================================================
檔案代號:steu_t
檔案名稱:專櫃交款彙總單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table steu_t
(
steuent       number(5)      ,/* 企業編號 */
steuunit       varchar2(10)      ,/* 應用組織 */
steusite       varchar2(10)      ,/* 所屬組織 */
steudocno       varchar2(20)      ,/* 單據編號 */
steudocnt       date      ,/* 單據日期 */
steustus       varchar2(10)      ,/* 狀態碼 */
steu001       varchar2(20)      ,/* 合同編號 */
steu002       varchar2(10)      ,/* 專櫃編號 */
steu003       varchar2(10)      ,/* 供應商編號 */
steu004       varchar2(10)      ,/* 經營方式 */
steu005       number(5,0)      ,/* 結算帳期 */
steu006       date      ,/* 起始日期 */
steu007       date      ,/* 截止日期 */
steu008       varchar2(10)      ,/* 交款情況 */
steu009       number(20,6)      ,/* 單據金額合計 */
steu010       varchar2(1)      ,/* 貨款扣費用否 */
steu011       varchar2(20)      ,/* 結算單號 */
steu012       varchar2(255)      ,/* 備註 */
steuownid       varchar2(20)      ,/* 資料所有者 */
steuowndp       varchar2(10)      ,/* 資料所有部門 */
steucrtid       varchar2(20)      ,/* 資料建立者 */
steucrtdp       varchar2(10)      ,/* 資料建立部門 */
steucrtdt       timestamp(0)      ,/* 資料創建日 */
steumodid       varchar2(20)      ,/* 資料修改者 */
steumoddt       timestamp(0)      ,/* 最近修改日 */
steucnfid       varchar2(20)      ,/* 資料確認者 */
steucnfdt       timestamp(0)      ,/* 資料確認日 */
steupstid       varchar2(20)      ,/* 資料過帳者 */
steupstdt       timestamp(0)      ,/* 資料過賬日 */
steu000       varchar2(1)      /* 交款彙總單類型 */
);
alter table steu_t add constraint steu_pk primary key (steuent,steudocno) enable validate;

create unique index steu_pk on steu_t (steuent,steudocno);

grant select on steu_t to tiptop;
grant update on steu_t to tiptop;
grant delete on steu_t to tiptop;
grant insert on steu_t to tiptop;

exit;
