/* 
================================================================================
檔案代號:sfpb_t
檔案名稱:工單派工記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfpb_t
(
sfpbent       number(5)      ,/* 企業代碼 */
sfpbsite       varchar2(10)      ,/* 營運據點 */
sfpb000       varchar2(1)      ,/* 派工類型 */
sfpb001       date      ,/* 生產日期 */
sfpb002       varchar2(10)      ,/* 工作站 */
sfpb003       varchar2(20)      ,/* 機器編號 */
sfpb004       varchar2(10)      ,/* 班別 */
sfpb005       varchar2(10)      ,/* 組別 */
sfpb006       varchar2(20)      ,/* 工單單號 */
sfpb007       number(10,0)      ,/* Runcard */
sfpb008       varchar2(10)      ,/* 作業編號 */
sfpb009       varchar2(10)      ,/* 作業序 */
sfpb010       number(20,6)      ,/* 派工數量 */
sfpb011       varchar2(10)      ,/* 單位 */
sfpb012       number(15,3)      ,/* 標準工時 */
sfpb013       number(15,3)      ,/* 所需工時 */
sfpbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfpbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfpbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfpbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfpbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfpbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfpbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfpbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfpbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfpbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfpbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfpbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfpbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfpbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfpbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfpbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfpbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfpbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfpbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfpbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfpbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfpbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfpbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfpbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfpbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfpbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfpbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfpbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfpbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfpbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfpb_t add constraint sfpb_pk primary key (sfpbent,sfpbsite,sfpb001,sfpb002,sfpb003,sfpb004,sfpb005,sfpb006,sfpb007,sfpb008,sfpb009) enable validate;

create unique index sfpb_pk on sfpb_t (sfpbent,sfpbsite,sfpb001,sfpb002,sfpb003,sfpb004,sfpb005,sfpb006,sfpb007,sfpb008,sfpb009);

grant select on sfpb_t to tiptop;
grant update on sfpb_t to tiptop;
grant delete on sfpb_t to tiptop;
grant insert on sfpb_t to tiptop;

exit;
