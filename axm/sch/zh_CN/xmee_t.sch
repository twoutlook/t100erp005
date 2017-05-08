/* 
================================================================================
檔案代號:xmee_t
檔案名稱:訂單變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmee_t
(
xmeeent       number(5)      ,/* 企業編號 */
xmeesite       varchar2(10)      ,/* 營運據點 */
xmeedocno       varchar2(20)      ,/* 訂單單號 */
xmeedocdt       date      ,/* 訂單日期 */
xmee001       number(5,0)      ,/* 版次 */
xmee002       varchar2(20)      ,/* 業務人員 */
xmee003       varchar2(10)      ,/* 業務部門 */
xmee004       varchar2(10)      ,/* 客戶編號 */
xmee005       varchar2(10)      ,/* 訂單性質 */
xmee006       varchar2(10)      ,/* 多角性質 */
xmee007       varchar2(10)      ,/* 資料來源 */
xmee008       varchar2(20)      ,/* 來源單號 */
xmee009       varchar2(10)      ,/* 收款條件 */
xmee010       varchar2(10)      ,/* 交易條件 */
xmee011       varchar2(10)      ,/* 稅別 */
xmee012       number(5,2)      ,/* 稅率 */
xmee013       varchar2(1)      ,/* 單價含稅否 */
xmee015       varchar2(10)      ,/* 幣別 */
xmee016       number(20,10)      ,/* 匯率 */
xmee017       varchar2(10)      ,/* 取價方式 */
xmee018       varchar2(10)      ,/* 收款優惠條件 */
xmee019       varchar2(1)      ,/* 納入 MPS/MRP計算 */
xmee020       varchar2(10)      ,/* 運送方式 */
xmee021       varchar2(10)      ,/* 帳款客戶 */
xmee022       varchar2(10)      ,/* 收貨客戶 */
xmee023       varchar2(10)      ,/* 銷售通路 */
xmee024       varchar2(10)      ,/* 銷售分類二 */
xmee025       varchar2(10)      ,/* 出貨地址 */
xmee026       varchar2(10)      ,/* 帳款地址 */
xmee027       varchar2(20)      ,/* 客戶連絡人 */
xmee028       varchar2(20)      ,/* 一次性交易對象識別碼 */
xmee029       varchar2(10)      ,/* 出貨部門 */
xmee030       varchar2(1)      ,/* 多角貿易已拋轉 */
xmee031       varchar2(20)      ,/* 多角來源單號 */
xmee032       varchar2(10)      ,/* 留置原因 */
xmee033       varchar2(20)      ,/* 客戶訂購單號 */
xmee034       varchar2(10)      ,/* 最終客戶 */
xmee035       varchar2(2)      ,/* 發票類型 */
xmee036       varchar2(10)      ,/* 送貨供應商 */
xmee037       varchar2(10)      ,/* 起運點 */
xmee038       varchar2(10)      ,/* 目的地 */
xmee039       varchar2(10)      ,/* 預收款發票開立方式 */
xmee041       number(20,6)      ,/* 訂單總未稅金額 */
xmee042       number(20,6)      ,/* 訂單總含稅金額 */
xmee043       number(20,6)      ,/* 訂單總稅額 */
xmee044       varchar2(10)      ,/* 嘜頭編號 */
xmee045       varchar2(1)      ,/* 物流結案 */
xmee046       varchar2(1)      ,/* 帳流結案 */
xmee047       varchar2(1)      ,/* 金流結案 */
xmee048       varchar2(10)      ,/* 內外銷 */
xmee049       varchar2(10)      ,/* 匯率計算基準 */
xmee050       varchar2(10)      ,/* 多角流程代碼 */
xmee051       varchar2(1)      ,/* 多角最終站 */
xmee071       varchar2(255)      ,/* 備註 */
xmee900       number(10,0)      ,/* 變更序 */
xmee901       varchar2(1)      ,/* 變更類型 */
xmee902       date      ,/* 變更日期 */
xmee903       varchar2(10)      ,/* 變更理由 */
xmee904       varchar2(255)      ,/* 變更備註 */
xmeeownid       varchar2(20)      ,/* 資料所有者 */
xmeeowndp       varchar2(10)      ,/* 資料所屬部門 */
xmeecrtid       varchar2(20)      ,/* 資料建立者 */
xmeecrtdp       varchar2(10)      ,/* 資料建立部門 */
xmeecrtdt       timestamp(0)      ,/* 資料創建日 */
xmeemodid       varchar2(20)      ,/* 資料修改者 */
xmeemoddt       timestamp(0)      ,/* 最近修改日 */
xmeecnfid       varchar2(20)      ,/* 資料確認者 */
xmeecnfdt       timestamp(0)      ,/* 資料確認日 */
xmeestus       varchar2(10)      ,/* 狀態碼 */
xmeeacti       varchar2(1)      ,/* 訂購單結案否 */
xmee200       varchar2(10)      ,/* 調貨經銷商編號 */
xmee201       varchar2(10)      ,/* 代送商編號 */
xmee202       varchar2(10)      ,/* 銷售辦事處 */
xmee203       varchar2(10)      ,/* 發票客戶 */
xmee204       varchar2(30)      ,/* 促銷方案編號 */
xmee205       number(20,6)      ,/* 整單折扣 */
xmee206       varchar2(10)      ,/* 送貨站點編號 */
xmee207       varchar2(10)      ,/* 運輸路線編號 */
xmee208       varchar2(10)      ,/* 地區編號 */
xmee209       varchar2(10)      ,/* 縣市編號 */
xmee210       varchar2(10)      ,/* 省區編號 */
xmee211       varchar2(10)      ,/* 區域編號 */
xmeeunit       varchar2(10)      ,/* 應用組織 */
xmeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmeeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmee_t add constraint xmee_pk primary key (xmeeent,xmeedocno,xmee900) enable validate;

create unique index xmee_pk on xmee_t (xmeeent,xmeedocno,xmee900);

grant select on xmee_t to tiptop;
grant update on xmee_t to tiptop;
grant delete on xmee_t to tiptop;
grant insert on xmee_t to tiptop;

exit;
