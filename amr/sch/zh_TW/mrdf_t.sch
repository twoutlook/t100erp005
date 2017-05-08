/* 
================================================================================
檔案代號:mrdf_t
檔案名稱:資源歸還單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mrdf_t
(
mrdfent       number(5)      ,/* 企業編號 */
mrdfsite       varchar2(10)      ,/* 營運據點 */
mrdfdocno       varchar2(20)      ,/* 資源歸還單號 */
mrdfdocdt       date      ,/* 歸還日期 */
mrdf001       varchar2(10)      ,/* 性質 */
mrdf002       varchar2(20)      ,/* 歸還人員 */
mrdf003       varchar2(10)      ,/* 歸還部門 */
mrdf004       varchar2(10)      ,/* 使用對象類型 */
mrdf005       varchar2(10)      ,/* 使用對象 */
mrdf006       varchar2(255)      ,/* 備註 */
mrdfownid       varchar2(20)      ,/* 資料所有者 */
mrdfowndp       varchar2(10)      ,/* 資料所屬部門 */
mrdfcrtid       varchar2(20)      ,/* 資料建立者 */
mrdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
mrdfcrtdt       timestamp(0)      ,/* 資料創建日 */
mrdfmodid       varchar2(20)      ,/* 資料修改者 */
mrdfmoddt       timestamp(0)      ,/* 最近修改日 */
mrdfcnfid       varchar2(20)      ,/* 資料確認者 */
mrdfcnfdt       timestamp(0)      ,/* 資料確認日 */
mrdfpstid       varchar2(20)      ,/* 資料過帳者 */
mrdfpstdt       timestamp(0)      ,/* 資料過帳日 */
mrdfstus       varchar2(10)      ,/* 狀態碼 */
mrdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdf_t add constraint mrdf_pk primary key (mrdfent,mrdfdocno) enable validate;

create unique index mrdf_pk on mrdf_t (mrdfent,mrdfdocno);

grant select on mrdf_t to tiptop;
grant update on mrdf_t to tiptop;
grant delete on mrdf_t to tiptop;
grant insert on mrdf_t to tiptop;

exit;
