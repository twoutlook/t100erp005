/* 
================================================================================
檔案代號:qcbc_t
檔案名稱:品質檢驗判定結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbc_t
(
qcbcent       number(5)      ,/* 企業編號 */
qcbcsite       varchar2(10)      ,/* 營運據點 */
qcbcdocno       varchar2(20)      ,/* 單號 */
qcbcseq       number(10,0)      ,/* 行序 */
qcbc001       varchar2(10)      ,/* 類型 */
qcbc002       varchar2(10)      ,/* 判定結果編號 */
qcbc003       varchar2(40)      ,/* 料件編號 */
qcbc004       varchar2(256)      ,/* 產品特徵 */
qcbc005       varchar2(10)      ,/* 庫位 */
qcbc006       varchar2(10)      ,/* 儲位 */
qcbc007       varchar2(30)      ,/* 批號 */
qcbc008       varchar2(10)      ,/* 單位 */
qcbc009       number(20,6)      ,/* 判定數量 */
qcbc010       number(20,6)      ,/* 已入庫數 */
qcbc011       varchar2(255)      ,/* 庫存備註 */
qcbc012       varchar2(10)      ,/* 判定區分 */
qcbc013       varchar2(10)      ,/* 處理方式 */
qcbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbc_t add constraint qcbc_pk primary key (qcbcent,qcbcdocno,qcbcseq) enable validate;

create unique index qcbc_pk on qcbc_t (qcbcent,qcbcdocno,qcbcseq);

grant select on qcbc_t to tiptop;
grant update on qcbc_t to tiptop;
grant delete on qcbc_t to tiptop;
grant insert on qcbc_t to tiptop;

exit;
