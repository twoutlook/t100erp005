/* 
================================================================================
檔案代號:rtdf_t
檔案名稱:商品生命週期調整明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdf_t
(
rtdfent       number(5)      ,/* 企業編號 */
rtdfsite       varchar2(10)      ,/* 營運據點 */
rtdfunit       varchar2(10)      ,/* 應用組織 */
rtdfdocno       varchar2(20)      ,/* 單據編號 */
rtdfseq       number(10,0)      ,/* 項次 */
rtdf001       varchar2(40)      ,/* 商品編碼 */
rtdf002       varchar2(40)      ,/* 商品條碼 */
rtdf003       varchar2(256)      ,/* 商品特征 */
rtdf004       varchar2(10)      ,/* 原生命周期 */
rtdf005       varchar2(10)      ,/* 新生命週期 */
rtdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdf_t add constraint rtdf_pk primary key (rtdfent,rtdfdocno,rtdfseq) enable validate;

create unique index rtdf_pk on rtdf_t (rtdfent,rtdfdocno,rtdfseq);

grant select on rtdf_t to tiptop;
grant update on rtdf_t to tiptop;
grant delete on rtdf_t to tiptop;
grant insert on rtdf_t to tiptop;

exit;
