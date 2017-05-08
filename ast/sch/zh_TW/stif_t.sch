/* 
================================================================================
檔案代號:stif_t
檔案名稱:招商租賃合約申請費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stif_t
(
stifent       number(5)      ,/* 企業編號 */
stifsite       varchar2(10)      ,/* 營運組織 */
stifunit       varchar2(10)      ,/* 制定組織 */
stifdocno       varchar2(20)      ,/* 單據編號 */
stifseq       number(10,0)      ,/* 項次 */
stif001       varchar2(20)      ,/* 合約編號 */
stif002       varchar2(1)      ,/* 標準否 */
stif003       varchar2(20)      ,/* 費用方案 */
stif004       varchar2(10)      ,/* 費用編號 */
stif005       date      ,/* 開始日期 */
stif006       date      ,/* 結束日期 */
stif007       varchar2(10)      ,/* 費用計算週期 */
stif008       number(10,0)      ,/* 週期數值 */
stif009       varchar2(10)      ,/* 計算類型 */
stif010       varchar2(10)      ,/* 計算基準 */
stif011       number(20,6)      ,/* 固定/單位金額 */
stif012       number(20,6)      ,/* 比例 */
stif013       varchar2(10)      ,/* 保底否 */
stif014       number(20,6)      ,/* 保底金額 */
stif015       number(20,6)      ,/* 保底扣點 */
stif016       varchar2(10)      ,/* 分量扣點 */
stif017       number(20,6)      ,/* 費用總金額 */
stifud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stifud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stifud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stifud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stifud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stifud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stifud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stifud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stifud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stifud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stifud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stifud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stifud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stifud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stifud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stifud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stifud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stifud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stifud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stifud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stifud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stifud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stifud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stifud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stifud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stifud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stifud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stifud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stifud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stifud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stif018       number(20,6)      ,/* 確認金額 */
stif019       number(20,6)      ,/* 確認比例 */
stif020       varchar2(1)      ,/* 可延用 */
stif021       varchar2(10)      ,/* 費用方案版本 */
stif022       varchar2(20)      ,/* 場地編號 */
stif023       varchar2(10)      ,/* 費用歸屬類型 */
stif024       varchar2(10)      ,/* 費用歸屬組織 */
stif025       varchar2(10)      /* 合約版本 */
);
alter table stif_t add constraint stif_pk primary key (stifent,stifdocno,stifseq) enable validate;

create unique index stif_pk on stif_t (stifent,stifdocno,stifseq);

grant select on stif_t to tiptop;
grant update on stif_t to tiptop;
grant delete on stif_t to tiptop;
grant insert on stif_t to tiptop;

exit;
