/* 
================================================================================
檔案代號:gzzv_t
檔案名稱:作業公告設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzzv_t
(
gzzvent       number(5)      ,/* 企業編號 */
gzzvstus       varchar2(10)      ,/* 狀態碼 */
gzzv001       varchar2(20)      ,/* 作業編號 */
gzzv002       number(5,0)      ,/* 公告編號 */
gzzv003       varchar2(1)      ,/* 公告分類 */
gzzv004       clob      ,/* 公告內容 */
gzzv005       varchar2(20)      ,/* 發布人員 */
gzzv006       timestamp(0)      ,/* 起始日期 */
gzzv007       timestamp(0)      ,/* 結束日期 */
gzzvsite       varchar2(10)      ,/* 營運據點 */
gzzvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzzv_t add constraint gzzv_pk primary key (gzzvent,gzzv001,gzzv002,gzzvsite) enable validate;

create unique index gzzv_pk on gzzv_t (gzzvent,gzzv001,gzzv002,gzzvsite);

grant select on gzzv_t to tiptop;
grant update on gzzv_t to tiptop;
grant delete on gzzv_t to tiptop;
grant insert on gzzv_t to tiptop;

exit;
