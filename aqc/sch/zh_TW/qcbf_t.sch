/* 
================================================================================
檔案代號:qcbf_t
檔案名稱:品質檢驗問題製造批序號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbf_t
(
qcbfent       number(5)      ,/* 企業編號 */
qcbfsite       varchar2(10)      ,/* 營運據點 */
qcbfdocno       varchar2(20)      ,/* 單號 */
qcbfseq       number(10,0)      ,/* 行序 */
qcbf001       varchar2(10)      ,/* 不良原因 */
qcbf002       varchar2(30)      ,/* 問題製造序號 */
qcbf003       varchar2(30)      ,/* 問題製造批號 */
qcbf004       number(20,6)      ,/* 數量 */
qcbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbf_t add constraint qcbf_pk primary key (qcbfent,qcbfdocno,qcbfseq,qcbf001,qcbf002,qcbf003) enable validate;

create unique index qcbf_pk on qcbf_t (qcbfent,qcbfdocno,qcbfseq,qcbf001,qcbf002,qcbf003);

grant select on qcbf_t to tiptop;
grant update on qcbf_t to tiptop;
grant delete on qcbf_t to tiptop;
grant insert on qcbf_t to tiptop;

exit;
