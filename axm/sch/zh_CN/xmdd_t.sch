/* 
================================================================================
檔案代號:xmdd_t
檔案名稱:訂單交期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdd_t
(
xmddent       number(5)      ,/* 企業編號 */
xmddsite       varchar2(10)      ,/* 營運據點 */
xmdddocno       varchar2(20)      ,/* 訂單單號 */
xmddseq       number(10,0)      ,/* 項次 */
xmddseq1       number(10,0)      ,/* 項序 */
xmddseq2       number(10,0)      ,/* 分批序 */
xmdd001       varchar2(40)      ,/* 料件編號 */
xmdd002       varchar2(256)      ,/* 產品特徵 */
xmdd003       varchar2(10)      ,/* 子件特性 */
xmdd004       varchar2(10)      ,/* 銷售單位 */
xmdd005       number(20,6)      ,/* 訂購總數量 */
xmdd006       number(20,6)      ,/* 分批訂購數量 */
xmdd007       number(20,6)      ,/* 摺合主件數量 */
xmdd008       number(20,6)      ,/* QPA */
xmdd009       varchar2(10)      ,/* 交期類型 */
xmdd010       varchar2(10)      ,/* 出貨時段 */
xmdd011       date      ,/* 約定交貨日期 */
xmdd012       date      ,/* 預計簽收日期 */
xmdd013       varchar2(1)      ,/* MRP交期凍結 */
xmdd014       number(20,6)      ,/* 已出貨量 */
xmdd015       number(20,6)      ,/* 已銷退量 */
xmdd016       number(20,6)      ,/* 銷退換貨數量 */
xmdd017       varchar2(10)      ,/* 出貨狀態 */
xmdd018       number(20,6)      ,/* 參考價格 */
xmdd019       varchar2(10)      ,/* 稅別 */
xmdd020       number(5,2)      ,/* 稅率 */
xmdd021       varchar2(20)      ,/* 電子訂購單號 */
xmdd022       varchar2(20)      ,/* 最近修改人員 */
xmdd023       date      ,/* 最近修改時間 */
xmdd024       varchar2(10)      ,/* 分批參考單位 */
xmdd025       number(20,6)      ,/* 分批參考數量 */
xmdd026       varchar2(10)      ,/* 分批計價單位 */
xmdd027       number(20,6)      ,/* 分批計價數量 */
xmdd028       number(20,6)      ,/* 分批未稅金額 */
xmdd029       number(20,6)      ,/* 分批含稅金額 */
xmdd030       number(20,6)      ,/* 分批稅額 */
xmdd031       number(20,6)      ,/* 已轉出通數量 */
xmdd032       number(20,6)      ,/* 備置量 */
xmdd033       varchar2(10)      ,/* 備置原因 */
xmdd034       number(20,6)      ,/* 已簽退量 */
xmdd035       number(20,6)      ,/* 已分配量 */
xmdd200       varchar2(20)      ,/* 促銷方案 */
xmdd201       varchar2(10)      ,/* 分批包裝單位 */
xmdd202       number(20,6)      ,/* 分批包裝數量 */
xmdd203       number(20,6)      ,/* 標準價 */
xmdd204       number(20,6)      ,/* 促銷價 */
xmdd205       number(20,6)      ,/* 交易價 */
xmdd206       number(20,6)      ,/* 折價金額 */
xmddunit       varchar2(10)      ,/* 應用組織 */
xmdd207       varchar2(10)      ,/* 收貨網點 */
xmdd208       varchar2(10)      ,/* 送貨地址碼 */
xmdd209       varchar2(10)      ,/* 送貨站點 */
xmdd210       varchar2(10)      ,/* 送貨時段 */
xmdd211       varchar2(10)      ,/* 送貨客戶 */
xmdd212       varchar2(10)      ,/* MRP凍結 */
xmdd213       varchar2(10)      ,/* 庫位/庫區 */
xmdd214       varchar2(10)      ,/* 儲位 */
xmdd215       varchar2(30)      ,/* 批號 */
xmdd216       varchar2(10)      ,/* 庫存鎖定等級 */
xmdd217       number(20,6)      ,/* 庫存餘額 */
xmdd218       varchar2(10)      ,/* 銷售渠道 */
xmdd219       varchar2(10)      ,/* 產品組編號 */
xmdd220       varchar2(10)      ,/* 銷售範圍編號 */
xmdd221       varchar2(255)      ,/* 備註 */
xmdd222       varchar2(10)      ,/* 辦事處 */
xmdd223       varchar2(20)      ,/* 業務人員 */
xmdd224       varchar2(10)      ,/* 業務部門 */
xmdd225       varchar2(20)      ,/* 主合約編號 */
xmdd226       varchar2(10)      ,/* 經營方式 */
xmdd227       varchar2(10)      ,/* 結算類型 */
xmdd228       varchar2(10)      ,/* 結算方式 */
xmddorga       varchar2(10)      ,/* 帳務組織 */
xmdd229       varchar2(10)      ,/* 交易類型 */
xmdd230       number(20,6)      ,/* 分批包裝銷退換貨數量 */
xmddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmddud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdd036       number(20,6)      ,/* 還量數量 */
xmdd037       number(20,6)      ,/* 還量參考數量 */
xmdd038       number(20,6)      ,/* 還價數量 */
xmdd039       number(20,6)      ,/* 還價參考數量 */
xmdd231       varchar2(30)      ,/* 庫存管理特徵 */
xmdd040       varchar2(30)      /* BOM特性 */
);
alter table xmdd_t add constraint xmdd_pk primary key (xmddent,xmdddocno,xmddseq,xmddseq1,xmddseq2) enable validate;

create unique index xmdd_pk on xmdd_t (xmddent,xmdddocno,xmddseq,xmddseq1,xmddseq2);

grant select on xmdd_t to tiptop;
grant update on xmdd_t to tiptop;
grant delete on xmdd_t to tiptop;
grant insert on xmdd_t to tiptop;

exit;
