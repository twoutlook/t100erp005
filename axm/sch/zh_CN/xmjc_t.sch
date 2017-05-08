/* 
================================================================================
檔案代號:xmjc_t
檔案名稱:訂貨會訂貨明細原稿檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmjc_t
(
xmjcent       number(5)      ,/* 企業編號 */
xmjcsite       varchar2(10)      ,/* 營運據點 */
xmjc001       number(5,0)      ,/* 年度 */
xmjc002       varchar2(10)      ,/* 訂貨季 */
xmjc003       varchar2(10)      ,/* 對象類型 */
xmjc004       varchar2(10)      ,/* 物件編號 */
xmjc005       varchar2(500)      ,/* 物件說明 */
xmjc006       varchar2(100)      ,/* 订单单号 */
xmjc007       number(10,0)      ,/* 訂單序號 */
xmjc008       varchar2(80)      ,/* 款號 */
xmjc009       number(20,6)      ,/* 吊牌價 */
xmjc010       varchar2(30)      ,/* 顏色編號 */
xmjc011       varchar2(500)      ,/* 顏色說明 */
xmjc012       varchar2(30)      ,/* 尺寸編號 */
xmjc013       varchar2(500)      ,/* 尺寸說明 */
xmjc014       number(20,6)      ,/* 數量 */
xmjc015       number(20,6)      ,/* 金額 */
xmjc016       varchar2(10)      ,/* 轉出狀態 */
xmjcmodid       varchar2(20)      ,/*   */
xmjcmoddt       timestamp(0)      ,/*   */
xmjcownid       varchar2(20)      ,/* 資料所屬者 */
xmjcowndp       varchar2(10)      ,/* 資料所屬部門 */
xmjccrtid       varchar2(20)      ,/*   */
xmjccrtdp       varchar2(10)      ,/*   */
xmjccrtdt       timestamp(0)      ,/* 資料創建日 */
xmjcstus       varchar2(10)      ,/* 狀態碼 */
xmjcud001       varchar2(40)      ,/*   */
xmjcud002       varchar2(40)      ,/*   */
xmjcud003       varchar2(40)      ,/*   */
xmjcud004       varchar2(40)      ,/*   */
xmjcud005       varchar2(40)      ,/*   */
xmjcud006       varchar2(40)      ,/*   */
xmjcud007       varchar2(40)      ,/*   */
xmjcud008       varchar2(40)      ,/*   */
xmjcud009       varchar2(40)      ,/*   */
xmjcud010       varchar2(40)      ,/*   */
xmjcud011       number(20,6)      ,/*   */
xmjcud012       number(20,6)      ,/*   */
xmjcud013       number(20,6)      ,/*   */
xmjcud014       number(20,6)      ,/*   */
xmjcud015       number(20,6)      ,/*   */
xmjcud016       number(20,6)      ,/*   */
xmjcud017       number(20,6)      ,/*   */
xmjcud018       number(20,6)      ,/*   */
xmjcud019       number(20,6)      ,/*   */
xmjcud020       number(20,6)      ,/*   */
xmjcud021       timestamp(0)      ,/*   */
xmjcud022       timestamp(0)      ,/*   */
xmjcud023       timestamp(0)      ,/*   */
xmjcud024       timestamp(0)      ,/*   */
xmjcud025       timestamp(0)      ,/*   */
xmjcud026       timestamp(0)      ,/*   */
xmjcud027       timestamp(0)      ,/*   */
xmjcud028       timestamp(0)      ,/*   */
xmjcud029       timestamp(0)      ,/*   */
xmjcud030       timestamp(0)      ,/*   */
xmjc017       varchar2(40)      ,/* 區域 */
xmjc018       varchar2(40)      ,/* 代理 */
xmjc019       varchar2(40)      ,/* 品牌 */
xmjc020       varchar2(40)      ,/* 系列 */
xmjc021       varchar2(40)      ,/* 年齡段 */
xmjc022       varchar2(40)      ,/* 季節 */
xmjc023       varchar2(40)      ,/* 波段 */
xmjc024       varchar2(40)      ,/* 性別 */
xmjc025       varchar2(40)      ,/* 上下裝 */
xmjc026       varchar2(40)      ,/* 類別 */
xmjc027       varchar2(40)      ,/* 小類 */
xmjc028       varchar2(40)      ,/* 款式屬性 */
xmjc029       varchar2(40)      ,/* 價格帶 */
xmjc030       varchar2(40)      /* 面料 */
);
alter table xmjc_t add constraint xmjc_pk primary key (xmjcent,xmjc001,xmjc002,xmjc003,xmjc004,xmjc008,xmjc010,xmjc012) enable validate;

create unique index xmjc_pk on xmjc_t (xmjcent,xmjc001,xmjc002,xmjc003,xmjc004,xmjc008,xmjc010,xmjc012);

grant select on xmjc_t to tiptop;
grant update on xmjc_t to tiptop;
grant delete on xmjc_t to tiptop;
grant insert on xmjc_t to tiptop;

exit;
