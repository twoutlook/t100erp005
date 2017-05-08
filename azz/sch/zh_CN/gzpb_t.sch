/* 
================================================================================
檔案代號:gzpb_t
檔案名稱:排程細項關係表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzpb_t
(
gzpbent       number(5)      ,/* 企業編號 */
gzpb001       varchar2(40)      ,/* 排程編號 */
gzpb002       number(5,0)      ,/* 序號 */
gzpb003       varchar2(20)      ,/* 執行作業 */
gzpb004       varchar2(500)      ,/* 傳入參數 */
gzpb005       varchar2(10)      ,/* 執行營運據點 */
gzpb006       number(5,0)      ,/* 執行順序 */
gzpb007       varchar2(20)      ,/* 執行使用者編號 */
gzpb008       number(10,0)      ,/* QBE編號 */
gzpb009       varchar2(80)      ,/* 報表樣板ID */
gzpbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzpbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzpbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzpbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzpbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzpbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzpbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzpbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzpbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzpbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzpbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzpbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzpbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzpbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzpbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzpbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzpbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzpbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzpbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzpbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzpbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzpbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzpbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzpbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzpbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzpbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzpbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzpbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzpbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzpbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzpb010       varchar2(20)      /* 任務執行主機 */
);
alter table gzpb_t add constraint gzpb_pk primary key (gzpbent,gzpb001,gzpb002) enable validate;

create unique index gzpb_pk on gzpb_t (gzpbent,gzpb001,gzpb002);

grant select on gzpb_t to tiptop;
grant update on gzpb_t to tiptop;
grant delete on gzpb_t to tiptop;
grant insert on gzpb_t to tiptop;

exit;
