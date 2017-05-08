/* 
================================================================================
檔案代號:inqb_t
檔案名稱:產品組合拆解單產品主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inqb_t
(
inqbent       number(5)      ,/* 企業編號 */
inqbsite       varchar2(10)      ,/* 營運據點 */
inqbunit       varchar2(10)      ,/* 應用組織 */
inqbdocno       varchar2(20)      ,/* 單據編號 */
inqbseq       number(10,0)      ,/* 項次 */
inqb001       varchar2(40)      ,/* 商品主條碼 */
inqb002       varchar2(40)      ,/* 商品編號 */
inqb003       varchar2(256)      ,/* 產品特徵 */
inqb004       varchar2(10)      ,/* 單位 */
inqb005       number(20,6)      ,/* 數量 */
inqb006       varchar2(10)      ,/* 出入庫庫位 */
inqb007       varchar2(10)      ,/* 儲位 */
inqb008       varchar2(30)      ,/* 批號 */
inqb009       varchar2(30)      ,/* 庫存管理特徵 */
inqb010       varchar2(255)      ,/* 備註 */
inqbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inqbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inqbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inqbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inqbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inqbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inqbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inqbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inqbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inqbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inqbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inqbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inqbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inqbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inqbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inqbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inqbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inqbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inqbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inqbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inqbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inqbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inqbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inqbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inqbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inqbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inqbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inqbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inqbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inqbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inqb_t add constraint inqb_pk primary key (inqbent,inqbdocno,inqbseq) enable validate;

create unique index inqb_pk on inqb_t (inqbent,inqbdocno,inqbseq);

grant select on inqb_t to tiptop;
grant update on inqb_t to tiptop;
grant delete on inqb_t to tiptop;
grant insert on inqb_t to tiptop;

exit;
