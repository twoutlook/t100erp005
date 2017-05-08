/* 
================================================================================
檔案代號:xmdg_t
檔案名稱:出通單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmdg_t
(
xmdgent       number(5)      ,/* 企業編號 */
xmdgsite       varchar2(10)      ,/* 營運據點 */
xmdgunit       varchar2(10)      ,/* 應用組織 */
xmdgdocno       varchar2(20)      ,/* 單據單號 */
xmdgdocdt       date      ,/* 單據日期 */
xmdg001       varchar2(10)      ,/* 出貨性質 */
xmdg002       varchar2(20)      ,/* 業務人員 */
xmdg003       varchar2(10)      ,/* 業務部門 */
xmdg004       varchar2(20)      ,/* 訂單單號 */
xmdg005       varchar2(10)      ,/* 訂單客戶 */
xmdg006       varchar2(10)      ,/* 收款客戶 */
xmdg007       varchar2(10)      ,/* 收貨客戶 */
xmdg008       varchar2(10)      ,/* 收款條件 */
xmdg009       varchar2(10)      ,/* 交易條件 */
xmdg010       varchar2(10)      ,/* 稅別 */
xmdg011       number(5,2)      ,/* 稅率 */
xmdg012       varchar2(1)      ,/* 單價含稅否 */
xmdg013       varchar2(2)      ,/* 發票類型 */
xmdg014       varchar2(10)      ,/* 幣別 */
xmdg015       number(20,10)      ,/* 匯率 */
xmdg016       varchar2(10)      ,/* 送貨供應商 */
xmdg017       varchar2(10)      ,/* 送貨地址 */
xmdg018       varchar2(10)      ,/* 運輸方式 */
xmdg019       varchar2(10)      ,/* 交運起點 */
xmdg020       varchar2(10)      ,/* 交運終點 */
xmdg021       varchar2(20)      ,/* 航次/航班/車號 */
xmdg022       date      ,/* 起運日期 */
xmdg023       varchar2(30)      ,/* 嘜頭編號 */
xmdg024       varchar2(10)      ,/* 包裝單製作 */
xmdg025       varchar2(10)      ,/* Invoice製作 */
xmdg026       varchar2(10)      ,/* 銷售通路 */
xmdg027       varchar2(10)      ,/* 銷售分類 */
xmdg028       date      ,/* 預計出貨日期 */
xmdg030       varchar2(10)      ,/* 額外品名規格 */
xmdg031       varchar2(10)      ,/* 留置原因 */
xmdg032       varchar2(10)      ,/* 內外銷 */
xmdg033       varchar2(10)      ,/* 匯率計算基準 */
xmdg034       varchar2(10)      ,/* 多角性質 */
xmdg050       number(20,6)      ,/* 總未稅金額 */
xmdg051       number(20,6)      ,/* 總含稅金額 */
xmdg052       number(20,6)      ,/* 總稅額 */
xmdg053       varchar2(255)      ,/* 備註 */
xmdg054       varchar2(1)      ,/* 多角貿易已拋轉 */
xmdg055       varchar2(20)      ,/* 多角序號 */
xmdg200       varchar2(10)      ,/* 調貨經銷商編號 */
xmdg201       varchar2(10)      ,/* 代送商編號 */
xmdg202       varchar2(10)      ,/* 發票客戶 */
xmdg203       varchar2(30)      ,/* 促銷方案編號 */
xmdg204       varchar2(10)      ,/* 送貨站點編號 */
xmdg205       varchar2(10)      ,/* 運輸路線編號 */
xmdg206       varchar2(10)      ,/* No Use */
xmdg207       varchar2(10)      ,/* No Use */
xmdg208       varchar2(10)      ,/* No Use */
xmdg209       varchar2(10)      ,/* No Use */
xmdgownid       varchar2(20)      ,/* 資料所屬者 */
xmdgowndp       varchar2(10)      ,/* 資料所有部門 */
xmdgcrtid       varchar2(20)      ,/* 資料建立者 */
xmdgcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmdgcrtdt       timestamp(0)      ,/* 資料創建日 */
xmdgmodid       varchar2(20)      ,/* 資料修改者 */
xmdgmoddt       timestamp(0)      ,/* 最近修改日 */
xmdgcnfid       varchar2(20)      ,/* 資料確認者 */
xmdgcnfdt       timestamp(0)      ,/* 資料確認日 */
xmdgpstid       varchar2(20)      ,/* 資料過帳者 */
xmdgpstdt       timestamp(0)      ,/* 資料過賬日 */
xmdgstus       varchar2(10)      ,/* 狀態碼 */
xmdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdg056       varchar2(10)      ,/* 多角流程代號 */
xmdg057       varchar2(10)      ,/* 整合來源 */
xmdg058       varchar2(20)      /* 整合單號 */
);
alter table xmdg_t add constraint xmdg_pk primary key (xmdgent,xmdgdocno) enable validate;

create unique index xmdg_pk on xmdg_t (xmdgent,xmdgdocno);

grant select on xmdg_t to tiptop;
grant update on xmdg_t to tiptop;
grant delete on xmdg_t to tiptop;
grant insert on xmdg_t to tiptop;

exit;
