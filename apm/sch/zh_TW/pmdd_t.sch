/* 
================================================================================
檔案代號:pmdd_t
檔案名稱:請購變更單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdd_t
(
pmddent       number(5)      ,/* 企業編號 */
pmddsite       varchar2(10)      ,/* 營運據點 */
pmdddocno       varchar2(20)      ,/* 請購單號 */
pmddseq       number(10,0)      ,/* 請購項次 */
pmdd001       varchar2(20)      ,/* 來源單號 */
pmdd002       number(10,0)      ,/* 來源項次 */
pmdd003       number(10,0)      ,/* 來源項序 */
pmdd004       varchar2(40)      ,/* 料件編號 */
pmdd005       varchar2(256)      ,/* 產品特徵 */
pmdd006       number(20,6)      ,/* 需求數量 */
pmdd007       varchar2(10)      ,/* 單位 */
pmdd008       number(20,6)      ,/* 參考數量 */
pmdd009       varchar2(10)      ,/* 參考單位 */
pmdd010       number(20,6)      ,/* 計價數量 */
pmdd011       varchar2(10)      ,/* 計價單位 */
pmdd012       varchar2(40)      ,/* 包裝容器 */
pmdd014       varchar2(10)      ,/* 供應商選擇方式 */
pmdd015       varchar2(10)      ,/* 供應商編號 */
pmdd016       varchar2(10)      ,/* 付款條件 */
pmdd017       varchar2(10)      ,/* 交易條件 */
pmdd018       number(5,2)      ,/* 稅率 */
pmdd019       number(20,6)      ,/* 參考單價 */
pmdd020       number(20,6)      ,/* 參考未稅金額 */
pmdd021       number(20,6)      ,/* 參考含稅金額 */
pmdd030       date      ,/* 需求日期 */
pmdd031       varchar2(10)      ,/* 理由碼 */
pmdd032       varchar2(1)      ,/* 單身結案否 */
pmdd033       varchar2(10)      ,/* 緊急度 */
pmdd034       varchar2(20)      ,/* 專案編號 */
pmdd035       varchar2(30)      ,/* WBS */
pmdd036       varchar2(30)      ,/* 活動編號 */
pmdd037       varchar2(10)      ,/* 收貨據點 */
pmdd038       varchar2(10)      ,/* 收貨庫位 */
pmdd039       varchar2(10)      ,/* 收貨儲位 */
pmdd040       number(20,6)      ,/* no use */
pmdd041       varchar2(1)      ,/* 允許部份交貨 */
pmdd042       varchar2(1)      ,/* 允許提前交貨 */
pmdd043       varchar2(1)      ,/* 保稅 */
pmdd044       varchar2(1)      ,/* 納入MRP */
pmdd045       varchar2(1)      ,/* 交期凍結否 */
pmdd046       varchar2(10)      ,/* 費用部門 */
pmdd048       varchar2(10)      ,/* 收貨時段 */
pmdd049       number(20,6)      ,/* 已轉採購量 */
pmdd200       varchar2(40)      ,/* 商品條碼 */
pmdd201       varchar2(10)      ,/* 包裝單位 */
pmdd202       number(20,6)      ,/* 整包裝數 */
pmdd203       varchar2(10)      ,/* 配送中心 */
pmdd204       varchar2(10)      ,/* 配送倉庫 */
pmdd205       varchar2(10)      ,/* 採購中心 */
pmdd206       varchar2(20)      ,/* 採購員 */
pmdd207       varchar2(10)      ,/* 採購方式 */
pmdd208       varchar2(10)      ,/* 經營方式 */
pmdd209       varchar2(10)      ,/* 結算方式 */
pmdd210       date      ,/* 促銷開始日 */
pmdd211       date      ,/* 促銷結束日 */
pmdd212       number(20,6)      ,/* 要貨件數 */
pmdd250       number(20,6)      ,/* 合理庫存 */
pmdd251       number(20,6)      ,/* 最高庫存 */
pmdd252       number(20,6)      ,/* 現有庫存 */
pmdd253       number(20,6)      ,/* 入庫在途量 */
pmdd254       number(20,6)      ,/* 前一週銷量 */
pmdd255       number(20,6)      ,/* 前二週銷量 */
pmdd256       number(20,6)      ,/* 前三週銷量 */
pmdd257       number(20,6)      ,/* 前四週銷量 */
pmdd258       number(20,6)      ,/* 要貨在途量 */
pmdd259       number(20,6)      ,/* 週平均銷量 */
pmdd900       number(10,0)      ,/* 變更序 */
pmdd901       varchar2(10)      ,/* 變更類型 */
pmdd902       varchar2(10)      ,/* 變更理由 */
pmdd903       varchar2(255)      ,/* 變更備註 */
pmdd050       varchar2(255)      ,/* 備註 */
pmddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmddud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdd260       varchar2(10)      ,/* 收貨部門 */
pmdd227       varchar2(80)      ,/* 補貨規格說明 */
pmdd053       varchar2(10)      /* 預算細項 */
);
alter table pmdd_t add constraint pmdd_pk primary key (pmddent,pmdddocno,pmddseq,pmdd900) enable validate;

create unique index pmdd_pk on pmdd_t (pmddent,pmdddocno,pmddseq,pmdd900);

grant select on pmdd_t to tiptop;
grant update on pmdd_t to tiptop;
grant delete on pmdd_t to tiptop;
grant insert on pmdd_t to tiptop;

exit;
