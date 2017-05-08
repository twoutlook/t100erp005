/* 
================================================================================
檔案代號:qcbg_t
檔案名稱:品質檢驗測量值檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbg_t
(
qcbgent       number(5)      ,/* 企業編號 */
qcbgsite       varchar2(10)      ,/* 營運據點 */
qcbgdocno       varchar2(20)      ,/* 單號 */
qcbgseq       number(10,0)      ,/* 行序 */
qcbg001       number(10,0)      ,/* 序號 */
qcbg002       number(20,6)      ,/* 測量值 */
qcbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
qcbg003       varchar2(1)      /* 合格 */
);
alter table qcbg_t add constraint qcbg_pk primary key (qcbgent,qcbgdocno,qcbgseq,qcbg001) enable validate;

create unique index qcbg_pk on qcbg_t (qcbgent,qcbgdocno,qcbgseq,qcbg001);

grant select on qcbg_t to tiptop;
grant update on qcbg_t to tiptop;
grant delete on qcbg_t to tiptop;
grant insert on qcbg_t to tiptop;

exit;
