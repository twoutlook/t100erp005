/* 
================================================================================
檔案代號:pmdp_t
檔案名稱:採購關聯單據明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdp_t
(
pmdpent       number(5)      ,/* 企業編號 */
pmdpsite       varchar2(10)      ,/* 營運據點 */
pmdpdocno       varchar2(20)      ,/* 採購單號 */
pmdpseq       number(10,0)      ,/* 採購項次 */
pmdpseq1       number(10,0)      ,/* 項序 */
pmdp001       varchar2(40)      ,/* 料件編號 */
pmdp002       varchar2(256)      ,/* 產品特徵 */
pmdp003       varchar2(20)      ,/* 來源單號 */
pmdp004       number(10,0)      ,/* 來源項次 */
pmdp005       number(10,0)      ,/* 來源項序 */
pmdp006       number(10,0)      ,/* 來源分批序 */
pmdp007       varchar2(40)      ,/* 來源料號 */
pmdp008       varchar2(256)      ,/* 來源產品特徵 */
pmdp009       varchar2(10)      ,/* 來源作業編號 */
pmdp010       varchar2(10)      ,/* 來源作業序 */
pmdp011       varchar2(30)      ,/* 來源BOM特性 */
pmdp012       varchar2(10)      ,/* 來源生產控制組 */
pmdp021       number(10,0)      ,/* 沖銷順序 */
pmdp022       varchar2(10)      ,/* 需求單位 */
pmdp023       number(20,6)      ,/* 需求數量 */
pmdp024       number(20,6)      ,/* 折合採購量 */
pmdp025       number(20,6)      ,/* 已收貨量 */
pmdp026       number(20,6)      ,/* 已入庫量 */
pmdp900       number(20,6)      ,/* 保留欄位str */
pmdp999       number(20,6)      ,/* 保留欄位end */
pmdpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdp_t add constraint pmdp_pk primary key (pmdpent,pmdpdocno,pmdpseq,pmdpseq1) enable validate;

create unique index pmdp_pk on pmdp_t (pmdpent,pmdpdocno,pmdpseq,pmdpseq1);

grant select on pmdp_t to tiptop;
grant update on pmdp_t to tiptop;
grant delete on pmdp_t to tiptop;
grant insert on pmdp_t to tiptop;

exit;
