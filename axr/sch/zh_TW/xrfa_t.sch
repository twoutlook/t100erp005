/* 
================================================================================
檔案代號:xrfa_t
檔案名稱:集團收款核銷單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xrfa_t
(
xrfaent       number(5)      ,/* 企業編碼 */
xrfadocno       varchar2(20)      ,/* 集團代收單號 */
xrfadocdt       date      ,/* 收款日期 */
xrfasite       varchar2(10)      ,/* 帳務中心 */
xrfacomp       varchar2(10)      ,/* 法人組織 */
xrfald       varchar2(5)      ,/* 帳套 */
xrfa001       varchar2(20)      ,/* 帳務人員 */
xrfa002       varchar2(10)      ,/* 客戶代碼 */
xrfastus       varchar2(1)      ,/* 狀態碼 */
xrfaownid       varchar2(20)      ,/* 資料所有者 */
xrfaowndp       varchar2(10)      ,/* 資料所屬部門 */
xrfacrtid       varchar2(20)      ,/* 資料建立者 */
xrfacrtdp       varchar2(10)      ,/* 資料建立部門 */
xrfacrtdt       timestamp(0)      ,/* 資料創建日 */
xrfamodid       varchar2(20)      ,/* 資料修改者 */
xrfamoddt       timestamp(0)      ,/* 最近修改日 */
xrfacnfid       varchar2(20)      ,/* 資料確認者 */
xrfacnfdt       timestamp(0)      ,/* 資料確認日 */
xrfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrfaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrfa_t add constraint xrfa_pk primary key (xrfaent,xrfadocno) enable validate;

create unique index xrfa_pk on xrfa_t (xrfaent,xrfadocno);

grant select on xrfa_t to tiptop;
grant update on xrfa_t to tiptop;
grant delete on xrfa_t to tiptop;
grant insert on xrfa_t to tiptop;

exit;
