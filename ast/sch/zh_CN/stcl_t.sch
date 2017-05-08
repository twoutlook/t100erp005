/* 
================================================================================
檔案代號:stcl_t
檔案名稱:分銷合約現返條件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcl_t
(
stclent       number(5)      ,/* 企業編號 */
stclsite       varchar2(10)      ,/* 營運組織 */
stclunit       varchar2(10)      ,/* 制定組織 */
stclseq       number(10,0)      ,/* 項次 */
stcl001       varchar2(20)      ,/* 合約編號 */
stcl002       varchar2(10)      ,/* 摘要編號 */
stcl003       varchar2(40)      ,/* 商品編號 */
stcl004       varchar2(10)      ,/* 現返類型 */
stcl005       varchar2(10)      ,/* 條件期間 */
stcl006       date      ,/* 起始日期 */
stcl007       date      ,/* 截止日期 */
stcl008       number(20,6)      ,/* 起始金額 */
stcl009       number(20,6)      ,/* 截止金額 */
stcl010       varchar2(10)      ,/* 計算基準 */
stcl011       varchar2(10)      ,/* 折扣方式 */
stcl012       number(20,6)      ,/* 折扣比率 */
stcl013       number(20,6)      ,/* 固定金額 */
stcl014       varchar2(10)      ,/* 理由碼 */
stclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcl_t add constraint stcl_pk primary key (stclent,stclseq,stcl001) enable validate;

create unique index stcl_pk on stcl_t (stclent,stclseq,stcl001);

grant select on stcl_t to tiptop;
grant update on stcl_t to tiptop;
grant delete on stcl_t to tiptop;
grant insert on stcl_t to tiptop;

exit;
