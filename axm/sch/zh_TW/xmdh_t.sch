/* 
================================================================================
檔案代號:xmdh_t
檔案名稱:出通單單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdh_t
(
xmdhent       number(5)      ,/* 企業編號 */
xmdhsite       varchar2(10)      ,/* 營運據點 */
xmdhunit       varchar2(10)      ,/* 發貨組織 */
xmdhdocno       varchar2(20)      ,/* 單據編號 */
xmdhseq       number(10,0)      ,/* 項次 */
xmdh001       varchar2(20)      ,/* 訂單單號 */
xmdh002       number(10,0)      ,/* 訂單項次 */
xmdh003       number(10,0)      ,/* 訂單項序 */
xmdh004       number(10,0)      ,/* 訂單分批序 */
xmdh005       varchar2(10)      ,/* 子件特性 */
xmdh006       varchar2(40)      ,/* 料件編號 */
xmdh007       varchar2(256)      ,/* 產品特徵 */
xmdh008       varchar2(40)      ,/* 包裝容器 */
xmdh009       varchar2(10)      ,/* 作業編號 */
xmdh010       varchar2(10)      ,/* 製程式 */
xmdh011       varchar2(1)      ,/* 多庫儲批出貨 */
xmdh012       varchar2(10)      ,/* 限定庫位 */
xmdh013       varchar2(10)      ,/* 限定儲位 */
xmdh014       varchar2(30)      ,/* 限定批號 */
xmdh015       varchar2(10)      ,/* 出貨單位 */
xmdh016       number(20,6)      ,/* 申請出通數量 */
xmdh017       number(20,6)      ,/* 實際出通數量 */
xmdh018       varchar2(10)      ,/* 參考單位 */
xmdh019       number(20,6)      ,/* 參考數量 */
xmdh020       varchar2(10)      ,/* 計價單位 */
xmdh021       number(20,6)      ,/* 計價數量 */
xmdh022       varchar2(1)      ,/* 檢驗否 */
xmdh023       number(20,6)      ,/* 單價 */
xmdh024       varchar2(10)      ,/* 稅別 */
xmdh025       number(5,2)      ,/* 稅率 */
xmdh026       number(20,6)      ,/* 未稅金額 */
xmdh027       number(20,6)      ,/* 含稅金額 */
xmdh028       number(20,6)      ,/* 稅額 */
xmdh029       varchar2(30)      ,/* 庫存管理特徵 */
xmdh030       number(20,6)      ,/* 已轉出貨數量 */
xmdh031       varchar2(20)      ,/* 專案編號 */
xmdh032       varchar2(30)      ,/* WBS編號 */
xmdh033       varchar2(30)      ,/* 活動編號 */
xmdh034       varchar2(40)      ,/* 客戶料號 */
xmdh035       number(20,6)      ,/* QPA */
xmdh036       varchar2(1)      ,/* 保稅 */
xmdh050       varchar2(255)      ,/* 備註 */
xmdh051       varchar2(10)      ,/* 多角流程編號 */
xmdh052       varchar2(20)      ,/* 多角流程式號 */
xmdh200       varchar2(20)      ,/* 促銷方案 */
xmdh201       varchar2(40)      ,/* 商品條碼 */
xmdh202       varchar2(10)      ,/* 出貨包裝單位 */
xmdh203       number(20,6)      ,/* 申請出通包裝數量 */
xmdh204       number(20,6)      ,/* 實際出通包裝數量 */
xmdh207       number(20,6)      ,/* 標準價 */
xmdh208       number(20,6)      ,/* 促銷價 */
xmdh209       number(20,6)      ,/* 交易價 */
xmdh210       number(20,6)      ,/* 折價金額 */
xmdh211       varchar2(10)      ,/* 收貨網點 */
xmdh212       varchar2(10)      ,/* 送貨客戶 */
xmdh213       varchar2(10)      ,/* 送貨地址碼 */
xmdh214       varchar2(10)      ,/* 送貨站點 */
xmdh215       varchar2(10)      ,/* 送貨時段 */
xmdh216       varchar2(10)      ,/* 庫存鎖定等級 */
xmdh217       varchar2(10)      ,/* 銷售通路 */
xmdh218       varchar2(10)      ,/* 產品組編號 */
xmdh219       varchar2(10)      ,/* 銷售範圍編號 */
xmdh220       varchar2(10)      ,/* 交易類型 */
xmdh221       varchar2(10)      ,/* 地區編號 */
xmdh222       varchar2(10)      ,/* 縣市編號 */
xmdh223       varchar2(10)      ,/* 省區編號 */
xmdh224       varchar2(10)      ,/* 區域編號 */
xmdhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdhud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdh056       number(20,6)      /* 檢驗合格量 */
);
alter table xmdh_t add constraint xmdh_pk primary key (xmdhent,xmdhdocno,xmdhseq) enable validate;

create unique index xmdh_pk on xmdh_t (xmdhent,xmdhdocno,xmdhseq);

grant select on xmdh_t to tiptop;
grant update on xmdh_t to tiptop;
grant delete on xmdh_t to tiptop;
grant insert on xmdh_t to tiptop;

exit;
