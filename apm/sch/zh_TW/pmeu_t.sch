/* 
================================================================================
檔案代號:pmeu_t
檔案名稱:要貨組織預設要貨資料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmeu_t
(
pmeuent       number(5)      ,/* 企業編號 */
pmeusite       varchar2(10)      ,/* 營運據點 */
pmeuunit       varchar2(10)      ,/* 制定組織 */
pmeuseq       number(10,0)      ,/* 項次 */
pmeu001       varchar2(10)      ,/* 要貨部門 */
pmeu002       varchar2(40)      ,/* 商品條碼 */
pmeu003       varchar2(40)      ,/* 商品編號 */
pmeu004       varchar2(10)      ,/* 要貨包裝單位 */
pmeu005       number(20,6)      ,/* 要貨包裝數量 */
pmeu006       varchar2(10)      ,/* 要貨單位 */
pmeu007       number(20,6)      ,/* 要貨數量 */
pmeustus       varchar2(10)      ,/* 狀態碼 */
pmeuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmeuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmeuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmeuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmeuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmeuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmeuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmeuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmeuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmeuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmeuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmeuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmeuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmeuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmeuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmeuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmeuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmeuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmeuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmeuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmeuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmeuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmeuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmeuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmeuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmeuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmeuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmeuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmeuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmeuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmeu_t add constraint pmeu_pk primary key (pmeuent,pmeusite,pmeuseq,pmeu001) enable validate;

create unique index pmeu_pk on pmeu_t (pmeuent,pmeusite,pmeuseq,pmeu001);

grant select on pmeu_t to tiptop;
grant update on pmeu_t to tiptop;
grant delete on pmeu_t to tiptop;
grant insert on pmeu_t to tiptop;

exit;
