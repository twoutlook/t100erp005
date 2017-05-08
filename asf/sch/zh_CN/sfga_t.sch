/* 
================================================================================
檔案代號:sfga_t
檔案名稱:工單當站報廢單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sfga_t
(
sfgaent       number(5)      ,/* 企業編號 */
sfgasite       varchar2(10)      ,/* 營運據點 */
sfgadocno       varchar2(20)      ,/* 單據編號 */
sfgadocdt       date      ,/* 單據日期 */
sfga001       date      ,/* 過帳日期 */
sfga002       varchar2(20)      ,/* 申請人員 */
sfga003       varchar2(10)      ,/* 部門 */
sfga004       varchar2(20)      ,/* 工單單號 */
sfga005       number(10,0)      ,/* Run Card */
sfga006       varchar2(10)      ,/* 作業編號 */
sfga007       varchar2(10)      ,/* 作業序 */
sfga008       number(20,6)      ,/* 申請數量 */
sfga009       number(20,6)      ,/* 報廢數量 */
sfga010       varchar2(255)      ,/* 備註 */
sfga011       varchar2(10)      ,/* 生產計劃 */
sfga012       varchar2(40)      ,/* 生產料號 */
sfga013       varchar2(30)      ,/* BOM特性 */
sfga014       varchar2(30)      ,/* 產品特性 */
sfgaownid       varchar2(20)      ,/* 資料所有者 */
sfgaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfgacrtid       varchar2(20)      ,/* 資料建立者 */
sfgacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfgacrtdt       timestamp(0)      ,/* 資料創建日 */
sfgamodid       varchar2(20)      ,/* 資料修改者 */
sfgamoddt       timestamp(0)      ,/* 最近修改日 */
sfgacnfid       varchar2(20)      ,/* 資料確認者 */
sfgacnfdt       timestamp(0)      ,/* 資料確認日 */
sfgapstid       varchar2(20)      ,/* 資料過帳者 */
sfgapstdt       timestamp(0)      ,/* 資料過帳日 */
sfgastus       varchar2(10)      ,/* 狀態碼 */
sfgaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfgaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfgaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfgaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfgaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfgaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfgaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfgaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfgaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfgaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfgaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfgaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfgaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfgaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfgaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfgaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfgaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfgaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfgaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfgaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfgaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfgaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfgaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfgaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfgaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfgaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfgaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfgaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfgaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfgaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfga_t add constraint sfga_pk primary key (sfgaent,sfgadocno) enable validate;

create unique index sfga_pk on sfga_t (sfgaent,sfgadocno);

grant select on sfga_t to tiptop;
grant update on sfga_t to tiptop;
grant delete on sfga_t to tiptop;
grant insert on sfga_t to tiptop;

exit;
