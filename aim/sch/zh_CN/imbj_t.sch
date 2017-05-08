/* 
================================================================================
檔案代號:imbj_t
檔案名稱:料件申請料號成份與物質檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imbj_t
(
imbjent       number(5)      ,/* 企業編號 */
imbj001       varchar2(40)      ,/* 料件編號 */
imbj002       varchar2(10)      ,/* 類型 */
imbj003       varchar2(10)      ,/* 成份/物質 */
imbj004       number(20,6)      ,/* 含量 */
imbj005       varchar2(10)      ,/* 單位 */
imbj006       varchar2(10)      ,/* 管制類型 */
imbjdocno       varchar2(20)      ,/* 單據編號 */
imbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbj_t add constraint imbj_pk primary key (imbjent,imbj002,imbj003,imbjdocno) enable validate;

create  index imbj_01 on imbj_t (imbj001);
create unique index imbj_pk on imbj_t (imbjent,imbj002,imbj003,imbjdocno);

grant select on imbj_t to tiptop;
grant update on imbj_t to tiptop;
grant delete on imbj_t to tiptop;
grant insert on imbj_t to tiptop;

exit;
