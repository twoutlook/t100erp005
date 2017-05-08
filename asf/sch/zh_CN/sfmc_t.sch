/* 
================================================================================
檔案代號:sfmc_t
檔案名稱:耗料盤存分攤單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfmc_t
(
sfmcent       number(5)      ,/* 企業編號 */
sfmcsite       varchar2(10)      ,/* 營運據點 */
sfmcdocno       varchar2(20)      ,/* 盤點單號 */
sfmcseq       number(10,0)      ,/* 項次 */
sfmcseq1       number(10,0)      ,/* 項序 */
sfmc001       varchar2(20)      ,/* 工單單號 */
sfmc002       varchar2(40)      ,/* 生產料號 */
sfmc003       number(10,0)      ,/* 工單項次 */
sfmc004       number(10,0)      ,/* 工單項序 */
sfmc005       number(20,6)      ,/* 分攤基數 */
sfmc006       number(20,6)      ,/* 分攤數量 */
sfmc007       number(20,6)      ,/* 分攤參考數量 */
sfmc008       varchar2(20)      ,/* 領退料單號 */
sfmcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfmcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfmcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfmcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfmcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfmcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfmcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfmcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfmcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfmcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfmcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfmcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfmcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfmcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfmcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfmcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfmcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfmcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfmcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfmcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfmcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfmcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfmcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfmcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfmcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfmcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfmcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfmcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfmcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfmcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfmc_t add constraint sfmc_pk primary key (sfmcent,sfmcdocno,sfmcseq,sfmcseq1) enable validate;

create unique index sfmc_pk on sfmc_t (sfmcent,sfmcdocno,sfmcseq,sfmcseq1);

grant select on sfmc_t to tiptop;
grant update on sfmc_t to tiptop;
grant delete on sfmc_t to tiptop;
grant insert on sfmc_t to tiptop;

exit;
