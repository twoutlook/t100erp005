/* 
================================================================================
檔案代號:inao_t
檔案名稱:製造批序號庫存異動明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inao_t
(
inaoent       number(5)      ,/* 企業編號 */
inaosite       varchar2(10)      ,/* 營運據點 */
inaodocno       varchar2(20)      ,/* 單號 */
inaoseq       number(10,0)      ,/* 項次 */
inaoseq1       number(10,0)      ,/* 項序 */
inaoseq2       number(10,0)      ,/* 序號 */
inao000       varchar2(1)      ,/* 資料類型 */
inao001       varchar2(40)      ,/* 料件編號 */
inao002       varchar2(256)      ,/* 產品特徵 */
inao003       varchar2(30)      ,/* 庫存管理特徵 */
inao004       varchar2(40)      ,/* 包裝容器編號 */
inao005       varchar2(10)      ,/* 庫位 */
inao006       varchar2(10)      ,/* 儲位 */
inao007       varchar2(30)      ,/* 批號 */
inao008       varchar2(30)      ,/* 製造批號 */
inao009       varchar2(30)      ,/* 製造序號 */
inao010       date      ,/* 製造日期 */
inao011       date      ,/* 有效日期 */
inao012       number(20,6)      ,/* 數量 */
inao013       number(5,0)      ,/* 出入庫碼 */
inaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inaoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inao014       varchar2(10)      ,/* 庫存單位 */
inao020       number(20,6)      ,/* 檢驗合格量 */
inao021       number(20,6)      ,/* 已入庫/出貨/簽收量 */
inao022       number(20,6)      ,/* 已驗退/簽退量 */
inao023       number(20,6)      ,/* 已倉退/銷退量 */
inao024       number(20,6)      /* 已轉QC量 */
);
alter table inao_t add constraint inao_pk primary key (inaoent,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao013) enable validate;

create unique index inao_pk on inao_t (inaoent,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao013);

grant select on inao_t to tiptop;
grant update on inao_t to tiptop;
grant delete on inao_t to tiptop;
grant insert on inao_t to tiptop;

exit;
