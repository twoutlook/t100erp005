/* 
================================================================================
檔案代號:fmcr_t
檔案名稱:融資資金到帳單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmcr_t
(
fmcrent       number(5)      ,/* 企業編號 */
fmcrdocno       varchar2(20)      ,/* 融資資金到帳單編號 */
fmcrsite       varchar2(10)      ,/* 融資組織 */
fmcrdocdt       date      ,/* 到帳日期 */
fmcrcomp       varchar2(10)      ,/* 法人 */
fmcrownid       varchar2(20)      ,/* 資料所屬者 */
fmcrowndp       varchar2(10)      ,/* 資料所屬部門 */
fmcrcrtid       varchar2(20)      ,/* 資料建立者 */
fmcrcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmcrcrtdt       timestamp(0)      ,/* 資料創建日 */
fmcrmodid       varchar2(20)      ,/* 資料修改者 */
fmcrmoddt       timestamp(0)      ,/* 最近修改日 */
fmcrstus       varchar2(10)      ,/* 狀態碼 */
fmcrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcrud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmcrcnfid       varchar2(20)      ,/* 資料確認者 */
fmcrcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table fmcr_t add constraint fmcr_pk primary key (fmcrent,fmcrdocno) enable validate;

create unique index fmcr_pk on fmcr_t (fmcrent,fmcrdocno);

grant select on fmcr_t to tiptop;
grant update on fmcr_t to tiptop;
grant delete on fmcr_t to tiptop;
grant insert on fmcr_t to tiptop;

exit;
