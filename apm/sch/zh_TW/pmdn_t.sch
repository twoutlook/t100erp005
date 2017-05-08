/* 
================================================================================
檔案代號:pmdn_t
檔案名稱:採購單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdn_t
(
pmdnent       number(5)      ,/* 企業編號 */
pmdnsite       varchar2(10)      ,/* 營運據點 */
pmdnunit       varchar2(10)      ,/* 應用組織 */
pmdndocno       varchar2(20)      ,/* 採購單號 */
pmdnseq       number(10,0)      ,/* 項次 */
pmdn001       varchar2(40)      ,/* 料件編號 */
pmdn002       varchar2(256)      ,/* 產品特徵 */
pmdn003       varchar2(40)      ,/* 包裝容器 */
pmdn004       varchar2(10)      ,/* 作業編號 */
pmdn005       varchar2(10)      ,/* 作業序 */
pmdn006       varchar2(10)      ,/* 採購單位 */
pmdn007       number(20,6)      ,/* 採購數量 */
pmdn008       varchar2(10)      ,/* 參考單位 */
pmdn009       number(20,6)      ,/* 參考數量 */
pmdn010       varchar2(10)      ,/* 計價單位 */
pmdn011       number(20,6)      ,/* 計價數量 */
pmdn012       date      ,/* 出貨日期 */
pmdn013       date      ,/* 到廠日期 */
pmdn014       date      ,/* 到庫日期 */
pmdn015       number(20,6)      ,/* 單價 */
pmdn016       varchar2(10)      ,/* 稅別 */
pmdn017       number(5,2)      ,/* 稅率 */
pmdn019       varchar2(10)      ,/* 子件特性 */
pmdn020       varchar2(10)      ,/* 緊急度 */
pmdn021       varchar2(1)      ,/* 保稅 */
pmdn022       varchar2(1)      ,/* 部分交貨 */
pmdnorga       varchar2(10)      ,/* 付款據點 */
pmdn023       varchar2(10)      ,/* 送貨供應商 */
pmdn024       varchar2(1)      ,/* 多交期 */
pmdn025       varchar2(10)      ,/* 收貨地址編號 */
pmdn026       varchar2(10)      ,/* 帳款地址編號 */
pmdn027       varchar2(40)      ,/* 供應商料號 */
pmdn028       varchar2(10)      ,/* 收貨庫位 */
pmdn029       varchar2(10)      ,/* 收貨儲位 */
pmdn030       varchar2(30)      ,/* 收貨批號 */
pmdn031       varchar2(10)      ,/* 運輸方式 */
pmdn032       varchar2(10)      ,/* 取貨模式 */
pmdn033       number(20,6)      ,/* 備品率 */
pmdn034       number(20,6)      ,/* no use */
pmdn035       varchar2(10)      ,/* 價格核決 */
pmdn036       varchar2(20)      ,/* 專案編號 */
pmdn037       varchar2(30)      ,/* WBS編號 */
pmdn038       varchar2(30)      ,/* 活動編號 */
pmdn039       varchar2(10)      ,/* 費用原因 */
pmdn040       varchar2(10)      ,/* 取價來源 */
pmdn041       varchar2(20)      ,/* 價格參考單號 */
pmdn042       number(10,0)      ,/* 價格參考項次 */
pmdn043       number(20,6)      ,/* 取出價格 */
pmdn044       number(20,6)      ,/* 價差比 */
pmdn045       varchar2(10)      ,/* 行狀態 */
pmdn046       number(20,6)      ,/* 未稅金額 */
pmdn047       number(20,6)      ,/* 含稅金額 */
pmdn048       number(20,6)      ,/* 稅額 */
pmdn049       varchar2(10)      ,/* 理由碼 */
pmdn050       varchar2(255)      ,/* 備註 */
pmdn051       varchar2(10)      ,/* 留置/結案理由碼 */
pmdn052       varchar2(1)      ,/* 檢驗否 */
pmdn053       varchar2(30)      ,/* 庫存管理特徵 */
pmdn200       varchar2(40)      ,/* 商品條碼 */
pmdn201       varchar2(10)      ,/* 包裝單位 */
pmdn202       number(20,6)      ,/* 包裝數量 */
pmdn203       varchar2(10)      ,/* 收貨部門 */
pmdn204       varchar2(10)      ,/* No Use */
pmdn205       varchar2(10)      ,/* 要貨組織 */
pmdn206       number(20,6)      ,/* 庫存量 */
pmdn207       number(20,6)      ,/* 採購在途量 */
pmdn208       number(20,6)      ,/* 前日銷售量 */
pmdn209       number(20,6)      ,/* 上月銷量 */
pmdn210       number(20,6)      ,/* 第一週銷量 */
pmdn211       number(20,6)      ,/* 第二週銷量 */
pmdn212       number(20,6)      ,/* 第三週銷量 */
pmdn213       number(20,6)      ,/* 第四週銷量 */
pmdn214       varchar2(10)      ,/* 採購通路 */
pmdn215       varchar2(10)      ,/* 通路性質 */
pmdn216       varchar2(10)      ,/* 經營方式 */
pmdn217       varchar2(10)      ,/* 結算方式 */
pmdn218       varchar2(20)      ,/* 合約編號 */
pmdn219       varchar2(20)      ,/* 協議編號 */
pmdn220       varchar2(20)      ,/* 採購人員 */
pmdn221       varchar2(10)      ,/* 採購部門 */
pmdn222       varchar2(10)      ,/* 採購中心 */
pmdn223       varchar2(10)      ,/* 配送中心 */
pmdn224       date      ,/* 採購失效日 */
pmdn900       number(20,6)      ,/* 保留欄位str */
pmdn999       number(20,6)      ,/* 保留欄位end */
pmdnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdnud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdn225       varchar2(10)      ,/* 最終收貨組織 */
pmdn054       number(20,6)      ,/* 還料數量 */
pmdn055       number(20,6)      ,/* 還量參考數量 */
pmdn056       number(20,6)      ,/* 還價數量 */
pmdn057       number(20,6)      ,/* 還價參考數量 */
pmdn226       number(20,6)      ,/* 長效期每次送貨量 */
pmdn227       varchar2(80)      ,/* 補貨規格說明 */
pmdn058       varchar2(24)      ,/* 預算科目 */
pmdn228       varchar2(10)      /* 商品品類 */
);
alter table pmdn_t add constraint pmdn_pk primary key (pmdnent,pmdndocno,pmdnseq) enable validate;

create unique index pmdn_pk on pmdn_t (pmdnent,pmdndocno,pmdnseq);

grant select on pmdn_t to tiptop;
grant update on pmdn_t to tiptop;
grant delete on pmdn_t to tiptop;
grant insert on pmdn_t to tiptop;

exit;
