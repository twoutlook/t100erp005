/* 
================================================================================
檔案代號:qcbj_t
檔案名稱:品質異常檢驗缺點原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbj_t
(
qcbjent       number(5)      ,/* 企業編號 */
qcbjsite       varchar2(10)      ,/* 營運據點 */
qcbjdocno       varchar2(20)      ,/* 品質異常單號 */
qcbjseq       number(10,0)      ,/* 行序 */
qcbj001       varchar2(10)      ,/* 缺點原因 */
qcbj002       number(20,6)      ,/* 缺點數 */
qcbj003       varchar2(255)      ,/* 備註 */
qcbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbj_t add constraint qcbj_pk primary key (qcbjent,qcbjdocno,qcbjseq,qcbj001) enable validate;

create unique index qcbj_pk on qcbj_t (qcbjent,qcbjdocno,qcbjseq,qcbj001);

grant select on qcbj_t to tiptop;
grant update on qcbj_t to tiptop;
grant delete on qcbj_t to tiptop;
grant insert on qcbj_t to tiptop;

exit;
