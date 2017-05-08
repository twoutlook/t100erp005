/* 
================================================================================
檔案代號:bmid_t
檔案名稱:料件承認申請QC規範檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmid_t
(
bmident       number(5)      ,/* 企業編號 */
bmidsite       varchar2(10)      ,/* 營運據點 */
bmiddocno       varchar2(20)      ,/* 料件承認申請單號 */
bmidseq       number(10,0)      ,/* 行序 */
bmid001       varchar2(10)      ,/* 檢驗項目 */
bmid002       varchar2(40)      ,/* 檢驗位置 */
bmid003       varchar2(10)      ,/* 缺點等級 */
bmid004       varchar2(10)      ,/* 抽樣計畫 */
bmid005       number(7,3)      ,/* AQL */
bmid006       varchar2(10)      ,/* 測量值管制方式 */
bmid007       varchar2(10)      ,/* 檢驗方式 */
bmid008       number(15,3)      ,/* 規範上限 */
bmid009       number(15,3)      ,/* 檢驗上限 */
bmid010       number(15,3)      ,/* 檢驗標準值 */
bmid011       number(15,3)      ,/* 檢驗下限 */
bmid012       number(15,3)      ,/* 規範下限 */
bmid013       varchar2(40)      ,/* 計量單位 */
bmid014       varchar2(255)      ,/* 檢驗規格說明 */
bmid015       varchar2(255)      ,/* 備註 */
bmid016       varchar2(10)      ,/* 檢驗類型 */
bmidud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmidud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmidud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmidud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmidud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmidud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmidud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmidud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmidud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmidud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmidud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmidud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmidud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmidud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmidud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmidud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmidud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmidud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmidud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmidud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmidud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmidud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmidud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmidud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmidud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmidud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmidud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmidud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmidud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmidud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmid_t add constraint bmid_pk primary key (bmident,bmiddocno,bmidseq) enable validate;

create unique index bmid_pk on bmid_t (bmident,bmiddocno,bmidseq);

grant select on bmid_t to tiptop;
grant update on bmid_t to tiptop;
grant delete on bmid_t to tiptop;
grant insert on bmid_t to tiptop;

exit;
