/* 
================================================================================
檔案代號:glfb_t
檔案名稱:表報設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glfb_t
(
glfbent       number(5)      ,/* 企業編號 */
glfb001       varchar2(10)      ,/* 報表模板編號 */
glfbseq       number(10,0)      ,/* 行次 */
glfbseq1       varchar2(1)      ,/* 列次 */
glfb002       varchar2(10)      ,/* 報表項目編號 */
glfb003       number(5,0)      ,/* 報表行序 */
glfb004       varchar2(1)      ,/* 取數公式來源 */
glfb005       varchar2(500)      ,/* 數值取數公式 */
glfb006       number(10,0)      ,/* 畫面上面的行 */
glfb007       number(10,0)      ,/* 畫面上面的列 */
glfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glfb008       varchar2(24)      ,/* XBRL科目 */
glfb009       varchar2(1)      ,/* 百分比基準 */
glfb010       varchar2(1)      /* 呈現格式 */
);
alter table glfb_t add constraint glfb_pk primary key (glfbent,glfb001,glfbseq,glfbseq1) enable validate;

create unique index glfb_pk on glfb_t (glfbent,glfb001,glfbseq,glfbseq1);

grant select on glfb_t to tiptop;
grant update on glfb_t to tiptop;
grant delete on glfb_t to tiptop;
grant insert on glfb_t to tiptop;

exit;
