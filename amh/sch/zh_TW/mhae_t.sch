/* 
================================================================================
檔案代號:mhae_t
檔案名稱:專櫃基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhae_t
(
mhaeent       number(5)      ,/* 企業編號 */
mhaesite       varchar2(10)      ,/* 歸屬組織 */
mhaeunit       varchar2(10)      ,/* 制定組織 */
mhae001       varchar2(10)      ,/* 專櫃編號 */
mhae002       varchar2(10)      ,/* 專櫃類型 */
mhae003       varchar2(10)      ,/* 經營方式 */
mhae004       varchar2(10)      ,/* 所屬部門 */
mhae005       varchar2(10)      ,/* 收入方式 */
mhae006       varchar2(10)      ,/* 供應商編號 */
mhae007       varchar2(10)      ,/* 進項稅稅別 */
mhae008       varchar2(10)      ,/* 銷項稅稅別 */
mhae009       varchar2(10)      ,/* 品牌編號 */
mhae010       varchar2(10)      ,/* 經營小類 */
mhae011       varchar2(10)      ,/* 經營中類 */
mhae012       varchar2(10)      ,/* 經營大類 */
mhae013       varchar2(24)      ,/* 科目類型 */
mhae014       varchar2(10)      ,/* 管理方式 */
mhae015       varchar2(10)      ,/* 業態 */
mhae016       varchar2(1)      ,/* 換購否 */
mhae017       varchar2(20)      ,/* 電話號碼 */
mhae018       varchar2(20)      ,/* 專櫃負責人 */
mhae019       varchar2(255)      ,/* 備註 */
mhae020       varchar2(10)      ,/* 樓棟 */
mhae021       varchar2(10)      ,/* 樓層 */
mhaeownid       varchar2(20)      ,/* 資料所屬者 */
mhaeowndp       varchar2(10)      ,/* 資料所有部門 */
mhaecrtid       varchar2(20)      ,/* 資料建立者 */
mhaecrtdp       varchar2(10)      ,/* 資料建立部門 */
mhaecrtdt       timestamp(0)      ,/* 資料創建日 */
mhaemodid       varchar2(20)      ,/* 資料修改者 */
mhaemoddt       timestamp(0)      ,/* 最近修改日 */
mhaestus       varchar2(10)      ,/* 狀態碼 */
mhae022       number(20,6)      ,/* 最低折扣率 */
mhae023       varchar2(20)      ,/* 合同編號 */
mhae024       number(15,3)      ,/* 建築面積 */
mhae025       number(15,3)      ,/* 經營面積 */
mhae026       varchar2(40)      ,/* 文檔編號 */
mhae027       varchar2(10)      ,/* 簽訂法人 */
mhae028       varchar2(20)      ,/* 簽訂人員 */
mhae029       varchar2(1)      ,/* 定價屬性 */
mhae030       varchar2(10)      ,/* 幣別 */
mhae031       varchar2(10)      ,/* 收付款方式 */
mhae032       varchar2(10)      ,/* 結算方式 */
mhae033       varchar2(10)      ,/* 結算類型 */
mhae034       varchar2(10)      ,/* 結算中心 */
mhae035       varchar2(1)      ,/* 代扣代繳否 */
mhae036       varchar2(10)      ,/* 管理品類 */
mhae037       varchar2(1)      ,/* 促銷庫區參與保底否 */
mhae038       varchar2(1)      ,/* 收銀方式 */
mhae039       varchar2(1)      /* 庫區商品化否 */
);
alter table mhae_t add constraint mhae_pk primary key (mhaeent,mhaesite,mhae001,mhae020,mhae021) enable validate;

create unique index mhae_pk on mhae_t (mhaeent,mhaesite,mhae001,mhae020,mhae021);

grant select on mhae_t to tiptop;
grant update on mhae_t to tiptop;
grant delete on mhae_t to tiptop;
grant insert on mhae_t to tiptop;

exit;
