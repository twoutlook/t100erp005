/* 
================================================================================
檔案代號:sfna_t
檔案名稱:異常工時申報單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfna_t
(
sfnaent       number(5)      ,/* 企業代碼 */
sfnasite       varchar2(10)      ,/* 營運據點 */
sfnadocno       varchar2(20)      ,/* 單號 */
sfnadocdt       date      ,/* 單據日期 */
sfna001       varchar2(10)      ,/* 申報部門 */
sfna002       varchar2(20)      ,/* 申報人員 */
sfnaownid       varchar2(20)      ,/* 資料所有者 */
sfnaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfnacrtid       varchar2(20)      ,/* 資料建立者 */
sfnacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfnacrtdt       timestamp(0)      ,/* 資料創建日 */
sfnamodid       varchar2(20)      ,/* 資料修改者 */
sfnamoddt       timestamp(0)      ,/* 最近修改日 */
sfnacnfid       varchar2(20)      ,/* 資料確認者 */
sfnacnfdt       timestamp(0)      ,/* 資料確認日 */
sfnastus       varchar2(10)      ,/* 狀態碼 */
sfnaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfnaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfnaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfnaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfnaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfnaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfnaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfnaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfnaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfnaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfnaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfnaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfnaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfnaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfnaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfnaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfnaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfnaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfnaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfnaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfnaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfnaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfnaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfnaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfnaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfnaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfnaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfnaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfnaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfnaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfna_t add constraint sfna_pk primary key (sfnaent,sfnadocno) enable validate;

create unique index sfna_pk on sfna_t (sfnaent,sfnadocno);

grant select on sfna_t to tiptop;
grant update on sfna_t to tiptop;
grant delete on sfna_t to tiptop;
grant insert on sfna_t to tiptop;

exit;
