/* 
================================================================================
檔案代號:qcbm_t
檔案名稱:樣本資料資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbm_t
(
qcbment       number(5)      ,/* 企業編號 */
qcbmsite       varchar2(10)      ,/* 營運據點 */
qcbm001       varchar2(20)      ,/* 檢驗單號 */
qcbm002       number(10,0)      ,/* 檢驗行序 */
qcbmseq       number(10,0)      ,/* 組號 */
qcbmseq1       number(10,0)      ,/* 序號 */
qcbm003       number(20,6)      ,/* 樣本測定值 */
qcbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbm_t add constraint qcbm_pk primary key (qcbment,qcbmsite,qcbm001,qcbm002,qcbmseq,qcbmseq1) enable validate;

create unique index qcbm_pk on qcbm_t (qcbment,qcbmsite,qcbm001,qcbm002,qcbmseq,qcbmseq1);

grant select on qcbm_t to tiptop;
grant update on qcbm_t to tiptop;
grant delete on qcbm_t to tiptop;
grant insert on qcbm_t to tiptop;

exit;
