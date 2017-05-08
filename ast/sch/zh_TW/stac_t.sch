/* 
================================================================================
檔案代號:stac_t
檔案名稱:費用編號異動申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stac_t
(
stacent       number(5)      ,/* 企業編號 */
stacdocno       varchar2(20)      ,/* 單據編號 */
stacdocdt       date      ,/* 單據日期 */
stac000       varchar2(1)      ,/* 作業方式 */
stac001       varchar2(20)      ,/* 申請人員 */
stac002       varchar2(10)      ,/* 申請部門 */
stacownid       varchar2(20)      ,/* 資料所有者 */
stacowndp       varchar2(10)      ,/* 資料所屬部門 */
staccrtid       varchar2(20)      ,/* 資料建立者 */
staccrtdp       varchar2(10)      ,/* 資料建立部門 */
staccrtdt       timestamp(0)      ,/* 資料創建日 */
stacmodid       varchar2(20)      ,/* 資料修改者 */
stacmoddt       timestamp(0)      ,/* 最近修改日 */
staccnfid       varchar2(20)      ,/* 資料確認者 */
staccnfdt       timestamp(0)      ,/* 資料確認日 */
stacstus       varchar2(10)      ,/* 狀態碼 */
stacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stacud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stacsite       varchar2(10)      ,/* 營運據點 */
stacunit       varchar2(10)      /* 應用組織 */
);
alter table stac_t add constraint stac_pk primary key (stacent,stacdocno) enable validate;

create unique index stac_pk on stac_t (stacent,stacdocno);

grant select on stac_t to tiptop;
grant update on stac_t to tiptop;
grant delete on stac_t to tiptop;
grant insert on stac_t to tiptop;

exit;
