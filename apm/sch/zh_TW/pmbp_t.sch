/* 
================================================================================
檔案代號:pmbp_t
檔案名稱:供應商評核定性評分單頭檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmbp_t
(
pmbpent       number(5)      ,/* 企業編號 */
pmbpsite       varchar2(10)      ,/* 營運據點 */
pmbpdocno       varchar2(20)      ,/* 單據編號 */
pmbpdocdt       date      ,/* 評分日期 */
pmbp001       varchar2(20)      ,/* 評分人員 */
pmbp002       varchar2(10)      ,/* 評分部門 */
pmbp003       varchar2(10)      ,/* 評核公式編號 */
pmbp004       number(5,0)      ,/* 評核年度 */
pmbp005       number(5,0)      ,/* 評核月份 */
pmbp006       varchar2(255)      ,/* 備註 */
pmbpownid       varchar2(20)      ,/* 資料所有者 */
pmbpowndp       varchar2(10)      ,/* 資料所屬部門 */
pmbpcrtid       varchar2(20)      ,/* 資料建立者 */
pmbpcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmbpcrtdt       timestamp(0)      ,/* 資料創建日 */
pmbpmodid       varchar2(20)      ,/* 資料修改者 */
pmbpmoddt       timestamp(0)      ,/* 最近修改日 */
pmbpcnfid       varchar2(20)      ,/* 資料確認者 */
pmbpcnfdt       timestamp(0)      ,/* 資料確認日 */
pmbpstus       varchar2(10)      ,/* 狀態碼 */
pmbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbp_t add constraint pmbp_pk primary key (pmbpent,pmbpdocno) enable validate;

create unique index pmbp_pk on pmbp_t (pmbpent,pmbpdocno);

grant select on pmbp_t to tiptop;
grant update on pmbp_t to tiptop;
grant delete on pmbp_t to tiptop;
grant insert on pmbp_t to tiptop;

exit;
