/* 
================================================================================
檔案代號:stcz_t
檔案名稱:市場推廣申請物料明細資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcz_t
(
stczent       number(5)      ,/* 企業編號 */
stczunit       varchar2(10)      ,/* 應用組織 */
stczsite       varchar2(10)      ,/* 營運據點 */
stczdocno       varchar2(20)      ,/* 單據編號 */
stczseq       number(10,0)      ,/* 項次 */
stcz001       varchar2(10)      ,/* 對象類型 */
stcz002       varchar2(10)      ,/* 經銷商 */
stcz003       varchar2(10)      ,/* 網點編號 */
stcz004       varchar2(40)      ,/* 商品編號 */
stcz005       varchar2(40)      ,/* 商品條碼 */
stcz006       varchar2(256)      ,/* 商品特征 */
stcz007       varchar2(10)      ,/* 單位編號 */
stcz008       number(20,6)      ,/* 數量 */
stcz009       varchar2(80)      ,/* 備註 */
stczud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stczud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stczud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stczud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stczud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stczud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stczud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stczud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stczud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stczud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stczud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stczud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stczud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stczud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stczud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stczud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stczud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stczud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stczud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stczud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stczud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stczud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stczud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stczud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stczud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stczud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stczud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stczud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stczud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stczud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcz_t add constraint stcz_pk primary key (stczent,stczdocno,stczseq) enable validate;

create unique index stcz_pk on stcz_t (stczent,stczdocno,stczseq);

grant select on stcz_t to tiptop;
grant update on stcz_t to tiptop;
grant delete on stcz_t to tiptop;
grant insert on stcz_t to tiptop;

exit;
