/* 
================================================================================
檔案代號:gcam_t
檔案名稱:券狀態異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcam_t
(
gcament       number(5)      ,/* 企業編號 */
gcamsite       varchar2(10)      ,/* 營運據點 */
gcamunit       varchar2(10)      ,/* 應用組織 */
gcamdocno       varchar2(20)      ,/* 單號 */
gcamdocdt       date      ,/* 單據日期 */
gcam000       varchar2(10)      ,/* 異動類別 */
gcam001       varchar2(10)      ,/* 異動來源 */
gcam002       varchar2(10)      ,/* 理由碼 */
gcamownid       varchar2(20)      ,/* 資料所有者 */
gcamowndp       varchar2(10)      ,/* 資料所屬部門 */
gcamcrtid       varchar2(20)      ,/* 資料建立者 */
gcamcrtdp       varchar2(10)      ,/* 資料建立部門 */
gcamcrtdt       timestamp(0)      ,/* 資料創建日 */
gcammodid       varchar2(20)      ,/* 資料修改者 */
gcammoddt       timestamp(0)      ,/* 最近修改日 */
gcamstus       varchar2(10)      ,/* 狀態碼 */
gcamcnfid       varchar2(20)      ,/* 資料確認者 */
gcamcnfdt       timestamp(0)      ,/* 資料確認日 */
gcamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcam_t add constraint gcam_pk primary key (gcament,gcamdocno) enable validate;

create unique index gcam_pk on gcam_t (gcament,gcamdocno);

grant select on gcam_t to tiptop;
grant update on gcam_t to tiptop;
grant delete on gcam_t to tiptop;
grant insert on gcam_t to tiptop;

exit;
