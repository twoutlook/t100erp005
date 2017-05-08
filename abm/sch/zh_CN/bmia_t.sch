/* 
================================================================================
檔案代號:bmia_t
檔案名稱:料件承認申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bmia_t
(
bmiaent       number(5)      ,/* 企業編號 */
bmiasite       varchar2(10)      ,/* 營運據點 */
bmiadocno       varchar2(20)      ,/* 料件承認申請單號 */
bmiadocdt       date      ,/* 申請日期 */
bmia001       varchar2(10)      ,/* 承認類型 */
bmia002       varchar2(20)      ,/* 申請人員 */
bmia003       varchar2(10)      ,/* 申請部門 */
bmia004       varchar2(40)      ,/* 承認料號 */
bmia005       varchar2(10)      ,/* 承認模板編號 */
bmia006       varchar2(256)      ,/* 產品特徵 */
bmia007       varchar2(10)      ,/* 廠商/客戶編號 */
bmia008       varchar2(10)      ,/* 作業編號 */
bmia009       varchar2(10)      ,/* 作業序 */
bmia010       varchar2(40)      ,/* 承認主件 */
bmia011       varchar2(20)      ,/* 聯絡人 */
bmia012       varchar2(40)      ,/* 交易對象料號 */
bmia013       varchar2(10)      ,/* 承認狀態 */
bmia014       varchar2(10)      ,/* 更新料件生命週期 */
bmia015       varchar2(80)      ,/* 承認文號 */
bmia016       varchar2(255)      ,/* 備註 */
bmia017       number(20,6)      ,/* 限制數量(暫時承認) */
bmia018       date      ,/* 失效日期(暫時承認) */
bmia019       date      ,/* 承認有效日期-起 */
bmia020       date      ,/* 承認有效日期-迄 */
bmiaownid       varchar2(20)      ,/* 資料所有者 */
bmiaowndp       varchar2(10)      ,/* 資料所屬部門 */
bmiacrtid       varchar2(20)      ,/* 資料建立者 */
bmiacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmiacrtdt       timestamp(0)      ,/* 資料創建日 */
bmiamodid       varchar2(20)      ,/* 資料修改者 */
bmiamoddt       timestamp(0)      ,/* 最近修改日 */
bmiacnfid       varchar2(20)      ,/* 資料確認者 */
bmiacnfdt       timestamp(0)      ,/* 資料確認日 */
bmiastus       varchar2(10)      ,/* 狀態碼 */
bmiaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmiaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmiaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmiaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmiaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmiaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmiaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmiaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmiaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmiaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmiaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmiaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmiaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmiaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmiaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmiaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmiaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmiaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmiaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmiaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmiaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmiaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmiaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmiaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmiaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmiaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmiaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmiaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmiaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmiaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmia_t add constraint bmia_pk primary key (bmiaent,bmiadocno) enable validate;

create unique index bmia_pk on bmia_t (bmiaent,bmiadocno);

grant select on bmia_t to tiptop;
grant update on bmia_t to tiptop;
grant delete on bmia_t to tiptop;
grant insert on bmia_t to tiptop;

exit;
