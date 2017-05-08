/* 
================================================================================
檔案代號:inbc_t
檔案名稱:雜項庫存異動庫儲批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbc_t
(
inbcent       number(5)      ,/* 企業編號 */
inbcsite       varchar2(10)      ,/* 營運據點 */
inbcdocno       varchar2(20)      ,/* 單據編號 */
inbcseq       number(10,0)      ,/* 項次 */
inbcseq1       number(10,0)      ,/* 項序 */
inbc001       varchar2(40)      ,/* 料件編號 */
inbc002       varchar2(256)      ,/* 產品特徵 */
inbc003       varchar2(30)      ,/* 庫存管理特徵 */
inbc004       varchar2(40)      ,/* 包裝容器編號 */
inbc005       varchar2(10)      ,/* 庫位 */
inbc006       varchar2(10)      ,/* 儲位 */
inbc007       varchar2(30)      ,/* 批號 */
inbc009       varchar2(10)      ,/* 交易單位 */
inbc010       number(20,6)      ,/* 數量 */
inbc011       varchar2(10)      ,/* 參考單位 */
inbc015       number(20,6)      ,/* 參考數量 */
inbc016       date      ,/* 有效日期 */
inbc017       varchar2(255)      ,/* 存貨備註 */
inbc018       varchar2(20)      ,/* QC單號 */
inbc019       number(10,0)      ,/* QC判定項次 */
inbc020       varchar2(10)      ,/* 判定結果 */
inbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inbc200       varchar2(40)      ,/* 商品條碼 */
inbc201       varchar2(10)      ,/* 包裝單位 */
inbc202       number(20,6)      ,/* 包裝數量 */
inbcunit       varchar2(10)      ,/* 應用組織 */
inbc203       date      ,/* 製造日期 */
inbc021       varchar2(20)      ,/* 專案編號 */
inbc022       varchar2(30)      ,/* WBS */
inbc023       varchar2(30)      ,/* 活動編號 */
inbc204       number(20,6)      ,/* 領用/退回單價 */
inbc205       number(20,6)      ,/* 領用/退回金額 */
inbc206       number(20,6)      ,/* 成本單價 */
inbc207       number(20,6)      ,/* 成本金額 */
inbc208       varchar2(10)      ,/* 費用編號 */
inbc209       number(10,0)      ,/* 來源單據項次 */
inbc210       number(10,0)      ,/* 來源單據項序 */
inbc211       varchar2(10)      ,/* 計價單位 */
inbc212       number(20,6)      /* 計價數量 */
);
alter table inbc_t add constraint inbc_pk primary key (inbcent,inbcdocno,inbcseq,inbcseq1) enable validate;

create unique index inbc_pk on inbc_t (inbcent,inbcdocno,inbcseq,inbcseq1);

grant select on inbc_t to tiptop;
grant update on inbc_t to tiptop;
grant delete on inbc_t to tiptop;
grant insert on inbc_t to tiptop;

exit;
