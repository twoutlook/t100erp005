/* 
================================================================================
檔案代號:deda_t
檔案名稱:營業款調整單單頭
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deda_t
(
dedaent       number(5)      ,/* 企業編號 */
dedasite       varchar2(10)      ,/* 營運據點 */
dedaunit       varchar2(10)      ,/* 應用組織 */
dedadocdt       date      ,/* 單據日期 */
dedadocno       varchar2(20)      ,/* 單據編號 */
deda001       varchar2(10)      ,/* 部門 */
deda002       varchar2(20)      ,/* 人員 */
deda003       varchar2(80)      ,/* 備註 */
dedaownid       varchar2(20)      ,/* 資料所有者 */
dedaowndp       varchar2(10)      ,/* 資料所屬部門 */
dedacrtid       varchar2(20)      ,/* 資料建立者 */
dedacrtdp       varchar2(10)      ,/* 資料建立部門 */
dedacrtdt       timestamp(0)      ,/* 資料創建日 */
dedamodid       varchar2(20)      ,/* 資料修改者 */
dedamoddt       timestamp(0)      ,/* 最近修改日 */
dedacnfid       varchar2(20)      ,/* 資料確認者 */
dedacnfdt       timestamp(0)      ,/* 資料確認日 */
dedastus       varchar2(10)      ,/* 狀態碼 */
dedaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dedaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dedaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dedaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dedaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dedaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dedaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dedaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dedaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dedaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dedaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dedaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dedaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dedaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dedaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dedaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dedaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dedaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dedaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dedaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dedaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dedaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dedaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dedaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dedaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dedaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dedaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dedaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dedaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dedaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deda_t add constraint deda_pk primary key (dedaent,dedadocno) enable validate;

create unique index deda_pk on deda_t (dedaent,dedadocno);

grant select on deda_t to tiptop;
grant update on deda_t to tiptop;
grant delete on deda_t to tiptop;
grant insert on deda_t to tiptop;

exit;
