/* 
================================================================================
檔案代號:bmhc_t
檔案名稱:料件承認模板QC規範檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmhc_t
(
bmhcent       number(5)      ,/* 企業編號 */
bmhc001       varchar2(10)      ,/* 模板編號 */
bmhcseq       number(10,0)      ,/* 行序 */
bmhc002       varchar2(10)      ,/* 檢驗項目 */
bmhc003       varchar2(40)      ,/* 檢驗位置 */
bmhc004       varchar2(10)      ,/* 缺點等級 */
bmhc005       varchar2(10)      ,/* 抽樣計畫 */
bmhc006       number(7,3)      ,/* AQL */
bmhc007       varchar2(10)      ,/* 測量值管制方式 */
bmhc008       varchar2(10)      ,/* 檢驗方式 */
bmhc009       number(15,3)      ,/* 規範上限 */
bmhc010       number(15,3)      ,/* 檢驗上限 */
bmhc011       number(15,3)      ,/* 檢驗標準值 */
bmhc012       number(15,3)      ,/* 檢驗下限 */
bmhc013       number(15,3)      ,/* 規範下限 */
bmhc014       varchar2(40)      ,/* 計量單位 */
bmhc015       varchar2(255)      ,/* 檢驗規格說明 */
bmhc016       varchar2(255)      ,/* 備註 */
bmhc017       varchar2(10)      ,/* 檢驗類型 */
bmhcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmhcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmhcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmhcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmhcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmhcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmhcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmhcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmhcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmhcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmhcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmhcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmhcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmhcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmhcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmhcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmhcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmhcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmhcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmhcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmhcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmhcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmhcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmhcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmhcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmhcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmhcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmhcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmhcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmhcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmhc_t add constraint bmhc_pk primary key (bmhcent,bmhc001,bmhcseq,bmhc017) enable validate;

create unique index bmhc_pk on bmhc_t (bmhcent,bmhc001,bmhcseq,bmhc017);

grant select on bmhc_t to tiptop;
grant update on bmhc_t to tiptop;
grant delete on bmhc_t to tiptop;
grant insert on bmhc_t to tiptop;

exit;
