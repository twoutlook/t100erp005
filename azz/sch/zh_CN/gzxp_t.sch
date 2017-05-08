/* 
================================================================================
檔案代號:gzxp_t
檔案名稱:待追蹤單據紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxp_t
(
gzxpent       number(5)      ,/* 企業編號 */
gzxpstus       varchar2(10)      ,/* 狀態碼 */
gzxp001       varchar2(20)      ,/* 員工編號 */
gzxp002       varchar2(20)      ,/* 作業編號 */
gzxp003       varchar2(500)      ,/* 單據組合Key */
gzxp004       varchar2(80)      ,/* 未使用屬性 */
gzxp005       varchar2(80)      ,/* 未使用屬性 */
gzxp006       date      ,/* 單據日期 */
gzxp007       varchar2(80)      ,/* 分類 */
gzxp008       varchar2(80)      ,/* 說明 */
gzxp009       date      ,/* 建立追蹤時間 */
gzxp010       varchar2(10)      ,/* 資料存放營運據點 */
gzxpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxp_t add constraint gzxp_pk primary key (gzxpent,gzxp001,gzxp002,gzxp003) enable validate;

create unique index gzxp_pk on gzxp_t (gzxpent,gzxp001,gzxp002,gzxp003);

grant select on gzxp_t to tiptop;
grant update on gzxp_t to tiptop;
grant delete on gzxp_t to tiptop;
grant insert on gzxp_t to tiptop;

exit;
