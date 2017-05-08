/* 
================================================================================
檔案代號:rtbe_t
檔案名稱:商品轉類單單身明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtbe_t
(
rtbeent       number(5)      ,/* 企業代碼 */
rtbesite       varchar2(10)      ,/* 營運據點 */
rtbedocno       varchar2(20)      ,/* 單據編號 */
rtbeseq       number(10,0)      ,/* 項次 */
rtbe001       varchar2(40)      ,/* 商品主條碼 */
rtbe002       varchar2(40)      ,/* 商品編號 */
rtbe003       varchar2(10)      ,/* 銷售單位 */
rtbe004       varchar2(10)      ,/* 供應商編號 */
rtbe005       number(20,6)      ,/* 數量 */
rtbe006       number(20,6)      ,/* 轉類發生金額 */
rtbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtbe_t add constraint rtbe_pk primary key (rtbeent,rtbedocno,rtbeseq) enable validate;

create unique index rtbe_pk on rtbe_t (rtbeent,rtbedocno,rtbeseq);

grant select on rtbe_t to tiptop;
grant update on rtbe_t to tiptop;
grant delete on rtbe_t to tiptop;
grant insert on rtbe_t to tiptop;

exit;
