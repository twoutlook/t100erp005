/* 
================================================================================
檔案代號:stjd_t
檔案名稱:招商租賃合約商戶退場費用金額統計單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjd_t
(
stjdent       number(5)      ,/* 企業編號 */
stjdsite       varchar2(10)      ,/* 營運組織 */
stjdunit       varchar2(10)      ,/* 制定組織 */
stjddocno       varchar2(20)      ,/* 單據編號 */
stjdseq       number(10,0)      ,/* 項次 */
stjd001       varchar2(20)      ,/* 合約編號 */
stjd002       varchar2(10)      ,/* 類型 */
stjd003       varchar2(10)      ,/* 費用編號 */
stjd004       number(20,6)      ,/* 费用金额 */
stjdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stjdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stjdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stjdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stjdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stjdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stjdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stjdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stjdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stjdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stjdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stjdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stjdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stjdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stjdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stjdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stjdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stjdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stjdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stjdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stjdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stjdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stjdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stjdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stjdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stjdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stjdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stjdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stjdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stjdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stjd_t add constraint stjd_pk primary key (stjdent,stjddocno,stjdseq,stjd002) enable validate;

create unique index stjd_pk on stjd_t (stjdent,stjddocno,stjdseq,stjd002);

grant select on stjd_t to tiptop;
grant update on stjd_t to tiptop;
grant delete on stjd_t to tiptop;
grant insert on stjd_t to tiptop;

exit;
