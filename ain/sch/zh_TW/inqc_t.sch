/* 
================================================================================
檔案代號:inqc_t
檔案名稱:產品組合拆解單產品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inqc_t
(
inqcent       number(5)      ,/* 企業編號 */
inqcsite       varchar2(10)      ,/* 營運據點 */
inqcunit       varchar2(10)      ,/* 應用組織 */
inqcdocno       varchar2(20)      ,/* 單據編號 */
inqcseq       number(10,0)      ,/* 項次 */
inqcseq1       number(10,0)      ,/* 項次1 */
inqc001       varchar2(40)      ,/* 商品主條碼 */
inqc002       varchar2(40)      ,/* 商品編號 */
inqc003       varchar2(256)      ,/* 產品特徵 */
inqc004       varchar2(10)      ,/* 單位 */
inqc005       number(20,6)      ,/* 數量 */
inqc006       varchar2(10)      ,/* 出入庫庫位 */
inqc007       varchar2(10)      ,/* 儲位 */
inqc008       varchar2(30)      ,/* 批號 */
inqc009       varchar2(30)      ,/* 庫存管理特徵 */
inqc010       varchar2(255)      ,/* 備註 */
inqcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inqcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inqcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inqcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inqcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inqcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inqcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inqcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inqcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inqcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inqcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inqcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inqcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inqcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inqcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inqcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inqcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inqcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inqcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inqcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inqcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inqcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inqcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inqcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inqcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inqcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inqcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inqcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inqcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inqcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inqc_t add constraint inqc_pk primary key (inqcent,inqcdocno,inqcseq,inqcseq1) enable validate;

create unique index inqc_pk on inqc_t (inqcent,inqcdocno,inqcseq,inqcseq1);

grant select on inqc_t to tiptop;
grant update on inqc_t to tiptop;
grant delete on inqc_t to tiptop;
grant insert on inqc_t to tiptop;

exit;
