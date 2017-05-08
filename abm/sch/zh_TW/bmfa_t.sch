/* 
================================================================================
檔案代號:bmfa_t
檔案名稱:ECN單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bmfa_t
(
bmfaent       number(5)      ,/* 企業編號 */
bmfaownid       varchar2(20)      ,/* 資料所屬者 */
bmfaowndp       varchar2(10)      ,/* 資料所有部門 */
bmfacrtid       varchar2(20)      ,/* 資料建立者 */
bmfacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmfacrtdt       timestamp(0)      ,/* 資料創建日 */
bmfamodid       varchar2(20)      ,/* 資料修改者 */
bmfamoddt       timestamp(0)      ,/* 最近修改日 */
bmfacnfid       varchar2(20)      ,/* 資料確認者 */
bmfacnfdt       timestamp(0)      ,/* 資料確認日 */
bmfapstid       varchar2(20)      ,/* 資料過帳者 */
bmfapstdt       timestamp(0)      ,/* 資料過帳日 */
bmfastus       varchar2(10)      ,/* 狀態碼 */
bmfasite       varchar2(10)      ,/* 營運據點 */
bmfadocno       varchar2(20)      ,/* ECN單號 */
bmfadocdt       date      ,/* 單據日期 */
bmfa003       varchar2(40)      ,/* 主件料號 */
bmfa004       varchar2(30)      ,/* 特性/版本 */
bmfa005       timestamp(0)      ,/* 生效日期 */
bmfa006       varchar2(20)      ,/* 申請人員 */
bmfa007       varchar2(10)      ,/* 申請部門 */
bmfa008       varchar2(20)      ,/* ECR單號 */
bmfa009       varchar2(10)      ,/* 舊生命週期 */
bmfa010       varchar2(10)      ,/* 新生命週期 */
bmfa011       varchar2(10)      ,/* 舊版本 */
bmfa012       varchar2(10)      ,/* 新版本 */
bmfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
bmfa013       varchar2(10)      ,/* 舊生產單位 */
bmfa014       varchar2(10)      /* 新生產單位 */
);
alter table bmfa_t add constraint bmfa_pk primary key (bmfaent,bmfasite,bmfadocno) enable validate;

create unique index bmfa_pk on bmfa_t (bmfaent,bmfasite,bmfadocno);

grant select on bmfa_t to tiptop;
grant update on bmfa_t to tiptop;
grant delete on bmfa_t to tiptop;
grant insert on bmfa_t to tiptop;

exit;
