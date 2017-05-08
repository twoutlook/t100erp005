/* 
================================================================================
檔案代號:pmeg_t
檔案名稱:採購變更單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmeg_t
(
pmegent       number(5)      ,/* 企業編號 */
pmegsite       varchar2(10)      ,/* 營運據點 */
pmegdocno       varchar2(20)      ,/* 採購變更單號 */
pmegseq       number(10,0)      ,/* 項次 */
pmeg001       varchar2(40)      ,/* 料件編號 */
pmeg002       varchar2(256)      ,/* 產品特徵 */
pmeg003       varchar2(40)      ,/* 包裝容器 */
pmeg004       varchar2(10)      ,/* 作業編號 */
pmeg005       varchar2(10)      ,/* 製程式 */
pmeg006       varchar2(10)      ,/* 採購單位 */
pmeg007       number(20,6)      ,/* 採購數量 */
pmeg008       varchar2(10)      ,/* 參考單位 */
pmeg009       number(20,6)      ,/* 參考數量 */
pmeg010       varchar2(10)      ,/* 計價單位 */
pmeg011       number(20,6)      ,/* 計價數量 */
pmeg012       date      ,/* 出貨日期 */
pmeg013       date      ,/* 到廠日期 */
pmeg014       date      ,/* 到庫日期 */
pmeg015       number(20,6)      ,/* 單價 */
pmeg016       varchar2(10)      ,/* 稅別 */
pmeg017       number(5,2)      ,/* 稅率 */
pmeg019       varchar2(10)      ,/* 子件特性 */
pmeg020       varchar2(10)      ,/* 急料 */
pmeg021       varchar2(1)      ,/* 保稅 */
pmeg022       varchar2(1)      ,/* 部分交貨 */
pmegunit       varchar2(10)      ,/* 應用組織 */
pmegorga       varchar2(10)      ,/* 付款據點 */
pmeg023       varchar2(10)      ,/* 送貨供應商 */
pmeg024       varchar2(1)      ,/* 多交期 */
pmeg025       varchar2(10)      ,/* 收貨地址代碼 */
pmeg026       varchar2(10)      ,/* 帳款地址代碼 */
pmeg027       varchar2(40)      ,/* 供應商料號 */
pmeg028       varchar2(10)      ,/* 限定庫位 */
pmeg029       varchar2(10)      ,/* 限定儲位 */
pmeg030       varchar2(30)      ,/* 限定批號 */
pmeg031       varchar2(10)      ,/* 運輸方式 */
pmeg032       varchar2(10)      ,/* 取貨模式 */
pmeg033       number(20,6)      ,/* 備品率 */
pmeg034       number(20,6)      ,/* No use */
pmeg035       varchar2(10)      ,/* 價格核決 */
pmeg036       varchar2(20)      ,/* 專案編號 */
pmeg037       varchar2(30)      ,/* WBS編號 */
pmeg038       varchar2(30)      ,/* 活動編號 */
pmeg039       varchar2(10)      ,/* 費用原因 */
pmeg040       varchar2(10)      ,/* 取價來源 */
pmeg041       varchar2(20)      ,/* 價格參考單號 */
pmeg042       number(10,0)      ,/* 價格參考項次 */
pmeg043       number(20,6)      ,/* 取出價格 */
pmeg044       number(20,6)      ,/* 價差比 */
pmeg045       varchar2(10)      ,/* 行狀態 */
pmeg046       number(20,6)      ,/* 未稅金額 */
pmeg047       number(20,6)      ,/* 含稅金額 */
pmeg048       number(20,6)      ,/* 稅額 */
pmeg049       varchar2(10)      ,/* 理由碼 */
pmeg050       varchar2(255)      ,/* 備註 */
pmeg051       varchar2(10)      ,/* 結案理由碼 */
pmeg052       varchar2(1)      ,/* 檢驗否 */
pmeg053       varchar2(30)      ,/* 庫存管理特徵 */
pmeg200       varchar2(40)      ,/* 商品條碼 */
pmeg201       varchar2(10)      ,/* 包裝單位 */
pmeg202       number(20,6)      ,/* 包裝數量 */
pmeg203       varchar2(10)      ,/* 收貨部門 */
pmeg205       varchar2(10)      ,/* 要貨組織 */
pmeg206       number(20,6)      ,/* 庫存量 */
pmeg207       number(20,6)      ,/* 採購在途量 */
pmeg208       number(20,6)      ,/* 前日銷售量 */
pmeg209       number(20,6)      ,/* 月銷量 */
pmeg210       number(20,6)      ,/* 第一週銷量 */
pmeg211       number(20,6)      ,/* 第二週銷量 */
pmeg212       number(20,6)      ,/* 第三週銷量 */
pmeg213       number(20,6)      ,/* 第四週銷量 */
pmeg214       varchar2(10)      ,/* 採購渠道 */
pmeg215       varchar2(10)      ,/* 渠道性質 */
pmeg216       varchar2(10)      ,/* 經營方式 */
pmeg217       varchar2(10)      ,/* 結算方式 */
pmeg218       varchar2(20)      ,/* 合約編號 */
pmeg219       varchar2(20)      ,/* 協議編號 */
pmeg220       varchar2(20)      ,/* 採購人員 */
pmeg900       number(10,0)      ,/* 變更序 */
pmeg901       varchar2(1)      ,/* 變更類型 */
pmeg902       varchar2(10)      ,/* 變更理由 */
pmeg903       varchar2(255)      ,/* 變更備註 */
pmegud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmegud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmegud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmegud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmegud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmegud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmegud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmegud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmegud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmegud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmegud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmegud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmegud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmegud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmegud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmegud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmegud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmegud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmegud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmegud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmegud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmegud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmegud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmegud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmegud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmegud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmegud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmegud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmegud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmegud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmeg221       varchar2(10)      ,/* 採購部門 */
pmeg222       varchar2(10)      ,/* 採購中心 */
pmeg223       varchar2(10)      ,/* 配送中心 */
pmeg224       date      ,/* 採購失效日 */
pmeg225       varchar2(10)      ,/* 最終收貨組織 */
pmeg226       number(20,6)      ,/* 長效期每次送貨量 */
pmeg227       varchar2(80)      ,/* 補貨規格說明 */
pmeg058       varchar2(10)      ,/* 預算項目 */
pmeg228       varchar2(10)      /* 商品品類 */
);
alter table pmeg_t add constraint pmeg_pk primary key (pmegent,pmegdocno,pmegseq,pmeg900) enable validate;

create unique index pmeg_pk on pmeg_t (pmegent,pmegdocno,pmegseq,pmeg900);

grant select on pmeg_t to tiptop;
grant update on pmeg_t to tiptop;
grant delete on pmeg_t to tiptop;
grant insert on pmeg_t to tiptop;

exit;
