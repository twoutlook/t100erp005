/* 
================================================================================
檔案代號:bmkb_t
檔案名稱:ECR申請單變更原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmkb_t
(
bmkbent       number(5)      ,/* 企業編號 */
bmkbsite       varchar2(10)      ,/* 營運據點 */
bmkbdocno       varchar2(20)      ,/* 申請單號 */
bmkbseq       number(10,0)      ,/* 項次 */
bmkbseq1       number(10,0)      ,/* 項序 */
bmkb001       varchar2(10)      ,/* 分類 */
bmkb002       varchar2(10)      ,/* 變更內容 */
bmkb003       varchar2(1)      ,/* 回覆值 */
bmkb004       varchar2(80)      ,/* 說明 */
bmkbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmkbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmkbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmkbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmkbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmkbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmkbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmkbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmkbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmkbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmkbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmkbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmkbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmkbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmkbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmkbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmkbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmkbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmkbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmkbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmkbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmkbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmkbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmkbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmkbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmkbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmkbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmkbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmkbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmkbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmkb_t add constraint bmkb_pk primary key (bmkbent,bmkbdocno,bmkbseq,bmkbseq1) enable validate;

create unique index bmkb_pk on bmkb_t (bmkbent,bmkbdocno,bmkbseq,bmkbseq1);

grant select on bmkb_t to tiptop;
grant update on bmkb_t to tiptop;
grant delete on bmkb_t to tiptop;
grant insert on bmkb_t to tiptop;

exit;
