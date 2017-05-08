/* 
================================================================================
檔案代號:srbc_t
檔案名稱:重複性生產期末盤點分攤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srbc_t
(
srbcent       number(5)      ,/* 企業編號 */
srbcsite       varchar2(10)      ,/* 營運據點 */
srbcdocno       varchar2(20)      ,/* 盤點單號 */
srbcseq       number(10,0)      ,/* 項次 */
srbcseq1       number(10,0)      ,/* 項序 */
srbc001       varchar2(40)      ,/* 生產料號 */
srbc002       varchar2(30)      ,/* BOM特性 */
srbc003       varchar2(256)      ,/* 產品特徵 */
srbc004       number(20,6)      ,/* 分攤數量 */
srbc005       number(20,6)      ,/* 分攤參考數量 */
srbc006       varchar2(20)      ,/* 領退料單號 */
srbc007       number(20,6)      ,/* 分攤基數 */
srbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srbc_t add constraint srbc_pk primary key (srbcent,srbcdocno,srbcseq,srbcseq1) enable validate;

create unique index srbc_pk on srbc_t (srbcent,srbcdocno,srbcseq,srbcseq1);

grant select on srbc_t to tiptop;
grant update on srbc_t to tiptop;
grant delete on srbc_t to tiptop;
grant insert on srbc_t to tiptop;

exit;
