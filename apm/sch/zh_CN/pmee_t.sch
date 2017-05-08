/* 
================================================================================
檔案代號:pmee_t
檔案名稱:採購變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmee_t
(
pmeeent       number(5)      ,/* 企業編號 */
pmeesite       varchar2(10)      ,/* 營運據點 */
pmeedocno       varchar2(20)      ,/* 採購變更單號 */
pmeedocdt       date      ,/* 採購變更日期 */
pmee001       number(5,0)      ,/* 版次 */
pmee002       varchar2(20)      ,/* 採購人員 */
pmee003       varchar2(10)      ,/* 採購部門 */
pmee004       varchar2(10)      ,/* 供應商編號 */
pmee005       varchar2(10)      ,/* 採購性質 */
pmee006       varchar2(10)      ,/* 多角性質 */
pmee007       varchar2(10)      ,/* 資料來源 */
pmee008       varchar2(20)      ,/* 來源單號 */
pmee009       varchar2(10)      ,/* 付款條件 */
pmee010       varchar2(10)      ,/* 交易條件 */
pmee011       varchar2(10)      ,/* 稅別 */
pmee012       number(5,2)      ,/* 稅率 */
pmee013       varchar2(1)      ,/* 單價含稅否 */
pmee015       varchar2(10)      ,/* 幣別 */
pmee016       number(20,10)      ,/* 匯率 */
pmee017       varchar2(10)      ,/* 取價方式 */
pmee018       varchar2(10)      ,/* 付款優惠條件 */
pmee019       varchar2(1)      ,/* 納入 MPS/MRP計算 */
pmee020       varchar2(10)      ,/* 運送方式 */
pmee021       varchar2(10)      ,/* 付款供應商 */
pmee022       varchar2(10)      ,/* 送貨供應商 */
pmee023       varchar2(10)      ,/* 採購分類一 */
pmee024       varchar2(10)      ,/* 採購分類二 */
pmee025       varchar2(10)      ,/* 送貨地址 */
pmee026       varchar2(10)      ,/* 帳款地址 */
pmee027       varchar2(20)      ,/* 供應商連絡人 */
pmee028       varchar2(20)      ,/* 一次性交易對象識別碼 */
pmee029       varchar2(10)      ,/* 收貨部門 */
pmee030       varchar2(1)      ,/* 多角貿易已拋轉 */
pmee031       varchar2(20)      ,/* 多角來源單號 */
pmee032       varchar2(10)      ,/* 最終客戶 */
pmee033       varchar2(2)      ,/* 發票類型 */
pmee040       number(20,6)      ,/* 採購總未稅金額 */
pmee041       number(20,6)      ,/* 採購總含稅金額 */
pmee042       number(20,6)      ,/* 採購總稅額 */
pmee043       varchar2(10)      ,/* 留置原因 */
pmee044       varchar2(255)      ,/* 備註 */
pmee046       varchar2(10)      ,/* 預付款發票開立方式 */
pmee047       varchar2(1)      ,/* 物流結案 */
pmee048       varchar2(1)      ,/* 帳流結案 */
pmee049       varchar2(1)      ,/* 金流結案 */
pmee050       varchar2(1)      ,/* 多角最終站否 */
pmee051       varchar2(10)      ,/* 多角流程代碼 */
pmee052       varchar2(10)      ,/* 最終供應商 */
pmee053       varchar2(10)      ,/* 兩角目的據點 */
pmee054       varchar2(10)      ,/* 內外購 */
pmee055       varchar2(10)      ,/* 匯率計算基準 */
pmee200       varchar2(10)      ,/* 採購中心 */
pmee201       varchar2(20)      ,/* 聯絡電話 */
pmee202       varchar2(20)      ,/* 傳真號碼 */
pmee900       number(10,0)      ,/* 變更序 */
pmee901       varchar2(1)      ,/* 變更類型 */
pmee902       date      ,/* 變更日期 */
pmee903       varchar2(10)      ,/* 變更理由 */
pmee904       varchar2(255)      ,/* 變更備註 */
pmeeunit       varchar2(10)      ,/* 應用組織 */
pmeeownid       varchar2(20)      ,/* 資料所有者 */
pmeeowndp       varchar2(10)      ,/* 資料所屬部門 */
pmeecrtid       varchar2(20)      ,/* 資料建立者 */
pmeecrtdp       varchar2(10)      ,/* 資料建立部門 */
pmeecrtdt       timestamp(0)      ,/* 資料創建日 */
pmeemodid       varchar2(20)      ,/* 資料修改者 */
pmeemoddt       timestamp(0)      ,/* 最近修改日 */
pmeecnfid       varchar2(20)      ,/* 資料確認者 */
pmeecnfdt       timestamp(0)      ,/* 資料確認日 */
pmeestus       varchar2(10)      ,/* 狀態碼 */
pmeeacti       varchar2(1)      ,/* 採購單結案否 */
pmeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmeeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmee203       varchar2(10)      ,/* 採購方式 */
pmee204       varchar2(10)      ,/* 配送中心 */
pmee205       date      ,/* 採購失效日 */
pmee206       varchar2(1)      ,/* 長效期訂單否 */
pmee207       varchar2(10)      ,/* 所屬品類 */
pmee208       varchar2(20)      /* 電子採購單號 */
);
alter table pmee_t add constraint pmee_pk primary key (pmeeent,pmeedocno,pmee900) enable validate;

create unique index pmee_pk on pmee_t (pmeeent,pmeedocno,pmee900);

grant select on pmee_t to tiptop;
grant update on pmee_t to tiptop;
grant delete on pmee_t to tiptop;
grant insert on pmee_t to tiptop;

exit;
