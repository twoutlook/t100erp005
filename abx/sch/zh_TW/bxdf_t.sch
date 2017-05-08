/* 
================================================================================
檔案代號:bxdf_t
檔案名稱:保稅機器設備盤點底稿單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bxdf_t
(
bxdfent       number(5)      ,/* 企業編號 */
bxdfsite       varchar2(10)      ,/* 營運據點 */
bxdfdocno       varchar2(20)      ,/* 盤點單號 */
bxdfdocdt       date      ,/* 盤點日期 */
bxdf001       number(5,0)      ,/* 盤點年度 */
bxdf002       varchar2(20)      ,/* 盤點人員 */
bxdf003       varchar2(10)      ,/* 盤點部門 */
bxdf010       varchar2(255)      ,/* 備註 */
bxdfownid       varchar2(20)      ,/* 資料所有者 */
bxdfowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdfcrtid       varchar2(20)      ,/* 資料建立者 */
bxdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdfcrtdt       timestamp(0)      ,/* 資料創建日 */
bxdfmodid       varchar2(20)      ,/* 資料修改者 */
bxdfmoddt       timestamp(0)      ,/* 最近修改日 */
bxdfcnfid       varchar2(20)      ,/* 資料確認者 */
bxdfcnfdt       timestamp(0)      ,/* 資料確認日 */
bxdfstus       varchar2(10)      ,/* 狀態碼 */
bxdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdf_t add constraint bxdf_pk primary key (bxdfent,bxdfdocno) enable validate;

create unique index bxdf_pk on bxdf_t (bxdfent,bxdfdocno);

grant select on bxdf_t to tiptop;
grant update on bxdf_t to tiptop;
grant delete on bxdf_t to tiptop;
grant insert on bxdf_t to tiptop;

exit;
