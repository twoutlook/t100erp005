/* 
================================================================================
檔案代號:prga_t
檔案名稱:補差調整資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prga_t
(
prgaent       number(5)      ,/* 企業編號 */
prgaunit       varchar2(10)      ,/* 應用組織 */
prgasite       varchar2(10)      ,/* 營運據點 */
prgadocno       varchar2(20)      ,/* 單據編號 */
prgadocdt       date      ,/* 單據日期 */
prga001       varchar2(10)      ,/* 補差類型 */
prga002       varchar2(10)      ,/* 來源類型 */
prga003       varchar2(20)      ,/* 來源單號 */
prga004       varchar2(20)      ,/* 合約編號 */
prga005       varchar2(10)      ,/* 對象類型 */
prga006       varchar2(10)      ,/* 供應商編號/經銷商編號 */
prga007       varchar2(20)      ,/* 業務人員 */
prga008       varchar2(10)      ,/* 部門編號 */
prga009       date      ,/* 開始日期 */
prga010       date      ,/* 結束日期 */
prga011       varchar2(10)      ,/* 幣別 */
prga012       varchar2(10)      ,/* 稅別 */
prgastus       varchar2(10)      ,/* 狀態碼 */
prgaownid       varchar2(20)      ,/* 資料所有者 */
prgaowndp       varchar2(10)      ,/* 資料所屬部門 */
prgacrtid       varchar2(20)      ,/* 資料建立者 */
prgacrtdp       varchar2(10)      ,/* 資料建立部門 */
prgacrtdt       timestamp(0)      ,/* 資料創建日 */
prgamodid       varchar2(20)      ,/* 資料修改者 */
prgamoddt       timestamp(0)      ,/* 最近修改日 */
prgacnfid       varchar2(20)      ,/* 資料確認者 */
prgacnfdt       timestamp(0)      ,/* 資料確認日 */
prga013       varchar2(10)      ,/* 補差方式 */
prga014       number(20,6)      ,/* 承擔比例 */
prga015       varchar2(10)      ,/* 管理品類 */
prga016       varchar2(1)      /* 已計算補差 */
);
alter table prga_t add constraint prga_pk primary key (prgaent,prgadocno) enable validate;

create unique index prga_pk on prga_t (prgaent,prgadocno);

grant select on prga_t to tiptop;
grant update on prga_t to tiptop;
grant delete on prga_t to tiptop;
grant insert on prga_t to tiptop;

exit;
