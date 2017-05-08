/* 
================================================================================
檔案代號:sfja_t
檔案名稱:工單下階料報廢單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfja_t
(
sfjaent       number(5)      ,/* 企業編號 */
sfjasite       varchar2(10)      ,/* 營運據點 */
sfjadocno       varchar2(20)      ,/* 報廢單號 */
sfjadocdt       date      ,/* 單據日期 */
sfja001       varchar2(20)      ,/* 申請人員 */
sfja002       varchar2(10)      ,/* 申請部門 */
sfja003       date      ,/* 過帳日期 */
sfja004       varchar2(20)      ,/* 雜收單號 */
sfja005       varchar2(20)      ,/* 退料單號 */
sfjaownid       varchar2(20)      ,/* 資料所有者 */
sfjaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfjacrtid       varchar2(20)      ,/* 資料建立者 */
sfjacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfjacrtdt       timestamp(0)      ,/* 資料創建日 */
sfjamodid       varchar2(20)      ,/* 資料修改者 */
sfjamoddt       timestamp(0)      ,/* 最近修改日 */
sfjacnfid       varchar2(20)      ,/* 資料確認者 */
sfjacnfdt       timestamp(0)      ,/* 資料確認日 */
sfjapstid       varchar2(20)      ,/* 資料過帳者 */
sfjapstdt       timestamp(0)      ,/* 資料過帳日 */
sfjastus       varchar2(10)      ,/* 狀態碼 */
sfjaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfjaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfjaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfjaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfjaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfjaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfjaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfjaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfjaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfjaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfjaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfjaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfjaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfjaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfjaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfjaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfjaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfjaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfjaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfjaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfjaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfjaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfjaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfjaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfjaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfjaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfjaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfjaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfjaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfjaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfja_t add constraint sfja_pk primary key (sfjaent,sfjadocno) enable validate;

create unique index sfja_pk on sfja_t (sfjaent,sfjadocno);

grant select on sfja_t to tiptop;
grant update on sfja_t to tiptop;
grant delete on sfja_t to tiptop;
grant insert on sfja_t to tiptop;

exit;
