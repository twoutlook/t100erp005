/* 
================================================================================
檔案代號:sfqa_t
檔案名稱:PBI單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfqa_t
(
sfqaent       number(5)      ,/* 企業代碼 */
sfqasite       varchar2(10)      ,/* 營運據點 */
sfqadocno       varchar2(20)      ,/* PBI單號 */
sfqadocdt       date      ,/* 單據日期 */
sfqa001       varchar2(255)      ,/* 備註 */
sfqaownid       varchar2(20)      ,/* 資料所有者 */
sfqaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfqacrtid       varchar2(20)      ,/* 資料建立者 */
sfqacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfqacrtdt       timestamp(0)      ,/* 資料創建日 */
sfqamodid       varchar2(20)      ,/* 資料修改者 */
sfqamoddt       timestamp(0)      ,/* 最近修改日 */
sfqacnfid       varchar2(20)      ,/* 資料確認者 */
sfqacnfdt       timestamp(0)      ,/* 資料確認日 */
sfqapstid       varchar2(20)      ,/* 資料過帳者 */
sfqapstdt       timestamp(0)      ,/* 資料過帳日 */
sfqastus       varchar2(10)      ,/* 狀態碼 */
sfqaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfqaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfqaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfqaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfqaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfqaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfqaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfqaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfqaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfqaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfqaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfqaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfqaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfqaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfqaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfqaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfqaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfqaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfqaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfqaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfqaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfqaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfqaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfqaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfqaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfqaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfqaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfqaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfqaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfqaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfqa_t add constraint sfqa_pk primary key (sfqaent,sfqadocno) enable validate;

create unique index sfqa_pk on sfqa_t (sfqaent,sfqadocno);

grant select on sfqa_t to tiptop;
grant update on sfqa_t to tiptop;
grant delete on sfqa_t to tiptop;
grant insert on sfqa_t to tiptop;

exit;
