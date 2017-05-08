/* 
================================================================================
檔案代號:gzpe_t
檔案名稱:排程細項信件清單
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzpe_t
(
gzpeent       number(5)      ,/* 企業編號 */
gzpe001       varchar2(40)      ,/* 排程編號 */
gzpe002       number(5,0)      ,/* 序號 */
gzpe003       varchar2(1)      ,/* 執行狀況 */
gzpe004       varchar2(40)      ,/* 收件人員工編號 */
gzpe005       varchar2(255)      ,/* 信件主旨 */
gzpe006       varchar2(500)      ,/* 信件內文 */
gzpe007       varchar2(1)      ,/* 形式 */
gzpe008       varchar2(80)      ,/* 收件者名稱 */
gzpe009       varchar2(80)      ,/* E-mail Address(報表用) */
gzpe010       varchar2(1)      ,/* 報表mail檔案格式 */
gzpe011       number(5,0)      ,/* 執行狀況序號 */
gzpeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzpeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzpeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzpeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzpeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzpeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzpeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzpeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzpeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzpeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzpeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzpeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzpeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzpeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzpeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzpeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzpeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzpeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzpeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzpeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzpeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzpeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzpeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzpeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzpeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzpeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzpeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzpeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzpeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzpeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzpe012       varchar2(10)      /* 聯絡對象類型 */
);
alter table gzpe_t add constraint gzpe_pk primary key (gzpeent,gzpe001,gzpe002,gzpe003,gzpe011) enable validate;

create unique index gzpe_pk on gzpe_t (gzpeent,gzpe001,gzpe002,gzpe003,gzpe011);

grant select on gzpe_t to tiptop;
grant update on gzpe_t to tiptop;
grant delete on gzpe_t to tiptop;
grant insert on gzpe_t to tiptop;

exit;
