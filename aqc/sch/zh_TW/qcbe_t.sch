/* 
================================================================================
檔案代號:qcbe_t
檔案名稱:品質檢驗缺點原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbe_t
(
qcbeent       number(5)      ,/* 企業編號 */
qcbesite       varchar2(10)      ,/* 營運據點 */
qcbedocno       varchar2(20)      ,/* 單號 */
qcbeseq       number(10,0)      ,/* 行序 */
qcbe001       varchar2(10)      ,/* 缺點原因 */
qcbe002       number(20,6)      ,/* 數量 */
qcbe003       varchar2(255)      ,/* 備註 */
qcbe004       number(20,6)      ,/* 不良數 */
qcbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbe_t add constraint qcbe_pk primary key (qcbeent,qcbedocno,qcbeseq,qcbe001) enable validate;

create unique index qcbe_pk on qcbe_t (qcbeent,qcbedocno,qcbeseq,qcbe001);

grant select on qcbe_t to tiptop;
grant update on qcbe_t to tiptop;
grant delete on qcbe_t to tiptop;
grant insert on qcbe_t to tiptop;

exit;
