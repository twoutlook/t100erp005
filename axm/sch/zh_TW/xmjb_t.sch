/* 
================================================================================
檔案代號:xmjb_t
檔案名稱:分銷訂單商品變更明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table xmjb_t
(
xmjbent       number(5)      ,/* 企業編號 */
xmjbsite       varchar2(10)      ,/* 營運據點(辦事處) */
xmjbunit       varchar2(10)      ,/* 應用組織 */
xmjbdocno       varchar2(20)      ,/* 單據編號 */
xmjbseq       number(10,0)      ,/* 項次 */
xmjb001       varchar2(2000)      ,/* 交易類型 */
xmjb002       varchar2(40)      ,/* 商品條碼 */
xmjb003       varchar2(40)      ,/* 商品編號 */
xmjb004       varchar2(256)      ,/* 產品特徵 */
xmjb005       varchar2(30)      ,/* 促銷方案 */
xmjb006       varchar2(10)      ,/* 稅別編號 */
xmjb007       number(5,2)      ,/* 稅率 */
xmjb008       number(20,6)      ,/* 標準售價 */
xmjb009       number(20,6)      ,/* 促銷價 */
xmjb010       number(20,6)      ,/* 交易價 */
xmjb011       varchar2(10)      ,/* 包裝單位 */
xmjb012       number(20,6)      ,/* 包裝數量 */
xmjb013       varchar2(10)      ,/* 銷售單位 */
xmjb014       number(20,6)      ,/* 銷售數量 */
xmjb015       varchar2(10)      ,/* 參考單位 */
xmjb016       number(20,6)      ,/* 參考數量 */
xmjb017       varchar2(10)      ,/* 計價單位 */
xmjb018       number(20,6)      ,/* 計價數量 */
xmjb900       number(10,0)      ,/* 變更序 */
xmjb901       varchar2(1)      ,/* 變更類型 */
xmjb902       varchar2(10)      ,/* 變更理由 */
xmjb903       varchar2(255)      ,/* 變更備註 */
xmjb019       number(20,6)      ,/* 未稅金額 */
xmjb020       number(20,6)      ,/* 稅額 */
xmjb021       number(20,6)      ,/* 含稅金額 */
xmjb022       number(20,6)      ,/* 折價金額 */
xmjb024       varchar2(10)      ,/* 收貨網點 */
xmjb025       varchar2(10)      ,/* 送貨客戶 */
xmjb026       varchar2(10)      ,/* 送貨地址碼 */
xmjb027       varchar2(10)      ,/* 送貨站點 */
xmjb028       varchar2(20)      ,/* 主合約編號 */
xmjb029       varchar2(20)      ,/* 協議編號 */
xmjb030       varchar2(1)      ,/* 多交期 */
xmjb031       date      ,/* 約定交貨日 */
xmjb032       date      ,/* 約定簽收日 */
xmjb033       varchar2(40)      ,/* 客戶料號 */
xmjb034       varchar2(255)      ,/* 備註 */
xmjbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmjbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmjbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmjbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmjbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmjbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmjbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmjbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmjbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmjbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmjbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmjbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmjbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmjbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmjbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmjbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmjbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmjbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmjbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmjbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmjbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmjbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmjbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmjbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmjbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmjbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmjbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmjbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmjbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmjbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmjb037       varchar2(10)      ,/* 地區編號 */
xmjb038       varchar2(10)      ,/* 縣市編號 */
xmjb039       varchar2(10)      ,/* 省區編號 */
xmjb040       varchar2(10)      /* 區域編號 */
);
alter table xmjb_t add constraint xmjb_pk primary key (xmjbent,xmjbdocno,xmjbseq,xmjb900) enable validate;

create unique index xmjb_pk on xmjb_t (xmjbent,xmjbdocno,xmjbseq,xmjb900);

grant select on xmjb_t to tiptop;
grant update on xmjb_t to tiptop;
grant delete on xmjb_t to tiptop;
grant insert on xmjb_t to tiptop;

exit;
