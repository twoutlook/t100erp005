/* 
================================================================================
檔案代號:xmeh_t
檔案名稱:訂單變更交期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmeh_t
(
xmehent       number(5)      ,/* 企業編號 */
xmehsite       varchar2(10)      ,/* 營運據點 */
xmehdocno       varchar2(20)      ,/* 訂單單號 */
xmehseq       number(10,0)      ,/* 訂單項次 */
xmehseq1       number(10,0)      ,/* 項序 */
xmehseq2       number(10,0)      ,/* 分批序 */
xmeh001       varchar2(40)      ,/* 料件編號 */
xmeh002       varchar2(256)      ,/* 產品特徵 */
xmeh003       varchar2(10)      ,/* 子件特性 */
xmeh004       varchar2(10)      ,/* 銷售單位 */
xmeh005       number(20,6)      ,/* 訂購總數量 */
xmeh006       number(20,6)      ,/* 分批訂購數量 */
xmeh007       number(20,6)      ,/* 折合主件數量 */
xmeh008       number(20,6)      ,/* QPA */
xmeh009       varchar2(10)      ,/* 交期類型 */
xmeh010       varchar2(10)      ,/* 出貨時段 */
xmeh011       date      ,/* 約定交貨日期 */
xmeh012       date      ,/* 預計簽收日期 */
xmeh013       varchar2(1)      ,/* MRP交期凍結 */
xmeh014       number(20,6)      ,/* 已出貨量 */
xmeh015       number(20,6)      ,/* 已銷退量 */
xmeh016       number(20,6)      ,/* 銷退換貨數量 */
xmeh017       varchar2(10)      ,/* 出貨狀態 */
xmeh018       number(20,6)      ,/* 參考價格 */
xmeh019       varchar2(10)      ,/* 稅別 */
xmeh020       number(5,2)      ,/* 稅率 */
xmeh021       varchar2(20)      ,/* 電子訂購單號 */
xmeh022       varchar2(20)      ,/* 最近修改人員 */
xmeh023       date      ,/* 最近修改時間 */
xmeh024       varchar2(10)      ,/* 分批參考單位 */
xmeh025       number(20,6)      ,/* 分批參考數量 */
xmeh026       varchar2(10)      ,/* 分批計價單位 */
xmeh027       number(20,6)      ,/* 分批計價數量 */
xmeh028       number(20,6)      ,/* 分批未稅金額 */
xmeh029       number(20,6)      ,/* 分批含稅金額 */
xmeh030       number(20,6)      ,/* 分批稅額 */
xmeh031       number(20,6)      ,/* 已轉出通數量 */
xmeh900       number(10,0)      ,/* 變更序 */
xmeh901       varchar2(1)      ,/* 變更類型 */
xmeh200       varchar2(20)      ,/* 促銷方案 */
xmeh201       varchar2(10)      ,/* 分批包裝單位 */
xmeh202       number(20,6)      ,/* 分批包裝數量 */
xmeh203       number(20,6)      ,/* 標準價 */
xmeh204       number(20,6)      ,/* 促銷價 */
xmeh205       number(20,6)      ,/* 交易價 */
xmeh206       number(20,6)      ,/* 折價金額 */
xmehunit       varchar2(10)      ,/* 應用組織 */
xmeh207       varchar2(10)      ,/* 收貨網點 */
xmeh208       varchar2(10)      ,/* 送貨地址碼 */
xmeh209       varchar2(10)      ,/* 送貨站點 */
xmeh210       varchar2(10)      ,/* 送貨時段 */
xmeh211       varchar2(10)      ,/* 送貨客戶 */
xmeh212       varchar2(10)      ,/* MRP凍結 */
xmeh213       varchar2(10)      ,/* 庫位/庫區 */
xmeh214       varchar2(10)      ,/* 儲位 */
xmeh215       varchar2(30)      ,/* 批號 */
xmeh216       varchar2(10)      ,/* 庫存鎖定等級 */
xmeh217       number(20,6)      ,/* 庫存餘額 */
xmeh218       varchar2(10)      ,/* 銷售渠道 */
xmeh219       varchar2(10)      ,/* 產品組編號 */
xmeh220       varchar2(10)      ,/* 銷售範圍編號 */
xmeh221       varchar2(255)      ,/* 備註 */
xmeh222       varchar2(10)      ,/* 辦事處 */
xmeh223       varchar2(20)      ,/* 業務人員 */
xmeh224       varchar2(10)      ,/* 業務部門 */
xmeh225       varchar2(20)      ,/* 主合約編號 */
xmeh226       varchar2(10)      ,/* 經營方式 */
xmeh227       varchar2(10)      ,/* 結算類型 */
xmeh228       varchar2(10)      ,/* 結算方式 */
xmehorga       varchar2(10)      ,/* 帳務組織 */
xmeh229       varchar2(10)      ,/* 交易類型 */
xmehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmehud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmeh_t add constraint xmeh_pk primary key (xmehent,xmehdocno,xmehseq,xmehseq1,xmehseq2,xmeh900) enable validate;

create unique index xmeh_pk on xmeh_t (xmehent,xmehdocno,xmehseq,xmehseq1,xmehseq2,xmeh900);

grant select on xmeh_t to tiptop;
grant update on xmeh_t to tiptop;
grant delete on xmeh_t to tiptop;
grant insert on xmeh_t to tiptop;

exit;
