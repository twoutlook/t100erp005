/* 
================================================================================
檔案代號:inpb_t
檔案名稱:盤點計劃流程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpb_t
(
inpbent       number(5)      ,/* 企業編號 */
inpbsite       varchar2(10)      ,/* 營運據點 */
inpbdocno       varchar2(20)      ,/* 計劃單號 */
inpbseq       number(10,0)      ,/* 項次 */
inpb001       varchar2(20)      ,/* 盤點作業 */
inpb002       varchar2(1)      ,/* 進度狀況 */
inpb003       number(20,6)      ,/* 處理進度 */
inpb004       varchar2(20)      ,/* 負責人員 */
inpb005       date      ,/* 預計日期 */
inpb006       varchar2(20)      ,/* 操作人員 */
inpb007       date      ,/* 實際操作日期 */
inpb008       varchar2(255)      ,/* 備註 */
inpbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpb_t add constraint inpb_pk primary key (inpbent,inpbdocno,inpbseq) enable validate;

create unique index inpb_pk on inpb_t (inpbent,inpbdocno,inpbseq);

grant select on inpb_t to tiptop;
grant update on inpb_t to tiptop;
grant delete on inpb_t to tiptop;
grant insert on inpb_t to tiptop;

exit;
