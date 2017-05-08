/* 
================================================================================
檔案代號:bcpb_t
檔案名稱:APP畫面動態產生設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bcpb_t
(
bcpbent       number(5)      ,/* 企業代碼 */
bcpbsite       varchar2(10)      ,/* 營運據點 */
bcpb001       varchar2(20)      ,/* 作業代號 */
bcpb002       number(10,0)      ,/* 畫面順序 */
bcpb003       varchar2(40)      ,/* 畫面欄位 */
bcpb004       varchar2(255)      ,/* 欄位說明 */
bcpb005       varchar2(1)      ,/* 顯示否 */
bcpb006       varchar2(255)      ,/* 備註 */
bcpbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bcpbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bcpbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bcpbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bcpbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bcpbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bcpbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bcpbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bcpbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bcpbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bcpbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bcpbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bcpbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bcpbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bcpbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bcpbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bcpbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bcpbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bcpbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bcpbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bcpbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bcpbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bcpbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bcpbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bcpbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bcpbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bcpbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bcpbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bcpbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bcpbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bcpb_t add constraint bcpb_pk primary key (bcpbent,bcpbsite,bcpb001,bcpb002) enable validate;

create unique index bcpb_pk on bcpb_t (bcpbent,bcpbsite,bcpb001,bcpb002);

grant select on bcpb_t to tiptop;
grant update on bcpb_t to tiptop;
grant delete on bcpb_t to tiptop;
grant insert on bcpb_t to tiptop;

exit;
