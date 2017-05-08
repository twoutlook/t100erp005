/* 
================================================================================
檔案代號:xmie_t
檔案名稱:集團銷售預測分配比率設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmie_t
(
xmieent       number(5)      ,/* 企業編號 */
xmie001       varchar2(10)      ,/* 預測編號 */
xmieseq       number(10,0)      ,/* 項次 */
xmie002       varchar2(10)      ,/* 產品分類 */
xmie003       varchar2(40)      ,/* 預測料號 */
xmie004       varchar2(10)      ,/* 銷售組織 */
xmie005       varchar2(10)      ,/* 客戶 */
xmie006       varchar2(10)      ,/* 通路 */
xmie007       varchar2(20)      ,/* 業務員 */
xmie008       varchar2(10)      ,/* 營運據點 */
xmieud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmieud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmieud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmieud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmieud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmieud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmieud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmieud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmieud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmieud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmieud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmieud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmieud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmieud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmieud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmieud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmieud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmieud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmieud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmieud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmieud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmieud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmieud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmieud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmieud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmieud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmieud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmieud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmieud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmieud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmie_t add constraint xmie_pk primary key (xmieent,xmie001,xmieseq) enable validate;

create unique index xmie_pk on xmie_t (xmieent,xmie001,xmieseq);

grant select on xmie_t to tiptop;
grant update on xmie_t to tiptop;
grant delete on xmie_t to tiptop;
grant insert on xmie_t to tiptop;

exit;
