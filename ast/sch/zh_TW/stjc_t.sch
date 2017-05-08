/* 
================================================================================
檔案代號:stjc_t
檔案名稱:招商租賃合約終止申請商戶退場條款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjc_t
(
stjcent       number(5)      ,/* 企業編號 */
stjcsite       varchar2(10)      ,/* 營運組織 */
stjcunit       varchar2(10)      ,/* 制定組織 */
stjcdocno       varchar2(20)      ,/* 單據編號 */
stjcseq       number(10,0)      ,/* 項次 */
stjc001       varchar2(20)      ,/* 合約編號 */
stjc002       varchar2(10)      ,/* 費用編號 */
stjc003       varchar2(20)      ,/* 標準/優惠方案 */
stjc004       varchar2(10)      ,/* 數據類型 */
stjc005       varchar2(1)      ,/* 費用退/優惠不回收 */
stjcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stjcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stjcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stjcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stjcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stjcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stjcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stjcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stjcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stjcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stjcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stjcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stjcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stjcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stjcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stjcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stjcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stjcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stjcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stjcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stjcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stjcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stjcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stjcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stjcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stjcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stjcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stjcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stjcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stjcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stjc006       varchar2(1)      /* 已產生的費用單是否退 */
);
alter table stjc_t add constraint stjc_pk primary key (stjcent,stjcdocno,stjcseq) enable validate;

create unique index stjc_pk on stjc_t (stjcent,stjcdocno,stjcseq);

grant select on stjc_t to tiptop;
grant update on stjc_t to tiptop;
grant delete on stjc_t to tiptop;
grant insert on stjc_t to tiptop;

exit;
