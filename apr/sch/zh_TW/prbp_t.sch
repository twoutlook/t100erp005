/* 
================================================================================
檔案代號:prbp_t
檔案名稱:門店商品捆綁單明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbp_t
(
prbpent       number(5)      ,/* 企業編號 */
prbpunit       varchar2(10)      ,/* 應用組織 */
prbpsite       varchar2(10)      ,/* 營運據點 */
prbpdocno       varchar2(20)      ,/* 單據編號 */
prbpseq       number(10,0)      ,/* 項次 */
prbp001       varchar2(40)      ,/* 商品編號 */
prbp002       varchar2(40)      ,/* 商品條碼 */
prbp003       varchar2(256)      ,/* 商品特征 */
prbp004       varchar2(10)      ,/* 計價單位 */
prbp005       number(20,6)      ,/* 數量 */
prbp006       number(20,6)      ,/* 進價 */
prbp007       number(20,6)      ,/* 售價 */
prbp008       number(20,6)      ,/* 折價額 */
prbp009       number(20,6)      ,/* 折扣率 */
prbp010       number(20,6)      ,/* 毛利率 */
prbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbp_t add constraint prbp_pk primary key (prbpent,prbpdocno,prbpseq) enable validate;

create unique index prbp_pk on prbp_t (prbpent,prbpdocno,prbpseq);

grant select on prbp_t to tiptop;
grant update on prbp_t to tiptop;
grant delete on prbp_t to tiptop;
grant insert on prbp_t to tiptop;

exit;
