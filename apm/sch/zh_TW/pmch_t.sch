/* 
================================================================================
檔案代號:pmch_t
檔案名稱:供應商評核定性評分單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmch_t
(
pmchent       number(5)      ,/* 企業編號 */
pmchdocno       varchar2(20)      ,/* 單據編號 */
pmchdocdt       date      ,/* 單據日期 */
pmch001       varchar2(10)      ,/* 評核期別 */
pmch002       varchar2(10)      ,/* 評核品類 */
pmch003       varchar2(10)      ,/* 評分部門 */
pmch004       varchar2(20)      ,/* 評分人員 */
pmchstus       varchar2(10)      ,/* 狀態碼 */
pmchownid       varchar2(20)      ,/* 資料所有者 */
pmchowndp       varchar2(10)      ,/* 資料所屬部門 */
pmchcrtid       varchar2(20)      ,/* 資料建立者 */
pmchcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmchcrtdt       timestamp(0)      ,/* 資料創建日 */
pmchmodid       varchar2(20)      ,/* 資料修改者 */
pmchmoddt       timestamp(0)      ,/* 最近修改日 */
pmchcnfid       varchar2(20)      ,/* 資料確認者 */
pmchcnfdt       timestamp(0)      ,/* 資料確認日 */
pmchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmch_t add constraint pmch_pk primary key (pmchent,pmchdocno) enable validate;

create unique index pmch_pk on pmch_t (pmchent,pmchdocno);

grant select on pmch_t to tiptop;
grant update on pmch_t to tiptop;
grant delete on pmch_t to tiptop;
grant insert on pmch_t to tiptop;

exit;
