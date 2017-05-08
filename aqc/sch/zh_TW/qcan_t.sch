/* 
================================================================================
檔案代號:qcan_t
檔案名稱:品質檢驗項目單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcan_t
(
qcanent       number(5)      ,/* 企業編號 */
qcan001       varchar2(5)      ,/* 參照表號 */
qcan002       varchar2(10)      ,/* 品管分群 */
qcan003       varchar2(40)      ,/* 料件編號 */
qcan004       varchar2(256)      ,/* 產品特徵 */
qcan005       varchar2(10)      ,/* 作業編號 */
qcan006       number(10,0)      ,/* 加工序 */
qcan007       varchar2(10)      ,/* 交易對象編號 */
qcan008       varchar2(10)      ,/* 檢驗類型 */
qcan009       number(10,0)      ,/* 項次 */
qcan010       varchar2(10)      ,/* 檢驗項目 */
qcan011       varchar2(40)      ,/* 檢驗位置 */
qcan012       varchar2(10)      ,/* 缺點等級 */
qcan013       varchar2(10)      ,/* 抽樣計畫 */
qcan014       number(7,3)      ,/* AQL */
qcan015       varchar2(10)      ,/* 測量值管制方式 */
qcan016       varchar2(10)      ,/* 檢驗方式 */
qcan017       varchar2(10)      ,/* 資源類型 */
qcan018       varchar2(10)      ,/* 指定儀器 */
qcan019       number(15,3)      ,/* 規範上限 */
qcan020       number(15,3)      ,/* 檢驗上限 */
qcan021       number(15,3)      ,/* 檢驗標準值 */
qcan022       number(15,3)      ,/* 檢驗下限 */
qcan023       number(15,3)      ,/* 規範下限 */
qcan024       varchar2(40)      ,/* 計量單位 */
qcan025       varchar2(255)      ,/* 檢驗規格說明 */
qcan026       varchar2(255)      ,/* 備註 */
qcanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcan_t add constraint qcan_pk primary key (qcanent,qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,qcan009) enable validate;

create unique index qcan_pk on qcan_t (qcanent,qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,qcan008,qcan009);

grant select on qcan_t to tiptop;
grant update on qcan_t to tiptop;
grant delete on qcan_t to tiptop;
grant insert on qcan_t to tiptop;

exit;
