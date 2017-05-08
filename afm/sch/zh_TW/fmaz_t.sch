/* 
================================================================================
檔案代號:fmaz_t
檔案名稱:計提利息檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmaz_t
(
fmazent       number(5)      ,/* 企業編號 */
fmaz001       varchar2(10)      ,/* 融資組織 */
fmaz002       number(5,0)      ,/* 年度 */
fmaz003       number(5,0)      ,/* 期別 */
fmaz004       varchar2(20)      ,/* 融資合同編號 */
fmaz005       varchar2(20)      ,/* 到帳單編號 */
fmaz006       varchar2(10)      ,/* 幣別 */
fmaz007       number(20,6)      ,/* 本金 */
fmaz008       number(20,6)      ,/* 未還利息 */
fmaz009       varchar2(1)      ,/* 利息類別 */
fmaz010       number(20,6)      ,/* 金額 */
fmaz011       number(10,0)      ,/* 融資合同項次 */
fmaz012       varchar2(10)      ,/* 資金中心 */
fmaz013       varchar2(1)      ,/* 資料來源 */
fmazownid       varchar2(20)      ,/* 資料所有者 */
fmazowndp       varchar2(10)      ,/* 資料所有部門 */
fmazcrtid       varchar2(20)      ,/* 資料建立者 */
fmazcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmazcrtdt       timestamp(0)      ,/* 資料創建日 */
fmazmodid       varchar2(20)      ,/* 資料修改者 */
fmazmoddt       timestamp(0)      ,/* 最近修改日 */
fmazcnfid       varchar2(20)      ,/* 資料確認者 */
fmazcnfdt       timestamp(0)      ,/* 資料確認日 */
fmazpstid       varchar2(20)      ,/* 資料過帳者 */
fmazpstdt       timestamp(0)      ,/* 資料過帳日 */
fmazstus       varchar2(10)      ,/* 狀態碼 */
fmaz014       number(10,0)      ,/* 項次 */
fmazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmaz_t add constraint fmaz_pk primary key (fmazent,fmaz002,fmaz003,fmaz014) enable validate;

create unique index fmaz_pk on fmaz_t (fmazent,fmaz002,fmaz003,fmaz014);

grant select on fmaz_t to tiptop;
grant update on fmaz_t to tiptop;
grant delete on fmaz_t to tiptop;
grant insert on fmaz_t to tiptop;

exit;
