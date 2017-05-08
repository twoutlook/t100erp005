/* 
================================================================================
檔案代號:bmjb_t
檔案名稱:ECR模板維護變更原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmjb_t
(
bmjbent       number(5)      ,/* 企業編號 */
bmjbsite       varchar2(10)      ,/* 營運據點 */
bmjbseq       number(10,0)      ,/* 項次 */
bmjbseq1       varchar2(10)      ,/* 項序 */
bmjb001       varchar2(10)      ,/* 模板編號 */
bmjb002       varchar2(10)      ,/* 分類 */
bmjb003       varchar2(10)      ,/* 變更內容 */
bmjb004       varchar2(1)      ,/* 回覆值類型 */
bmjbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmjbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmjbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmjbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmjbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmjbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmjbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmjbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmjbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmjbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmjbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmjbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmjbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmjbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmjbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmjbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmjbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmjbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmjbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmjbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmjbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmjbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmjbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmjbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmjbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmjbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmjbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmjbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmjbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmjbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmjb_t add constraint bmjb_pk primary key (bmjbent,bmjbseq,bmjbseq1,bmjb001) enable validate;

create unique index bmjb_pk on bmjb_t (bmjbent,bmjbseq,bmjbseq1,bmjb001);

grant select on bmjb_t to tiptop;
grant update on bmjb_t to tiptop;
grant delete on bmjb_t to tiptop;
grant insert on bmjb_t to tiptop;

exit;
