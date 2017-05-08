/* 
================================================================================
檔案代號:rmbc_t
檔案名稱:RMA報價单維修物料明細档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmbc_t
(
rmbcent       number(5)      ,/* 企業編號 */
rmbcsite       varchar2(10)      ,/* 營運據點 */
rmbcdocno       varchar2(20)      ,/* 單據單號 */
rmbc000       number(10,0)      ,/* 版本 */
rmbcseq       number(10,0)      ,/* RMA項次 */
rmbcseq1       number(10,0)      ,/* 項序 */
rmbc001       varchar2(40)      ,/* 料號 */
rmbc002       varchar2(256)      ,/* 產品特徵 */
rmbc003       varchar2(10)      ,/* 單位 */
rmbc004       number(20,6)      ,/* 數量 */
rmbc005       number(20,6)      ,/* 材料單價 */
rmbc006       number(20,6)      ,/* 未稅金額 */
rmbc007       number(20,6)      ,/* 含稅金額 */
rmbc008       number(20,6)      ,/* 稅額 */
rmbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rmbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rmbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rmbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rmbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rmbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rmbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rmbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rmbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rmbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rmbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rmbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rmbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rmbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rmbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rmbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rmbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rmbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rmbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rmbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rmbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rmbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rmbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rmbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rmbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rmbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rmbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rmbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rmbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rmbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rmbc_t add constraint rmbc_pk primary key (rmbcent,rmbcdocno,rmbc000,rmbcseq,rmbcseq1) enable validate;

create unique index rmbc_pk on rmbc_t (rmbcent,rmbcdocno,rmbc000,rmbcseq,rmbcseq1);

grant select on rmbc_t to tiptop;
grant update on rmbc_t to tiptop;
grant delete on rmbc_t to tiptop;
grant insert on rmbc_t to tiptop;

exit;
