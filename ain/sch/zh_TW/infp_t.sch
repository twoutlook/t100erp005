/* 
================================================================================
檔案代號:infp_t
檔案名稱:隨貨同行單單身擋-明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infp_t
(
infpent       number(5)      ,/* 企業編號 */
infpsite       varchar2(10)      ,/* 營運據點 */
infpunit       varchar2(10)      ,/* 應用組織 */
infpdocno       varchar2(20)      ,/* 隨貨同行單號 */
infpseq       number(10,0)      ,/* 項次 */
infp001       varchar2(10)      ,/* 來源類型 */
infp002       varchar2(20)      ,/* 來源單號 */
infp003       number(10,0)      ,/* 來源項次 */
infp004       varchar2(40)      ,/* 商品編號 */
infp005       varchar2(40)      ,/* 商品條碼 */
infp006       varchar2(256)      ,/* 產品特徵 */
infp007       varchar2(10)      ,/* 經營方式 */
infp008       varchar2(10)      ,/* 庫存單位 */
infp009       varchar2(10)      ,/* 包裝單位 */
infp010       number(20,6)      ,/* 撥出包裝數量 */
infp011       number(20,6)      ,/* 撥出庫存數量 */
infp012       varchar2(10)      ,/* 撥出庫位 */
infp013       varchar2(10)      ,/* 撥出儲位 */
infp014       varchar2(30)      ,/* 撥出批號 */
infp015       number(20,6)      ,/* 撥入包裝數量 */
infp016       number(20,6)      ,/* 撥入庫存數量 */
infp017       varchar2(10)      ,/* 撥入庫位 */
infp018       varchar2(10)      ,/* 撥入儲位 */
infp019       varchar2(30)      ,/* 撥入批號 */
infpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infp_t add constraint infp_pk primary key (infpent,infpdocno,infpseq) enable validate;

create unique index infp_pk on infp_t (infpent,infpdocno,infpseq);

grant select on infp_t to tiptop;
grant update on infp_t to tiptop;
grant delete on infp_t to tiptop;
grant insert on infp_t to tiptop;

exit;
