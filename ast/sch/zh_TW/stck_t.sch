/* 
================================================================================
檔案代號:stck_t
檔案名稱:分銷合約申請現返條件設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stck_t
(
stckent       number(5)      ,/* 企業編號 */
stcksite       varchar2(10)      ,/* 營運組織 */
stckunit       varchar2(10)      ,/* 制定組織 */
stckdocno       varchar2(20)      ,/* 單據編號 */
stckseq       number(10,0)      ,/* 項次 */
stck001       varchar2(20)      ,/* 合約編號 */
stck002       varchar2(10)      ,/* 摘要編號 */
stck003       varchar2(40)      ,/* 商品編號 */
stck004       varchar2(10)      ,/* 現返類型 */
stck005       varchar2(10)      ,/* 條件期間 */
stck006       date      ,/* 起始日期 */
stck007       date      ,/* 截止日期 */
stck008       number(20,6)      ,/* 起始金額 */
stck009       number(20,6)      ,/* 截止金額 */
stck010       varchar2(10)      ,/* 計算基準 */
stck011       varchar2(10)      ,/* 折扣方式 */
stck012       number(20,6)      ,/* 折扣比率 */
stck013       number(20,6)      ,/* 固定金額 */
stck014       varchar2(10)      ,/* 理由碼 */
stckud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stckud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stckud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stckud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stckud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stckud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stckud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stckud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stckud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stckud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stckud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stckud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stckud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stckud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stckud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stckud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stckud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stckud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stckud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stckud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stckud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stckud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stckud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stckud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stckud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stckud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stckud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stckud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stckud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stckud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stck_t add constraint stck_pk primary key (stckent,stckdocno,stckseq) enable validate;

create unique index stck_pk on stck_t (stckent,stckdocno,stckseq);

grant select on stck_t to tiptop;
grant update on stck_t to tiptop;
grant delete on stck_t to tiptop;
grant insert on stck_t to tiptop;

exit;
