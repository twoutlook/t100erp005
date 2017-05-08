/* 
================================================================================
檔案代號:xccb_t
檔案名稱:期初在制數量成本開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xccb_t
(
xccbent       number(5)      ,/* 企業編號 */
xccbld       varchar2(5)      ,/* 帳套 */
xccbcomp       varchar2(10)      ,/* 法人組織 */
xccb001       varchar2(1)      ,/* 帳套本位幣順序 */
xccb002       varchar2(30)      ,/* 成本域 */
xccb003       varchar2(10)      ,/* 成本計算類型 */
xccb004       number(5,0)      ,/* 年度 */
xccb005       number(5,0)      ,/* 期別 */
xccb006       varchar2(20)      ,/* 工單編號 */
xccb007       varchar2(40)      ,/* 元件編號 */
xccb008       varchar2(256)      ,/* 特性 */
xccb009       varchar2(30)      ,/* 批號 */
xccb010       varchar2(1)      ,/* 元件類型 */
xccb101       number(20,6)      ,/* 當月期末數量 */
xccb102       number(20,6)      ,/* 當月期末金額-金額合計 */
xccb102a       number(20,6)      ,/* 當月期末金額-材料 */
xccb102b       number(20,6)      ,/* 當月期末金額-人工 */
xccb102c       number(20,6)      ,/* 當月期末金額-委外加工 */
xccb102d       number(20,6)      ,/* 當月期末金額-制費一 */
xccb102e       number(20,6)      ,/* 當月期末金額-制費二 */
xccb102f       number(20,6)      ,/* 當月期末金額-制費三 */
xccb102g       number(20,6)      ,/* 當月期末金額-制費四 */
xccb102h       number(20,6)      ,/* 當月期末金額-制費五 */
xccbownid       varchar2(20)      ,/* 資料所有者 */
xccbowndp       varchar2(10)      ,/* 資料所屬部門 */
xccbcrtid       varchar2(20)      ,/* 資料建立者 */
xccbcrtdp       varchar2(10)      ,/* 資料建立部門 */
xccbcrtdt       timestamp(0)      ,/* 資料創建日 */
xccbmodid       varchar2(20)      ,/* 資料修改者 */
xccbmoddt       timestamp(0)      ,/* 最近修改日 */
xccbcnfid       varchar2(20)      ,/* 資料確認者 */
xccbcnfdt       timestamp(0)      ,/* 資料確認日 */
xccbpstid       varchar2(20)      ,/* 資料過帳者 */
xccbpstdt       timestamp(0)      ,/* 資料過帳日 */
xccbstus       varchar2(10)      ,/* 狀態碼 */
xccbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xccb_t add constraint xccb_pk primary key (xccbent,xccbld,xccb001,xccb002,xccb003,xccb004,xccb005,xccb006,xccb007,xccb008,xccb009) enable validate;

create unique index xccb_pk on xccb_t (xccbent,xccbld,xccb001,xccb002,xccb003,xccb004,xccb005,xccb006,xccb007,xccb008,xccb009);

grant select on xccb_t to tiptop;
grant update on xccb_t to tiptop;
grant delete on xccb_t to tiptop;
grant insert on xccb_t to tiptop;

exit;
