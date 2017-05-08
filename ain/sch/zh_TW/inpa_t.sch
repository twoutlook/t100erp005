/* 
================================================================================
檔案代號:inpa_t
檔案名稱:盤點計劃單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inpa_t
(
inpaent       number(5)      ,/* 企業編號 */
inpasite       varchar2(10)      ,/* 營運據點 */
inpadocno       varchar2(20)      ,/* 計劃單號 */
inpadocdt       date      ,/* 輸入日期 */
inpa001       varchar2(1)      ,/* 盤點類型 */
inpa002       varchar2(20)      ,/* 計劃人員 */
inpa003       varchar2(10)      ,/* 計劃部門 */
inpa004       varchar2(20)      ,/* 總負責人 */
inpa005       date      ,/* 存貨預計凍結日 */
inpa006       date      ,/* 存貨實際凍結日 */
inpa007       varchar2(255)      ,/* 備註 */
inpa008       varchar2(1)      ,/* 盤點輸入方式 */
inpa009       varchar2(1)      ,/* 現有庫存初盤一 */
inpa010       varchar2(1)      ,/* 現有庫存初盤二 */
inpa011       varchar2(1)      ,/* 現有庫存複盤一 */
inpa012       varchar2(1)      ,/* 現有庫存複盤二 */
inpa013       varchar2(1)      ,/* 在製工單初盤一 */
inpa014       varchar2(1)      ,/* 在製工單初盤二 */
inpa015       varchar2(1)      ,/* 在製工單複盤一 */
inpa016       varchar2(1)      ,/* 在製工單複盤二 */
inpa017       varchar2(1)      ,/* 包含已無庫存量 */
inpa018       varchar2(5)      ,/* 存貨盤點單別 */
inpa019       varchar2(5)      ,/* 存貨空白單別 */
inpa020       varchar2(1)      ,/* 產生方式 */
inpa021       varchar2(5)      ,/* 在製盤點單別 */
inpa022       varchar2(5)      ,/* 在製空白單別 */
inpa023       varchar2(1)      ,/* 盤點列印方式 */
inpa024       varchar2(1)      ,/* 顯示帳上庫存數 */
inpa025       varchar2(1)      ,/* 存貨排序一 */
inpa026       varchar2(1)      ,/* 存貨排序二 */
inpa027       varchar2(1)      ,/* 存貨排序三 */
inpa028       varchar2(1)      ,/* 存貨排序四 */
inpa029       varchar2(1)      ,/* 存貨排序五 */
inpa030       varchar2(1)      ,/* 存貨排序六 */
inpa031       varchar2(1)      ,/* 分群碼選項 */
inpa032       varchar2(1)      ,/* 在製排序一 */
inpa033       varchar2(1)      ,/* 在製排序二 */
inpa034       varchar2(1)      ,/* 在製排序三 */
inpa035       varchar2(1)      ,/* 在製排序四 */
inpa036       varchar2(1)      ,/* 在製排序五 */
inpa037       varchar2(1)      ,/* 在製排序六 */
inpa038       date      ,/* 開始日期 */
inpa039       date      ,/* 截止日期 */
inpa050       varchar2(5)      ,/* 盤點雜收單別 */
inpa051       varchar2(5)      ,/* 盤點雜發單別 */
inpa052       varchar2(5)      ,/* 盤點發料單別 */
inpa053       varchar2(5)      ,/* 盤點退料單別 */
inpa054       varchar2(5)      ,/* 盤點超領單別 */
inpaownid       varchar2(20)      ,/* 資料所有者 */
inpaowndp       varchar2(10)      ,/* 資料所屬部門 */
inpacrtid       varchar2(20)      ,/* 資料建立者 */
inpacrtdp       varchar2(10)      ,/* 資料建立部門 */
inpacrtdt       timestamp(0)      ,/* 資料創建日 */
inpamodid       varchar2(20)      ,/* 資料修改者 */
inpamoddt       timestamp(0)      ,/* 最近修改日 */
inpacnfid       varchar2(20)      ,/* 資料確認者 */
inpacnfdt       timestamp(0)      ,/* 資料確認日 */
inpapstid       varchar2(20)      ,/* 資料過帳者 */
inpapstdt       timestamp(0)      ,/* 資料過帳日 */
inpastus       varchar2(10)      ,/* 狀態碼 */
inpa040       date      ,/* 盤點日期 */
inpa041       date      ,/* 最近重計日 */
inpaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inpa042       varchar2(10)      ,/* 在製盤差處理倉 */
inpa043       varchar2(10)      /* 在製盤差處理儲位 */
);
alter table inpa_t add constraint inpa_pk primary key (inpaent,inpadocno) enable validate;

create unique index inpa_pk on inpa_t (inpaent,inpadocno);

grant select on inpa_t to tiptop;
grant update on inpa_t to tiptop;
grant delete on inpa_t to tiptop;
grant insert on inpa_t to tiptop;

exit;
