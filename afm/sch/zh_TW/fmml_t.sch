/* 
================================================================================
檔案代號:fmml_t
檔案名稱:投資購買帳務單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmml_t
(
fmmlent       number(5)      ,/* 企業編號 */
fmml001       varchar2(10)      ,/* 帳務中心 */
fmmldocno       varchar2(20)      ,/* 投資購買帳務單號 */
fmml003       varchar2(5)      ,/* 帳套 */
fmml004       varchar2(10)      ,/* 歸屬法人組織 */
fmml005       number(5,0)      ,/* 年度 */
fmml006       number(5,0)      ,/* 期別 */
fmml007       varchar2(20)      ,/* 傳票編號 */
fmmldocdt       date      ,/* 單據日期 */
fmmlownid       varchar2(20)      ,/* 資料所有者 */
fmmlowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmlcrtid       varchar2(20)      ,/* 資料建立者 */
fmmlcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmlcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmlmodid       varchar2(20)      ,/* 資料修改者 */
fmmlmoddt       timestamp(0)      ,/* 最近修改日 */
fmmlcnfid       varchar2(20)      ,/* 資料確認者 */
fmmlcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmlpstid       varchar2(20)      ,/* 資料過帳者 */
fmmlpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmlstus       varchar2(10)      ,/* 狀態碼 */
fmmlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmml_t add constraint fmml_pk primary key (fmmlent,fmmldocno) enable validate;

create unique index fmml_pk on fmml_t (fmmlent,fmmldocno);

grant select on fmml_t to tiptop;
grant update on fmml_t to tiptop;
grant delete on fmml_t to tiptop;
grant insert on fmml_t to tiptop;

exit;
