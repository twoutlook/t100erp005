/* 
================================================================================
檔案代號:pjda_t
檔案名稱:項目進度報工單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pjda_t
(
pjdaent       number(5)      ,/* 企業編號 */
pjdasite       varchar2(10)      ,/* 營運據點 */
pjdadocno       varchar2(20)      ,/* 單據單號 */
pjdadocdt       date      ,/* 單據日期 */
pjda001       varchar2(20)      ,/* 報工人員 */
pjda002       varchar2(10)      ,/* 報工部門 */
pjdaownid       varchar2(20)      ,/* 資料所有者 */
pjdaowndp       varchar2(10)      ,/* 資料所屬部門 */
pjdacrtid       varchar2(20)      ,/* 資料建立者 */
pjdacrtdp       varchar2(10)      ,/* 資料建立部門 */
pjdacrtdt       timestamp(0)      ,/* 資料創建日 */
pjdamodid       varchar2(20)      ,/* 資料修改者 */
pjdamoddt       timestamp(0)      ,/* 最近修改日 */
pjdacnfid       varchar2(20)      ,/* 資料確認者 */
pjdacnfdt       timestamp(0)      ,/* 資料確認日 */
pjdapstid       varchar2(20)      ,/* 資料過帳者 */
pjdapstdt       timestamp(0)      ,/* 資料過帳日 */
pjdastus       varchar2(10)      ,/* 狀態碼 */
pjdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjda_t add constraint pjda_pk primary key (pjdaent,pjdadocno) enable validate;

create unique index pjda_pk on pjda_t (pjdaent,pjdadocno);

grant select on pjda_t to tiptop;
grant update on pjda_t to tiptop;
grant delete on pjda_t to tiptop;
grant insert on pjda_t to tiptop;

exit;
