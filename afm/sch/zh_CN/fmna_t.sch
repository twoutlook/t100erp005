/* 
================================================================================
檔案代號:fmna_t
檔案名稱:投資重評價帳務單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmna_t
(
fmnaent       number(5)      ,/* 企業編號 */
fmnadocno       varchar2(20)      ,/* 單據編號 */
fmnacomp       varchar2(10)      ,/* 法人 */
fmnasite       varchar2(10)      ,/* 帳務中心 */
fmnadocdt       date      ,/* 單據日期 */
fmna001       varchar2(5)      ,/* 帳套 */
fmna002       number(5,0)      ,/* 年度 */
fmna003       number(5,0)      ,/* 期別 */
fmna004       varchar2(1)      ,/* 來源 */
fmna005       varchar2(20)      ,/* 憑證號碼 */
fmna006       varchar2(20)      ,/* 帳務人員 */
fmnaownid       varchar2(20)      ,/* 資料所有者 */
fmnaowndp       varchar2(10)      ,/* 資料所屬部門 */
fmnacrtid       varchar2(20)      ,/* 資料建立者 */
fmnacrtdp       varchar2(10)      ,/* 資料建立部門 */
fmnacrtdt       timestamp(0)      ,/* 資料創建日 */
fmnamodid       varchar2(20)      ,/* 資料修改者 */
fmnamoddt       timestamp(0)      ,/* 最近修改日 */
fmnacnfid       varchar2(20)      ,/* 資料確認者 */
fmnacnfdt       timestamp(0)      ,/* 資料確認日 */
fmnapstid       varchar2(20)      ,/* 資料過帳者 */
fmnapstdt       timestamp(0)      ,/* 資料過帳日 */
fmnastus       varchar2(10)      ,/* 狀態碼 */
fmnaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmnaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmnaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmnaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmnaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmnaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmnaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmnaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmnaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmnaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmnaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmnaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmnaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmnaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmnaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmnaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmnaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmnaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmnaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmnaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmnaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmnaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmnaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmnaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmnaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmnaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmnaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmnaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmnaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmnaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmna_t add constraint fmna_pk primary key (fmnaent,fmnadocno) enable validate;

create unique index fmna_pk on fmna_t (fmnaent,fmnadocno);

grant select on fmna_t to tiptop;
grant update on fmna_t to tiptop;
grant delete on fmna_t to tiptop;
grant insert on fmna_t to tiptop;

exit;
