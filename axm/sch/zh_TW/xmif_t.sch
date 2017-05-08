/* 
================================================================================
檔案代號:xmif_t
檔案名稱:集團銷售預測分配比率設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmif_t
(
xmifent       number(5)      ,/* 企業編號 */
xmif001       varchar2(10)      ,/* 預測編號 */
xmifseq       number(10,0)      ,/* 項次 */
xmif002       varchar2(10)      ,/* 產品分類 */
xmif003       varchar2(40)      ,/* 預測料號 */
xmif004       varchar2(10)      ,/* 銷售組織 */
xmif005       varchar2(10)      ,/* 客戶 */
xmif006       varchar2(10)      ,/* 通路 */
xmif007       varchar2(20)      ,/* 業務員 */
xmif008       varchar2(10)      ,/* 預測營運據點 */
xmif009       varchar2(10)      ,/* 營運據點 */
xmif010       number(20,6)      ,/* 分配比率 */
xmif011       varchar2(1)      ,/* 主要生產據點 */
xmif012       number(20,6)      ,/* 最小分配量 */
xmif013       number(20,6)      ,/* 分配批量 */
xmif014       varchar2(1)      ,/* 自動展開計畫性下階料 */
xmifud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmifud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmifud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmifud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmifud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmifud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmifud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmifud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmifud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmifud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmifud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmifud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmifud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmifud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmifud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmifud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmifud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmifud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmifud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmifud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmifud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmifud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmifud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmifud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmifud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmifud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmifud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmifud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmifud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmifud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmif_t add constraint xmif_pk primary key (xmifent,xmif001,xmifseq,xmif009) enable validate;

create unique index xmif_pk on xmif_t (xmifent,xmif001,xmifseq,xmif009);

grant select on xmif_t to tiptop;
grant update on xmif_t to tiptop;
grant delete on xmif_t to tiptop;
grant insert on xmif_t to tiptop;

exit;
