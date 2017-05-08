/* 
================================================================================
檔案代號:prfa_t
檔案名稱:客戶組申請維護作業
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prfa_t
(
prfaent       number(5)      ,/* 企業編號 */
prfaunit       varchar2(10)      ,/* 應用組織 */
prfasite       varchar2(10)      ,/* 營運據點 */
prfadocno       varchar2(20)      ,/* 單據編號 */
prfadocdt       date      ,/* 單據日期 */
prfa001       varchar2(10)      ,/* 申請類型 */
prfa002       varchar2(10)      ,/* 客戶組別 */
prfa003       varchar2(10)      ,/* 客戶版本 */
prfa004       varchar2(20)      ,/* 申請人員 */
prfa005       varchar2(10)      ,/* 申請部門 */
prfastus       varchar2(10)      ,/* 狀態碼 */
prfaacti       varchar2(1)      ,/* 資料有效碼 */
prfaownid       varchar2(20)      ,/* 資料所有者 */
prfaowndp       varchar2(10)      ,/* 資料所屬部門 */
prfacrtid       varchar2(20)      ,/* 資料建立者 */
prfacrtdp       varchar2(10)      ,/* 資料建立部門 */
prfacrtdt       timestamp(0)      ,/* 資料創建日 */
prfamodid       varchar2(20)      ,/* 資料修改者 */
prfamoddt       timestamp(0)      ,/* 最近修改日 */
prfacnfid       varchar2(20)      ,/* 資料確認者 */
prfacnfdt       timestamp(0)      ,/* 資料確認日 */
prfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfa_t add constraint prfa_pk primary key (prfaent,prfadocno) enable validate;

create unique index prfa_pk on prfa_t (prfaent,prfadocno);

grant select on prfa_t to tiptop;
grant update on prfa_t to tiptop;
grant delete on prfa_t to tiptop;
grant insert on prfa_t to tiptop;

exit;
